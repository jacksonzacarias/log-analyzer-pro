#!/usr/bin/env bash

# ===================================================================================
# Script Avançado de Análise de Logs de Segurança e Continuidade de Negócios
# ACADe-TI - Aula 04 (28/06/2025)
# Autor: Jackson Savoldi | Professor: Erick Martinez
# Versão: Sem dependência do jq
# ===================================================================================

# Carrega configuração centralizada
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
CONFIG_FILE="$PROJECT_ROOT/config/paths.conf"

if [[ -f "$CONFIG_FILE" ]]; then
    source "$CONFIG_FILE"
else
    echo "❌ Arquivo de configuração não encontrado: $CONFIG_FILE"
    exit 1
fi

print_help() {
  cat <<EOF

Uso: $0 [opções] <arquivo_de_log>

Opções:
  -v         Verboso (detalha tudo no terminal)
  -t         Explica IPs TEST-NET (RFC5737) e geolocaliza externos
  -aR        Sugestões automáticas de ações defensivas
  -gT        Gera timeline cronológica por IP
  -pedago    Modo pedagógico (explicações extra)
  -pcn       Gera seção Plano de Continuidade de Negócios
  -r <file>  Nome do relatório HTML (padrão: relatorio.html)
  -h, --help Exibe esta ajuda

Exemplo:
  $0 -v -t -aR -gT -pedago -pcn -r relatorio.html logs.log

EOF
  exit 1
}

# -------------------------------------------------------------------------------
# Processa parâmetros
# -------------------------------------------------------------------------------
VERBOSE=false
EXPLICA_TESTNET=false
ACTION_REC=false
TIMELINE=false
PEDAGO=false
PCN=false
REPORT="relatorio.html"
LOG=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    -v)       VERBOSE=true ;;
    -t)       EXPLICA_TESTNET=true ;;
    -aR)      ACTION_REC=true ;;
    -gT)      TIMELINE=true ;;
    -pedago)  PEDAGO=true ;;
    -pcn)     PCN=true ;;
    -r)       REPORT="$2"; shift ;;
    -h|--help) print_help ;;
    -*)
      echo "❌ Opção desconhecida: $1"
      print_help ;;
    *)
      if [[ -z "$LOG" ]]; then
        LOG="$1"
      else
        echo "❌ Múltiplos arquivos: '$LOG' e '$1'"
        exit 1
      fi
      ;;
  esac
  shift
done

if [[ -z "$LOG" || ! -f "$LOG" ]]; then
  echo "❌ Erro: arquivo de log não informado ou não encontrado!"
  print_help
fi

# -------------------------------------------------------------------------------
# Dependências (sem jq)
# -------------------------------------------------------------------------------
for cmd in grep awk sed sort uniq column curl; do
  command -v "$cmd" &>/dev/null || {
    echo "❌ Instale: $cmd"
    exit 1
  }
done

# -------------------------------------------------------------------------------
# Cores e estilo
# -------------------------------------------------------------------------------
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
BOLD="\e[1m"
RESET="\e[0m"

# Converte timestamp 
to_epoch() {
  date --date="$1" +%s
}

declare -A LAST_MALICIOUS_TS
WINDOW=300  # Aumentado para 5 minutos para capturar ataques mais realistas

is_suspect_backup() {
  local usr="$1"
  local ts="$2"
  local act="$3"

  # ✅ CORREÇÃO: Regex melhorada para detectar atividades maliciosas
  if [[ "$act" =~ (shell\.php|malicioso|reverse shell|shell reverse|trojan|backdoor|virus) ]]; then
    LAST_MALICIOUS_TS["$usr"]="$ts"
    return 1
  fi

  # ✅ CORREÇÃO: Regex melhorada para detectar backups
  if [[ "$act" =~ (backup\.(zip|tar\.gz|rar|7z)|Backup (iniciado|conclu[ií]do)) ]]; then
    local last="${LAST_MALICIOUS_TS[$usr]}"
    if [[ -n "$last" ]]; then
      local delta=$(( $(to_epoch "$ts") - $(to_epoch "$last") ))
      if (( delta <= WINDOW )); then
        SUS_REASON="Backup pós-atividade maliciosa (${delta}s)"
        return 0
      fi
    fi
  fi

  return 1
}

color_ia() {
  local label="$1"
  case "$label" in
    System\ Maintenance) echo -e "${BLUE}${BOLD}$label${RESET}" ;;
    SUSPEITO|Brute\ Force|SQL\ Injection|XSS|LFI|RFI/SSRF|Command\ Injection|Webshell\ Upload|Malicious\ File|Port\ Scan|Enumeration|Privilege\ Escalation|Denial\ of\ Service|Suspicious\ Download|Unauthorized\ Access)
      echo -e "${RED}${BOLD}$label${RESET}" ;;
    RUÍDO)
      echo -e "${YELLOW}${BOLD}$label${RESET}" ;;
    *) 
      echo -e "${GREEN}${BOLD}$label${RESET}" ;;
  esac
}

# -------------------------------------------------------------------------------
# Função "pseudo-IA" em Bash: zero-shot por regex
# -------------------------------------------------------------------------------
classify_attack() {
  local line="$1"

  if [[ "$line" =~ Verificação[[:space:]]antiv[ií]rus|Backup[[:space:]]iniciado|Atualização[[:space:]]automática ]]; then
    echo "System Maintenance"
    return
  fi

  declare -A PATTERNS=(
    ["Brute Force"]="for(a|ã) bruta|failed login|authentication failure|invalid user"
    ["SQL Injection"]="select[[:space:]].*from|union[[:space:]].*select|or[[:space:]]1=1|--|xp_cmdshell|information_schema"
    ["XSS"]="<script|onerror=|javascript:|<iframe|<img|document\.cookie"
    ["LFI"]="\.\./|\.\.\\\\|include[[:space:]].*\.\.|etc/passwd"
    ["RFI/SSRF"]="(http|https|ftp)://|curl[[:space:]]|wget[[:space:]]"
    ['Command Injection']=';[[:space:]]*(ls|cat|whoami|id)\b|\$\([^)]*\)|`[^`]*`|&&|chmod[[:space:]]|nc[[:space:]]'
    ["Webshell Upload"]="upload.*\.(php|asp|jsp|exe|sh|bat|cmd|pl|py)"
    ["Malicious File"]="malicioso|trojan|virus|backdoor|reverse shell"
    ["Port Scan"]="nmap|masscan|scan ports|scan ip|zmap"
    ["Enumeration"]="enum(era(te|tion))?|userlist|account enumeration|brute user"
    ["Privilege Escalation"]="sudo|su -|setuid|setgid|root shell"
    ["Denial of Service"]="denial of service|ddos|flood|syn flood"
    ["Suspicious Download"]="download.*\.(exe|bin|scr|dll|iso|msi)"
    ["Unauthorized Access"]="login falha|permission denied|acesso negado|erro de permissão"
    ["Sensitive File"]="\b(senha|passwd|credentials|secret|token|key|id_rsa)\b|\.(txt|csv|pem|key)$"
    ["Backup Completed"]="Backup\s+(iniciado|conclu[ií]do)|backup\s+(iniciado|conclu[ií]do)"
    ["Antivirus Scan"]="Verifica(c|ç)[ãa]o\s+antiv[ií]rus|antiv[ií]rus\s+scan|scan\s+antiv[ií]rus"
    ["System Update"]="Atualiza(c|ç)[ãa]o\s+autom[aá]tica|update\s+autom[aá]tico"
    ["Login Success"]="Login\s+sucesso|authentication\s+success"
    ["Configuration Change"]="configura(c|ç)[ãa]o\s+alterada|change\s+config|settings\s+updated"
    ["File Download"]="Download\s+arquivo:.*\.(pdf|xlsx|docx?|zip)"
    ["Data Query"]="Consulta\s+registro|select\s+.*from\s+table"
    ["User Action"]="logou|logoff|saiu"
  )

  for label in "${!PATTERNS[@]}"; do
    if [[ "$line" =~ ${PATTERNS[$label]} ]]; then
      echo "$label"
      return
    fi
  done

  echo "Normal"
}

# -------------------------------------------------------------------------------
# Heurística de login suspeito / enumeração com motivo
# -------------------------------------------------------------------------------
is_suspect_login() {
  local ip=$1
  local usr=$2
  local act=$3

  if [[ "$act" =~ [Ll]ogin[[:space:]]+sucesso ]]; then
    local fails=${FAIL_COUNT[$ip]:-0}
    if (( fails >= 2 )); then
      echo "Login Suspeito (${fails} falhas)"
      return 0
    fi
  fi

  if [[ "$act" =~ [Ll]ogin[[:space:]]+falha ]]; then
    IFS='|' read -r -a seq <<<"${USER_SEQ_BY_IP[$ip]}"
 
    local uniq_users
    uniq_users=$(printf "%s\n" "${seq[@]}" | grep -v '^$' | sort -u | wc -l)
    if (( uniq_users >= 2 )); then
      echo "Enumeração Suspeita (${uniq_users} usuários)"
      return 0
    fi
  fi

  return 1
}

# -------------------------------------------------------------------------------
# Nova função de explicação de IP (sem geolocalização)
# -------------------------------------------------------------------------------
explain_ip() {
  local ip="$1"
  if [[ $ip =~ ^127\. ]]; then
    echo -e "Loopback (127.0.0.0/8) – reservado para host local"
  elif [[ $ip =~ ^10\.|^192\.168\.|^172\.(1[6-9]|2[0-9]|3[0-1])\. ]]; then
    echo -e "Privado (RFC1918) – não roteável na internet"
  elif [[ $ip =~ ^(192\.0\.2|198\.51\.100|203\.0\.113)\. ]]; then
    echo -e "TEST-NET (RFC5737) – bloco usado apenas para documentação e testes"
  else
    echo -e "Externo – IP público da internet"
  fi
}

# -------------------------------------------------------------------------------
# Funções utilitárias
# -------------------------------------------------------------------------------
is_internal() {
  [[ $1 =~ ^127\.|^10\.|^192\.168\.|^172\.(1[6-9]|2[0-9]|3[0-1])\. ]]
}

analyze_payload() {
  local t="$1"
  if grep -Fqi "Força bruta" <<<"$t"; then
    echo "Brute-force: múltiplas falhas"
  elif grep -Fqi "select " <<<"$t"; then
    echo "SQLi: extração de dados"
  elif grep -Fqi "union " <<<"$t"; then
    echo "SQLi: payload UNION"
  elif grep -Fqi "or 1=1" <<<"$t"; then
    echo "SQLi: bypass"
  elif grep -Fqi -- "--" <<<"$t"; then
    echo "SQLi: comentário"
  elif grep -Fqi ".php" <<<"$t"; then
    echo "Webshell: PHP"
  elif grep -Fqi "<script" <<<"$t"; then
    echo "XSS: inserção"
  else
    echo "Suspeito: não categorizado"
  fi
}

classify_line() {
  local a="$1"
  if grep -Eqi "SQL Injection|shell\.php|malicioso|Força bruta|<script>" <<<"$a"; then
    echo SUSPEITO
  elif grep -Eqi "antivírus|backup|atualização" <<<"$a"; then
    echo RUIDO
  else
    echo NORMAL
  fi
}

print_classification() {
  case $1 in
    SUSPEITO) echo -e "${RED}${BOLD}🔴 SUSPEITO${RESET}" ;;
    RUIDO)    echo -e "${YELLOW}${BOLD}🟡 RUÍDO${RESET}" ;;
    NORMAL)   echo -e "${GREEN}${BOLD}🟢 NORMAL${RESET}" ;;
  esac
}

print_login_stats() {
  echo -e "${BOLD}📈 Estatísticas de Login por IP e Usuário${RESET}"
  for ip in "${!EVENTS_BY_IP[@]}"; do
    users=$(printf "%s\n" "${LOG_LINES[@]}" \
      | grep "IP: $ip" \
      | grep -Ei 'login falha|login sucesso' \
      | grep -Eo 'user: [^ ]+' | awk '{print $2}' | sort -u)
    count=$(echo "$users" | grep -c .)
    (( count > 0 )) && echo "- IP $ip → $count usuário(s): $users"
  done
  echo
  echo -e "${BOLD}👥 Estatísticas de Acesso por Usuário${RESET}"
  for usr in "${!EVENTS_BY_USER[@]}"; do
    ips=$(printf "%s\n" "${LOG_LINES[@]}" \
      | grep "user: $usr" \
      | grep -Eo 'IP: [0-9.]+' | awk '{print $2}' | sort -u)
    count=$(echo "$ips" | grep -c .)
    (( count > 1 )) && echo "- Usuário $usr → $count IP(s): $ips"
  done
  echo
}

# -------------------------------------------------------------------------------
# Carrega e organiza logs
# -------------------------------------------------------------------------------
declare -A FAIL_COUNT SUCCESS_COUNT EVENTS_BY_IP EVENTS_BY_USER USER_SEQ_BY_IP

# 1) Lê TODO o arquivo, ordena por data e hora (colunas 1 e 2) e armazena em SORTED_RAW
while IFS= read -r L; do
  SORTED_RAW+=( "$L" )
done < <(sort -k1,1 -k2,2 "$LOG")

# 2) Agora popula LOG_LINES a partir do array já ordenado
LOG_LINES=()
for L in "${SORTED_RAW[@]}"; do
  LOG_LINES+=( "$L" )
done

for L in "${LOG_LINES[@]}"; do
  ip=$(grep -Eo 'IP: [0-9.]+' <<<"$L" | awk '{print $2}')
  usr=$(grep -Eo 'user: [^ ]+'   <<<"$L" | awk '{print $2}')
  act=$(grep -Eo 'ação: .*'      <<<"$L" | sed 's/ação: //')
  EVENTS_BY_IP["$ip"]+="$act|"
  EVENTS_BY_USER["$usr"]+="$act|"
  USER_SEQ_BY_IP["$ip"]+="$usr|" 
  [[ $act =~ [Ll]ogin\ falha ]]   && ((FAIL_COUNT["$ip"]++))
  [[ $act =~ [Ll]ogin\ sucesso ]] && ((SUCCESS_COUNT["$ip"]++))
done

SUS_EVENTS=$(printf "%s\n" "${LOG_LINES[@]}" \
  | grep -Ei "falha|malicioso|SQL Injection|shell\.php|<script>")

# -------------------------------------------------------------------------------
# 1) Visão Geral
# -------------------------------------------------------------------------------
total_lines=${#LOG_LINES[@]}; sus_lines=0; noise_lines=0; norm_lines=0
for L in "${LOG_LINES[@]}"; do
  act=$(grep -Eo 'ação: .*'<<<"$L" | sed 's/ação: //')
  case $(classify_line "$act") in
    SUSPEITO) ((sus_lines++)) ;;
    RUIDO)    ((noise_lines++)) ;;
    NORMAL)   ((norm_lines++)) ;;
  esac
done

echo -e "${BLUE}${BOLD}📋 Visão Geral${RESET}"
echo "  Total de linhas processadas: $total_lines"
echo "  Linhas suspeitas: $sus_lines"
echo "  Linhas classificadas como ruído: $noise_lines"
echo "  Linhas normais: $norm_lines"
echo "  IPs com atividades suspeitas: $(
  for ip in "${!EVENTS_BY_IP[@]}"; do
    grep -Eqi "SQL Injection|shell\.php|malicioso|Força bruta"<<<"${EVENTS_BY_IP[$ip]}" \
      && echo $ip
  done | wc -l
)"
echo "  Usuários envolvidos em atividades suspeitas: $(
  for u in "${!EVENTS_BY_USER[@]}"; do
    grep -Eqi "SQL Injection|shell\.php|malicioso|Força bruta"<<<"${EVENTS_BY_USER[$u]}" \
      && echo $u
  done | wc -l
)"
echo

# -------------------------------------------------------------------------------
# 2) Classificação linha a linha
# -------------------------------------------------------------------------------
if $VERBOSE; then
  echo -e "${BLUE}${BOLD}📑 Classificação linha a linha:${RESET}"

  CLF_W=14       
  DATA_W=19      
  IP_W=15       
  USER_W=12      
  ACTION_W=50   
  TAGS_W=30

  TOTAL_W=$(( CLF_W + DATA_W + IP_W + USER_W + ACTION_W + 3*3 + 2 ))

  SEP=$(printf '%*s' "$TOTAL_W" '' | tr ' ' '-')

  echo "$SEP"
  printf " %-${CLF_W}s | %-${DATA_W}s | %-${IP_W}s | %-${USER_W}s | %-${ACTION_W}s \n" \
    "Clf" "Data" "IP" "Usuário" "Ação"
  echo "$SEP"

  for L in "${LOG_LINES[@]}"; do
    ts=$(awk '{print $1" "$2}'   <<<"$L")
    ip=$(grep -Eo 'IP: [0-9.]+'   <<<"$L" | awk '{print $2}')
    usr=$(grep -Eo 'user: [^ ]+'   <<<"$L" | awk '{print $2}')
    act=$(grep -Eo 'ação: .*'      <<<"$L" | sed 's/ação: //')
    tags=()

    cls=$(classify_line "$act")
    icon=$(print_classification "$cls")
    
    # Detecta múltiplas categorias sem sobrescrever
    tags=()
    if is_suspect_backup "$usr" "$ts" "$act"; then
      tags+=( "🔴 $SUS_REASON" )
    fi
    if suspect_label=$(is_suspect_login "$ip" "$usr" "$act"); then
      tags+=( "🔴 $suspect_label" )
    fi

    tag_str=""
    if (( ${#tags[@]} )); then
      tag_str=$(IFS=', '; echo "${tags[*]}")
    fi

    printf " %-${CLF_W}b | %-${DATA_W}s | %-${IP_W}s | %-${USER_W}s | %-${ACTION_W}s\n" \
     "$icon" "$ts" "$ip" "$usr" "$act"

    if $PEDAGO && [[ $cls == "SUSPEITO" ]]; then
      echo "    ➔ $(analyze_payload "$act")"
      (( FAIL_COUNT[$ip] > 1 )) && echo "    ➔ ${FAIL_COUNT[$ip]} falhas de login em $ip"
    fi

    ia_label=$(classify_attack "$L")
    if [[ "$ia_label" != "Normal" ]]; then
      case "$ia_label" in
        Sensitive\ File|Malicious\ File|Webshell\ Upload|Command\ Injection)
          ia_colored="${RED}${BOLD}$ia_label${RESET}" ;;
        Login\ Success|Backup\ Completed|Antivirus\ Scan|System\ Update|Configuration\ Change|File\ Download|Data\ Query|User\ Action)
          ia_colored="${GREEN}${BOLD}$ia_label${RESET}" ;;
        *)
          ia_colored="${YELLOW}${BOLD}$ia_label${RESET}" ;;
      esac
      printf "    ➔ Classificação IA: %b\n" "$ia_colored"
      printf "  %b\n" "$tag_str"
    fi

    echo "$SEP"
  done

  echo
fi

# -------------------------------------------------------------------------------
# 3) Eventos Suspeitos Detectados
# -------------------------------------------------------------------------------
echo -e "${RED}${BOLD}🔍 Eventos Suspeitos Detectados:${RESET}"
printf "%s\n" "${LOG_LINES[@]}" \
  | grep -Ei "SQL Injection|shell\.php|malicioso|Força bruta|<script>" \
  | sed 's/^/  ⚠ /'
echo

# -------------------------------------------------------------------------------
# 4) IPs Maliciosos e Geolocalização
# -------------------------------------------------------------------------------
echo -e "${BLUE}${BOLD}🌐 IPs Maliciosos e Classificação:${RESET}"
for ip in $(printf "%s\n" "${!EVENTS_BY_IP[@]}"); do
  if grep -Eqi "SQL Injection|shell\.php|malicioso|Força bruta|<script>" \
    <<<"${EVENTS_BY_IP[$ip]}"; then
    echo -e "  - ${BOLD}$ip${RESET} → $(explain_ip "$ip")"
  fi
done
echo

# -------------------------------------------------------------------------------
# 5) Resumo por IP – Tipo de Ataque e Objetivo
# -------------------------------------------------------------------------------
echo -e "${BLUE}${BOLD}📊 Resumo por IP – Ataque e Objetivo:${RESET}"
for ip in $(printf "%s\n" "${!EVENTS_BY_IP[@]}"); do
  attacks=$(grep -Eoi "SQL Injection|shell\.php|malicioso|Força bruta|<script>" \
            <<<"${EVENTS_BY_IP[$ip]}" | sort -u | paste -sd", ")
  [[ -n "$attacks" ]] && echo "  • $ip → $attacks"
done
echo

print_login_stats

# -------------------------------------------------------------------------------
# 6) Timeline por IP
# -------------------------------------------------------------------------------
if $TIMELINE; then
  echo -e "${BLUE}${BOLD}🕒 Timeline por IP:${RESET}"
  for ip in $(printf "%s\n" "${!EVENTS_BY_IP[@]}"); do
    echo
    echo -e "  ${BOLD}IP: $ip${RESET}"

    if $EXPLICA_TESTNET; then
      echo -e "    ➔ $(explain_ip "$ip")"
    fi

    printf "%s\n" "${LOG_LINES[@]}" \
      | grep "IP: $ip" \
      | while read -r L; do
          ts=$(awk '{print $1" "$2}' <<<"$L")
          usr=$(grep -Eo 'user: [^ ]+' <<<"$L" | awk '{print $2}')
          act=$(grep -Eo 'ação: .*' <<<"$L" | sed 's/ação: //')
          echo -e "    - $ts | IP: $ip | user: ${BOLD}$usr${RESET} | ação: $act"
        done
  done
  echo
fi

# -------------------------------------------------------------------------------
# 7) Possíveis Exfiltrações de Dados
# -------------------------------------------------------------------------------
echo -e "${RED}${BOLD}🔻 Possíveis Exfiltrações de Dados:${RESET}"
grep -i "download arquivo" "$LOG" | grep -Ev "(pdf|xlsx|doc|zip)" \
  && echo "  • Detectado download fora do padrão" \
  || echo "  • Nenhuma detectada"
echo

# -------------------------------------------------------------------------------
# 8) Recomendações
# -------------------------------------------------------------------------------
if $ACTION_REC; then
  echo -e "${GREEN}${BOLD}🛡 Ações Recomendadas:${RESET}"
  echo "  - Ativar WAF contra SQLi, XSS, RFI"
  echo "  - Implementar MFA em contas sensíveis"
  echo "  - Monitorar uploads/downloads com DLP/Sandbox"
  echo "  - Configurar Fail2Ban para múltiplas falhas de login"
  echo "  - Revisar regras de firewall e segmentação"
  echo
fi

# -------------------------------------------------------------------------------
# 9) Plano de Continuidade de Negócios (PCN)
# -------------------------------------------------------------------------------
if $PCN; then
  echo -e "${YELLOW}${BOLD}📘 Plano de Continuidade:${RESET}"
  echo "  • Ativos críticos: Web, DB, Sistemas Internos"
  echo "  • RTO sugerido: < 1 hora"
  echo "  • RPO sugerido: < 15 minutos"
  echo "  • Estratégias: restore de backups limpos, patch imediato"
  echo "  • Comunicação: SOC → TI → Diretoria"
  echo
fi

echo -e "${GREEN}${BOLD}✅ Análise concluída!${RESET}" 