#!/bin/bash

# ===================================================================================
# Script Avançado de Análise de Logs de Segurança - Versão 4.0
# Análise Abrangente com Classificação por Peso e Detecção Avançada
# Suporte Multi-Formato: Apache, SSH, MySQL, Nginx, Logs Customizados
# Cores Aprimoradas e Todas as Funções Otimizadas
# Script Avançado de Análise de Logs de Segurança e Continuidade de Negócios
# ACADe-TI - Aula 04 (28/06/2025)
# Autor: Jackson Savoldi | Professor: Erick Martinez
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

${BOLD}${CYAN}🔍 ANÁLISE AVANÇADA DE LOGS DE SEGURANÇA E CONTINUIDADE DE NEGÓCIOS${RESET}
${BOLD}${CYAN}================================================================${RESET}

${BOLD}ACADe-TI - Aula 04 (28/06/2025)${RESET}
${BOLD}Autor: Jackson Savoldi | Professor: Erick Martinez${RESET}

${BOLD}Descrição:${RESET}
  Ferramenta completa para análise de logs de segurança com detecção automática
  de ameaças, classificação por peso, correlação de eventos e recomendações
  de continuidade de negócios.

${BOLD}Uso:${RESET} $0 [opções] <arquivo_de_log>

${BOLD}Opções Principais:${RESET}
  -v         Verboso (detalha tudo no terminal)
  -t         Explica IPs TEST-NET (RFC5737) e geolocaliza externos
  -aR        Sugestões automáticas de ações defensivas
  -gT        Gera timeline cronológica por IP
  -pedago    Modo pedagógico (explicações extra)
  -pcn       Gera seção Plano de Continuidade de Negócios
  -peso      Análise por peso de ameaça (CRÍTICO, ALTO, MÉDIO, BAIXO)
  -correl    Correlação de eventos por usuário/IP
  -train     Sistema de treinamento (adicionar novos padrões de regex)
  -r <file>  Nome do relatório HTML (padrão: relatorio_avancado.html)
  -h, --help Exibe esta ajuda

${BOLD}Exemplos:${RESET}
  $0 -v -t -aR -gT -pedago -pcn -peso -correl -r relatorio.html logs.log
  $0 -v -pedago apache_access.log
  $0 -v -t -aR nginx_error.log

${BOLD}Classificação de Ameaças:${RESET}
  🔴 CRÍTICO (10+ pts): Ameaças graves que comprometem a segurança
  🟣 ALTO (7-9 pts): Ameaças significativas que requerem atenção
  🟡 MÉDIO (4-6 pts): Ameaças moderadas que devem ser monitoradas
  🔵 BAIXO (1-3 pts): Atividades suspeitas de baixo impacto
  🟢 INFO (0 pts): Atividades normais do sistema

${BOLD}Formatos Suportados:${RESET}
  - Apache Access/Error Logs
  - SSH Authentication Logs
  - MySQL Logs
  - Nginx Access/Error Logs
  - Logs Customizados

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
PESO=false
CORREL=false
TRAIN=false
REPORT="relatorio_avancado.html"
LOG=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    -v)       VERBOSE=true ;;
    -t)       EXPLICA_TESTNET=true ;;
    -aR)      ACTION_REC=true ;;
    -gT)      TIMELINE=true ;;
    -pedago)  PEDAGO=true ;;
    -pcn)     PCN=true ;;
    -peso)    PESO=true ;;
    -correl)  CORREL=true ;;
    -train)   TRAIN=true ;;
    -r)       REPORT="$2"; shift ;;
    -h|--help) print_help ;;
    -*)
      echo -e "${RED}${BOLD}❌ Opção desconhecida: $1${RESET}"
      print_help ;;
    *)
      if [[ -z "$LOG" ]]; then
        LOG="$1"
      else
        echo -e "${RED}${BOLD}❌ Múltiplos arquivos: '$LOG' e '$1'${RESET}"
        exit 1
      fi
      ;;
  esac
  shift
done

if [[ -z "$LOG" || ! -f "$LOG" ]]; then
  if $TRAIN; then
    # Modo de treinamento não precisa de arquivo de log
    echo -e "${CYAN}${BOLD}🎓 Modo de treinamento ativado${RESET}"
  else
    echo -e "${RED}${BOLD}❌ Erro: arquivo de log não informado ou não encontrado!${RESET}"
    print_help
  fi
fi

# -------------------------------------------------------------------------------
# Dependências
# -------------------------------------------------------------------------------
for cmd in grep awk sed sort uniq curl jq; do
  command -v "$cmd" &>/dev/null || {
    echo -e "${RED}${BOLD}❌ Instale: $cmd${RESET}"
    exit 1
  }
done

# -------------------------------------------------------------------------------
# Cores e estilo APRIMORADOS
# -------------------------------------------------------------------------------
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
WHITE="\e[37m"
BOLD="\e[1m"
UNDERLINE="\e[4m"
BLINK="\e[5m"
RESET="\e[0m"

# Cores de fundo
BG_RED="\e[41m"
BG_GREEN="\e[42m"
BG_YELLOW="\e[43m"
BG_BLUE="\e[44m"
BG_MAGENTA="\e[45m"
BG_CYAN="\e[46m"

# -------------------------------------------------------------------------------
# Sistema de Aprendizado Contínuo - Classificação Inteligente de Ataques
# Permite treinar o script com novos padrões de regex e expandir a detecção
# -------------------------------------------------------------------------------

# Arquivo de configuração para padrões de aprendizado (usando caminho centralizado)
LEARNING_CONFIG_FILE="$ATTACK_PATTERNS_FILE"

# Função para inicializar arquivo de aprendizado se não existir
init_learning_system() {
    if [[ ! -f "$LEARNING_CONFIG_FILE" ]]; then
        cat > "$LEARNING_CONFIG_FILE" << 'EOF'
# ===================================================================================
# SISTEMA DE APRENDIZADO CONTÍNUO - PADRÕES DE ATAQUES
# ===================================================================================
# Formato: PADRÃO|CATEGORIA|DESCRIÇÃO|PESO|TAGS
# Exemplo: "nikto|Scanner|Scanner de vulnerabilidades web|7|scanner,web,automated"
# ===================================================================================

# PADRÕES EXISTENTES (BASE)
reverse shell|CRÍTICO|Reverse shell detectado|10|shell,backdoor,crítico
shell\.php|CRÍTICO|Arquivo shell malicioso|10|shell,backdoor,crítico
backdoor|CRÍTICO|Backdoor detectado|10|backdoor,malware,crítico
trojan|CRÍTICO|Trojan detectado|10|trojan,malware,crítico
virus|CRÍTICO|Vírus detectado|10|virus,malware,crítico
root shell|CRÍTICO|Shell com privilégios root|10|shell,privilege,crítico
privilege escalation|CRÍTICO|Elevação de privilégios|10|privilege,escalation,crítico
data exfiltration|CRÍTICO|Exfiltração de dados|10|data,exfiltration,crítico
malicioso.*shell|CRÍTICO|Shell malicioso|10|shell,malicioso,crítico
Comando injetado|CRÍTICO|Comando injetado|10|injection,command,crítico
cat /flag|CRÍTICO|Tentativa de ler flag|10|flag,read,crítico
whoami|CRÍTICO|Comando whoami|10|enumeration,user,crítico
ls;.*cat|CRÍTICO|Comandos concatenados|10|command,chaining,crítico
rm -rf|CRÍTICO|Comando destrutivo|10|destruction,delete,crítico
wget.*http://|CRÍTICO|Download remoto|10|download,remote,crítico
curl.*http://|CRÍTICO|Download remoto|10|download,remote,crítico

# ATAQUES WEB
SQL Injection|ALTO|Injeção SQL|7|sql,injection,web
XSS|ALTO|Cross-Site Scripting|7|xss,web,injection
LFI|ALTO|Local File Inclusion|7|lfi,file,inclusion
RFI|ALTO|Remote File Inclusion|7|rfi,file,inclusion
Command Injection|ALTO|Injeção de comandos|7|command,injection,web
Webshell Upload|ALTO|Upload de webshell|7|webshell,upload,web
Força bruta|ALTO|Tentativa de força bruta|7|brute,force,auth
<script|ALTO|Tag script maliciosa|7|script,xss,web
union.*select|ALTO|SQL Union injection|7|sql,union,injection
or.*1=1|ALTO|SQL Boolean injection|7|sql,boolean,injection
../../etc/passwd|ALTO|Path traversal|7|path,traversal,lfi

# SCANNERS E FERRAMENTAS
nikto|ALTO|Scanner de vulnerabilidades|7|scanner,web,automated
sqlmap|ALTO|Scanner SQL injection|7|scanner,sql,automated
nmap|ALTO|Scanner de portas|7|scanner,network,automated
dirb|ALTO|Scanner de diretórios|7|scanner,web,automated
gobuster|ALTO|Scanner de diretórios|7|scanner,web,automated
wpscan|ALTO|Scanner WordPress|7|scanner,wordpress,automated

# DIRETÓRIOS SENSÍVEIS
/admin/|ALTO|Acesso a admin|7|admin,sensitive,web
/wp-admin|ALTO|Acesso WordPress admin|7|wordpress,admin,web
/phpmyadmin|ALTO|Acesso phpMyAdmin|7|phpmyadmin,database,web
/\.env|ALTO|Arquivo de configuração|7|config,env,web
/\.git|ALTO|Repositório Git|7|git,version,web
/\.htaccess|ALTO|Arquivo htaccess|7|htaccess,config,web
/server-status|ALTO|Status do servidor|7|status,server,web
/wp-login\.php|ALTO|Login WordPress|7|wordpress,login,web
/api/upload|ALTO|API de upload|7|api,upload,web

# ERROS HTTP
Erro 403|ALTO|Acesso negado|7|error,403,web
Erro 404|MÉDIO|Página não encontrada|4|error,404,web
Erro 500|ALTO|Erro interno do servidor|7|error,500,web

# SSH
Invalid user|ALTO|Usuário inválido SSH|7|ssh,user,invalid
Failed password|ALTO|Senha falhou SSH|7|ssh,password,failed
Accepted password|MÉDIO|Senha aceita SSH|4|ssh,password,accepted
session opened|MÉDIO|Sessão SSH aberta|4|ssh,session,opened
session closed|BAIXO|Sessão SSH fechada|1|ssh,session,closed
Connection closed|BAIXO|Conexão SSH fechada|1|ssh,connection,closed
preauth|MÉDIO|Pré-autenticação SSH|4|ssh,preauth

# MYSQL
Access denied|ALTO|Acesso negado MySQL|7|mysql,access,denied
SELECT.*FROM.*sensitive|ALTO|Consulta dados sensíveis|7|mysql,select,sensitive
DROP.*TABLE|CRÍTICO|Drop de tabela|10|mysql,drop,crítico
DELETE.*FROM|ALTO|Delete de dados|7|mysql,delete,data
UPDATE.*WHERE|ALTO|Update de dados|7|mysql,update,data
INSERT.*INTO|MÉDIO|Insert de dados|4|mysql,insert,data
SHOW.*DATABASES|MÉDIO|Lista databases|4|mysql,show,databases
SHOW.*TABLES|MÉDIO|Lista tabelas|4|mysql,show,tables

# NGINX
Permission denied|ALTO|Permissão negada|7|nginx,permission,denied
too large body|MÉDIO|Corpo muito grande|4|nginx,body,large
upstream response|MÉDIO|Resposta upstream|4|nginx,upstream,response
fastcgi|MÉDIO|Erro FastCGI|4|nginx,fastcgi,error

# ATIVIDADES NORMAIS
backup|INFO|Backup do sistema|0|backup,system,normal
Verificação antivírus|INFO|Verificação antivírus|0|antivirus,scan,normal
Atualização automática|INFO|Atualização automática|0|update,auto,normal
Backup iniciado|INFO|Backup iniciado|0|backup,started,normal
Login sucesso|BAIXO|Login bem-sucedido|1|login,success,auth
Upload arquivo|BAIXO|Upload de arquivo|1|upload,file,normal
Download arquivo|BAIXO|Download de arquivo|1|download,file,normal
Consulta registro|BAIXO|Consulta de registro|1|query,record,normal

EOF
        echo -e "${GREEN}${BOLD}✅ Sistema de aprendizado inicializado: $LEARNING_CONFIG_FILE${RESET}"
    fi
}

# Função para classificar ataque usando sistema de aprendizado
classify_attack() {
    local line="$1"
    local classifications=()
    
    # Carrega padrões do arquivo de aprendizado
    while IFS='|' read -r pattern category description weight tags; do
        # Pula comentários e linhas vazias
        [[ "$pattern" =~ ^#.*$ ]] && continue
        [[ -z "$pattern" ]] && continue
        
        # Verifica se o padrão está na linha
        if [[ "$line" =~ ${pattern} ]]; then
            classifications+=("$category|$weight|$description|$tags")
        fi
    done < "$LEARNING_CONFIG_FILE"
    
    # Retorna a classificação mais crítica (maior peso)
    if [[ ${#classifications[@]} -gt 0 ]]; then
        local best_classification=""
        local max_weight=0
        
        for classification in "${classifications[@]}"; do
            local weight=$(echo "$classification" | cut -d'|' -f2)
            if (( weight > max_weight )); then
                max_weight=$weight
                best_classification="$classification"
            fi
        done
        
        echo "$best_classification"
    else
        echo "DESCONHECIDO|0|Evento não classificado|unknown"
    fi
}

# Função para adicionar novo padrão de aprendizado
add_learning_pattern() {
    local pattern="$1"
    local category="$2"
    local description="$3"
    local weight="$4"
    local tags="$5"
    
    # Validação básica
    if [[ -z "$pattern" || -z "$category" || -z "$description" ]]; then
        echo -e "${RED}${BOLD}❌ Erro: Todos os campos são obrigatórios${RESET}"
        return 1
    fi
    
    # Adiciona ao arquivo de configuração
    echo "$pattern|$category|$description|$weight|$tags" >> "$LEARNING_CONFIG_FILE"
    echo -e "${GREEN}${BOLD}✅ Padrão adicionado: $pattern ($category - ${weight}pts)${RESET}"
}

# Função para treinar o script com novos padrões
train_script() {
    echo -e "${CYAN}${BOLD}🎓 SISTEMA DE TREINAMENTO - ADICIONAR NOVOS PADRÕES${RESET}"
    echo -e "${CYAN}${BOLD}================================================${RESET}"
    
    while true; do
        echo -e "\n${BOLD}Escolha uma opção:${RESET}"
        echo "1) Adicionar padrão manualmente"
        echo "2) Analisar eventos não classificados"
        echo "3) Sugerir padrões com IA"
        echo "4) Listar padrões existentes"
        echo "5) Voltar"
        
        read -p "Opção: " choice
        
        case $choice in
            1)
                add_pattern_manually
                ;;
            2)
                analyze_unclassified_events
                ;;
            3)
                suggest_patterns_with_ai
                ;;
            4)
                list_existing_patterns
                ;;
            5)
                break
                ;;
            *)
                echo -e "${RED}Opção inválida${RESET}"
                ;;
        esac
    done
}

# Função para adicionar padrão manualmente
add_pattern_manually() {
    echo -e "\n${BOLD}📝 ADICIONAR PADRÃO MANUALMENTE${RESET}"
    echo -e "${BOLD}==============================${RESET}"
    
    read -p "Regex/Pattern: " pattern
    read -p "Categoria (CRÍTICO/ALTO/MÉDIO/BAIXO/INFO): " category
    read -p "Descrição: " description
    read -p "Peso (0-10): " weight
    read -p "Tags (separadas por vírgula): " tags
    
    add_learning_pattern "$pattern" "$category" "$description" "$weight" "$tags"
}

# Função para analisar eventos não classificados
analyze_unclassified_events() {
    echo -e "\n${BOLD}🔍 ANALISANDO EVENTOS NÃO CLASSIFICADOS${RESET}"
    echo -e "${BOLD}=====================================${RESET}"
    
    # Verifica se o arquivo de log existe
    if [[ ! -f "$LOG" ]]; then
        echo -e "${YELLOW}${BOLD}⚠️  Nenhum arquivo de log carregado para análise${RESET}"
        echo -e "${CYAN}${BOLD}💡 Use: $0 -v -train <arquivo_de_log> para analisar eventos não classificados${RESET}"
        return
    fi
    
    local unclassified_count=0
    local unclassified_events=()
    
    # Analisa cada linha do log
    while IFS= read -r line; do
        local classification=$(classify_attack "$line")
        local category=$(echo "$classification" | cut -d'|' -f1)
        
        if [[ "$category" == "DESCONHECIDO" ]]; then
            ((unclassified_count++))
            unclassified_events+=("$line")
        fi
    done < "$LOG"
    
    echo -e "${YELLOW}${BOLD}📊 Encontrados $unclassified_count eventos não classificados${RESET}"
    
    if [[ $unclassified_count -gt 0 ]]; then
        echo -e "\n${BOLD}Primeiros 5 eventos não classificados:${RESET}"
        for i in "${!unclassified_events[@]}"; do
            if [[ $i -lt 5 ]]; then
                echo -e "${CYAN}$((i+1)). ${unclassified_events[$i]}${RESET}"
            fi
        done
        
        echo -e "\n${BOLD}💡 Dica: Use esses eventos para criar novos padrões${RESET}"
    else
        echo -e "${GREEN}${BOLD}✅ Todos os eventos foram classificados!${RESET}"
    fi
}

# Função para sugerir padrões com IA (simulada)
suggest_patterns_with_ai() {
    echo -e "\n${BOLD}🤖 SUGESTÕES DE PADRÕES COM IA${RESET}"
    echo -e "${BOLD}================================${RESET}"
    
    # Verifica se o arquivo de log existe
    if [[ ! -f "$LOG" ]]; then
        echo -e "${YELLOW}${BOLD}⚠️  Nenhum arquivo de log carregado para análise${RESET}"
        echo -e "${CYAN}${BOLD}💡 Use: $0 -v -train <arquivo_de_log> para obter sugestões de padrões${RESET}"
        return
    fi
    
    echo -e "${CYAN}${BOLD}Análise de padrões comuns em eventos não classificados:${RESET}"
    
    # Analisa padrões comuns em eventos não classificados
    local unclassified_patterns=$(grep -Eo '[A-Za-z0-9._-]+' "$LOG" | sort | uniq -c | sort -nr | head -10)
    
    echo -e "\n${BOLD}Padrões mais frequentes:${RESET}"
    echo "$unclassified_patterns" | while read count pattern; do
        if [[ $count -gt 2 ]]; then
            echo -e "${YELLOW}• $pattern (aparece $count vezes)${RESET}"
        fi
    done
    
    echo -e "\n${BOLD}💡 Sugestões de classificação:${RESET}"
    echo -e "${GREEN}• Padrões com números: Possível enumeração ou força bruta${RESET}"
    echo -e "${GREEN}• Padrões com extensões (.php, .js): Possível ataque web${RESET}"
    echo -e "${GREEN}• Padrões com caracteres especiais: Possível injeção${RESET}"
}

# Função para listar padrões existentes
list_existing_patterns() {
    echo -e "\n${BOLD}📋 PADRÕES EXISTENTES${RESET}"
    echo -e "${BOLD}====================${RESET}"
    
    local category_counts=()
    
    while IFS='|' read -r pattern category description weight tags; do
        [[ "$pattern" =~ ^#.*$ ]] && continue
        [[ -z "$pattern" ]] && continue
        
        # Conta por categoria
        case "$category" in
            CRÍTICO) ((category_counts[0]++)) ;;
            ALTO)    ((category_counts[1]++)) ;;
            MÉDIO)   ((category_counts[2]++)) ;;
            BAIXO)   ((category_counts[3]++)) ;;
            INFO)    ((category_counts[4]++)) ;;
        esac
        
        echo -e "${BOLD}$category${RESET} (${weight}pts): $pattern"
        echo -e "  ${CYAN}Descrição:${RESET} $description"
        echo -e "  ${CYAN}Tags:${RESET} $tags"
        echo
    done < "$LEARNING_CONFIG_FILE"
    
    echo -e "${BOLD}📊 RESUMO POR CATEGORIA:${RESET}"
    echo -e "${RED}CRÍTICO: ${category_counts[0]:-0} padrões${RESET}"
    echo -e "${MAGENTA}ALTO: ${category_counts[1]:-0} padrões${RESET}"
    echo -e "${YELLOW}MÉDIO: ${category_counts[2]:-0} padrões${RESET}"
    echo -e "${BLUE}BAIXO: ${category_counts[3]:-0} padrões${RESET}"
    echo -e "${GREEN}INFO: ${category_counts[4]:-0} padrões${RESET}"
}

# Função para melhorar a análise linha por linha com classificação inteligente
analyze_line_by_line_enhanced() {
    echo -e "${CYAN}${BOLD}${UNDERLINE}📋 Análise Linha por Linha - Classificação Inteligente${RESET}"
    echo -e "${CYAN}${BOLD}=====================================================${RESET}"
    
    # Cabeçalho da tabela melhorado
    printf "%-6s | %-19s | %-15s | %-12s | %-5s | %-8s | %-15s | %-.30s\n" "Linha" "Timestamp" "IP" "Usuário" "Peso" "Nível" "Tipo Ataque" "Ação"
    printf "${BLUE}%s${RESET}\n" "------------------------------------------------------------------------------------------------------------------------"
    
    # Contador de linha
    local line_number=0
    
    # Processa cada linha
    while IFS= read -r line; do
        ((line_number++))
        
        local timestamp=$(echo "$line" | awk '{print $1" "$2}')
        local ip=$(echo "$line" | grep -Eo 'IP: [0-9.]+' | awk '{print $2}')
        local user=$(echo "$line" | grep -Eo 'user: [^ ]+' | awk '{print $2}')
        local action=$(echo "$line" | grep -Eo 'ação: .*' | sed 's/ação: //')
        
        if [[ -n "$timestamp" && -n "$ip" && -n "$user" && -n "$action" ]]; then
            # Usa classificação inteligente
            local classification=$(classify_attack "$line")
            local level=$(echo "$classification" | cut -d'|' -f1)
            local weight=$(echo "$classification" | cut -d'|' -f2)
            local attack_type=$(echo "$classification" | cut -d'|' -f3)
            local tags=$(echo "$classification" | cut -d'|' -f4)
            
            # Limita campos para exibição
            local action_short=$(echo "$action" | tr '\n' ' ' | cut -c1-30)
            local attack_type_short=$(echo "$attack_type" | cut -c1-15)
            
            if [[ ${#action} -gt 30 ]]; then
                action_short="${action_short}..."
            fi
            
            if [[ ${#attack_type} -gt 15 ]]; then
                attack_type_short="${attack_type_short}..."
            fi
            
            # Nível: cor simples
            case "$level" in
                CRÍTICO) level_style="${RED}" ;;
                ALTO)    level_style="${MAGENTA}" ;;
                MÉDIO)   level_style="${YELLOW}" ;;
                BAIXO)   level_style="${BLUE}" ;;
                INFO)    level_style="${GREEN}" ;;
                DESCONHECIDO) level_style="${WHITE}" ;;
                *)       level_style="${WHITE}" ;;
            esac
            
            # Monta linha e exibe
            linha_tabela="$(printf '%-6s | %-19s | %-15s | %-12s | %-5s | ' "$line_number" "$timestamp" "$ip" "$user" "$weight")${level_style}$(printf '%-8s' "$level")${RESET} | $(printf '%-15s' "$attack_type_short") | $action_short"
            echo -e "$linha_tabela"
            
            # Modo pedagógico
            if $PEDAGO && [[ "$level" != "INFO" && "$level" != "DESCONHECIDO" ]]; then
                echo -e "    ${YELLOW}➔ Tipo: ${BOLD}$attack_type${RESET} | Tags: $tags${RESET}"
            fi
            
            # Linha separadora entre entradas
            printf "${BLUE}%s${RESET}\n" "------------------------------------------------------------------------------------------------------------------------"
        fi
    done < "$LOG"
    
    echo
}

# -------------------------------------------------------------------------------
# Sistema de Pesos para Classificação de Ameaças (MELHORADO)
# -------------------------------------------------------------------------------
declare -A THREAT_WEIGHTS=(
  ["CRÍTICO"]=10
  ["ALTO"]=7
  ["MÉDIO"]=4
  ["BAIXO"]=1
  ["INFO"]=0
)

declare -A THREAT_PATTERNS=(
  # CRÍTICO (10 pontos)
  ["reverse shell"]=10
  ["shell\.php"]=10
  ["backdoor"]=10
  ["trojan"]=10
  ["virus"]=10
  ["root shell"]=10
  ["privilege escalation"]=10
  ["data exfiltration"]=10
  ["malicioso.*shell"]=10
  ["Comando injetado"]=10
  ["cat /flag"]=10
  ["whoami"]=10
  ["ls;.*cat"]=10
  ["rm -rf"]=10
  ["wget.*http://"]=10
  ["curl.*http://"]=10
  
  # ALTO (7 pontos)
  ["SQL Injection"]=7
  ["XSS"]=7
  ["LFI"]=7
  ["RFI"]=7
  ["Command Injection"]=7
  ["Webshell Upload"]=7
  ["Força bruta"]=7
  ["malicioso"]=7
  ["<script"]=7
  ["union.*select"]=7
  ["or.*1=1"]=7
  ["Download arquivo:.*senha"]=7
  ["Download arquivo:.*secret"]=7
  ["Download arquivo:.*token"]=7
  ["Download arquivo:.*credential"]=7
  ["Download arquivo:.*data_dump"]=7
  ["Upload arquivo:.*senha"]=7
  ["Inclusão remota"]=7
  ["Fetch remoto"]=7
  ["../../etc/passwd"]=7
  
  # Padrões específicos do Apache/Nginx
  ["nikto"]=7
  ["sqlmap"]=7
  ["nmap"]=7
  ["dirb"]=7
  ["gobuster"]=7
  ["wpscan"]=7
  ["/admin/"]=7
  ["/wp-admin"]=7
  ["/phpmyadmin"]=7
  ["/\.env"]=7
  ["/\.git"]=7
  ["/\.htaccess"]=7
  ["/server-status"]=7
  ["/wp-login\.php"]=7
  ["/api/upload"]=7
  ["Erro 403"]=7
  ["Erro 404"]=4
  ["Erro 500"]=7
  
  # Padrões específicos do SSH
  ["Invalid user"]=7
  ["Failed password"]=7
  ["Accepted password"]=4
  ["session opened"]=4
  ["session closed"]=1
  ["Connection closed"]=1
  ["preauth"]=4
  
  # Padrões específicos do MySQL
  ["Access denied"]=7
  ["SELECT.*FROM.*sensitive"]=7
  ["DROP.*TABLE"]=10
  ["DELETE.*FROM"]=7
  ["UPDATE.*WHERE"]=7
  ["INSERT.*INTO"]=4
  ["SHOW.*DATABASES"]=4
  ["SHOW.*TABLES"]=4
  
  # Padrões específicos do Nginx
  ["Permission denied"]=7
  ["too large body"]=4
  ["upstream response"]=4
  ["fastcgi"]=4
  
  # MÉDIO (4 pontos)
  ["Port Scan"]=4
  ["Enumeration"]=4
  ["Denial of Service"]=4
  ["Suspicious Download"]=4
  ["Login falha"]=4
  ["Erro de permissão"]=4
  ["Upload arquivo"]=1
  ["Download arquivo"]=1
  ["Consulta registro"]=1
  ["Login sucesso"]=1
  ["backup"]=0
  ["Verificação antivírus"]=0
  ["Atualização automática"]=0
  ["Backup iniciado"]=0
)

# -------------------------------------------------------------------------------
# Função para calcular peso da ameaça (MELHORADA)
# -------------------------------------------------------------------------------
calculate_threat_weight() {
  local line="$1"
  local total_weight=0
  local detected_threats=()
  
  for pattern in "${!THREAT_PATTERNS[@]}"; do
    if [[ "$line" =~ ${pattern} ]]; then
      local weight=${THREAT_PATTERNS[$pattern]}
      total_weight=$((total_weight + weight))
      detected_threats+=("$pattern (${weight}pts)")
    fi
  done
  
  # Classificação por peso total
  local classification=""
  if (( total_weight >= 10 )); then
    classification="CRÍTICO"
  elif (( total_weight >= 7 )); then
    classification="ALTO"
  elif (( total_weight >= 4 )); then
    classification="MÉDIO"
  elif (( total_weight >= 1 )); then
    classification="BAIXO"
  else
    classification="INFO"
  fi
  
  echo "$classification|$total_weight|${detected_threats[*]}"
}

# -------------------------------------------------------------------------------
# Função para colorir classificação por peso (MELHORADA)
# -------------------------------------------------------------------------------
color_threat_level() {
  local level="$1"
  case "$level" in
    CRÍTICO) echo -e "${BG_RED}${WHITE}${BOLD}🔴 $level${RESET}" ;;
    ALTO)    echo -e "${BG_MAGENTA}${WHITE}${BOLD}🟣 $level${RESET}" ;;
    MÉDIO)   echo -e "${BG_YELLOW}${BLUE}${BOLD}🟡 $level${RESET}" ;;
    BAIXO)   echo -e "${BG_BLUE}${WHITE}${BOLD}🔵 $level${RESET}" ;;
    INFO)    echo -e "${BG_GREEN}${WHITE}${BOLD}🟢 $level${RESET}" ;;
  esac
}

# -------------------------------------------------------------------------------
# Função de detecção de backup suspeito (MELHORADA)
# -------------------------------------------------------------------------------
declare -A LAST_MALICIOUS_TS
WINDOW=300

is_suspect_backup() {
  local usr="$1"
  local ts="$2"
  local act="$3"

  # Detecta atividades maliciosas
  if [[ "$act" =~ (shell\.php|malicioso|reverse shell|shell reverse|trojan|backdoor|virus|SQL Injection|XSS|Command Injection) ]]; then
    LAST_MALICIOUS_TS["$usr"]="$ts"
    return 1
  fi

  # Detecta backups
  if [[ "$act" =~ (backup\.(zip|tar\.gz|rar|7z)|Backup (iniciado|conclu[ií]do)) ]]; then
    local last="${LAST_MALICIOUS_TS[$usr]}"
    if [[ -n "$last" ]]; then
      local delta=$(( $(date --date="$ts" +%s 2>/dev/null || echo "0") - $(date --date="$last" +%s 2>/dev/null || echo "0") ))
      if (( delta <= WINDOW )); then
        SUS_REASON="Backup pós-atividade maliciosa (${delta}s)"
        return 0
      fi
    fi
  fi

  return 1
}

# -------------------------------------------------------------------------------
# Função de correlação de eventos (MELHORADA)
# -------------------------------------------------------------------------------
correlate_events() {
  local ip="$1"
  local user="$2"
  
  echo -e "${CYAN}${BOLD}${UNDERLINE}🔗 Correlação de Eventos - IP: $ip | Usuário: $user${RESET}"
  echo -e "${CYAN}${BOLD}==================================================${RESET}"
  
  # Busca eventos relacionados
  local events=$(grep "IP: $ip" "$LOG" | grep "user: $user" | head -10)
  
  if [[ -n "$events" ]]; then
    echo "$events" | while IFS= read -r event; do
      local timestamp=$(echo "$event" | awk '{print $1" "$2}')
      local action=$(echo "$event" | grep -Eo 'ação: .*' | sed 's/ação: //')
      local threat_info=$(calculate_threat_weight "$event")
      local level=$(echo "$threat_info" | cut -d'|' -f1)
      local weight=$(echo "$threat_info" | cut -d'|' -f2)
      
      echo -e "  ${BOLD}$timestamp${RESET} | $(color_threat_level "$level") (${weight}pts) | $action"
    done
  else
    echo -e "  ${YELLOW}Nenhum evento encontrado para esta correlação${RESET}"
  fi
  echo
}

# -------------------------------------------------------------------------------
# Função de análise de padrões temporais (MELHORADA)
# -------------------------------------------------------------------------------
analyze_temporal_patterns() {
  echo -e "${CYAN}${BOLD}${UNDERLINE}⏰ Análise de Padrões Temporais${RESET}"
  echo -e "${CYAN}${BOLD}=================================${RESET}"
  
  # Agrupa eventos por hora
  echo -e "${BOLD}📊 Eventos por Hora:${RESET}"
  grep -Eo '^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:' "$LOG" | sort | uniq -c | while read count time; do
    echo -e "  ${BLUE}$time: $count eventos${RESET}"
  done
  
  # Identifica picos de atividade
  echo
  echo -e "${BOLD}🚨 Picos de Atividade Suspeita:${RESET}"
  local peak_hours=$(grep -E "malicioso|SQL Injection|Força bruta" "$LOG" | grep -Eo '^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:' | sort | uniq -c | sort -nr | head -3)
  if [[ -n "$peak_hours" ]]; then
    echo "$peak_hours" | while read count time; do
      echo -e "  ${RED}${BOLD}$time: $count eventos maliciosos${RESET}"
    done
  else
    echo -e "  ${GREEN}Nenhum pico significativo detectado${RESET}"
  fi
  echo
}

# -------------------------------------------------------------------------------
# Função de análise de comportamento de usuário (MELHORADA)
# -------------------------------------------------------------------------------
analyze_user_behavior() {
  echo -e "${CYAN}${BOLD}${UNDERLINE}👤 Análise de Comportamento de Usuário${RESET}"
  echo -e "${CYAN}${BOLD}=========================================${RESET}"
  
  # Extrai usuários únicos
  local users=$(grep -Eo 'user: [^ ]+' "$LOG" | awk '{print $2}' | sort -u)
  
  for user in $users; do
    local user_events=$(grep "user: $user" "$LOG")
    local total_events=$(echo "$user_events" | wc -l)
    local malicious_events=$(echo "$user_events" | grep -E "malicioso|SQL Injection|Força bruta" | wc -l)
    local unique_ips=$(echo "$user_events" | grep -Eo 'IP: [0-9.]+' | awk '{print $2}' | sort -u | wc -l)
    
    if (( malicious_events > 0 )); then
      echo -e "${RED}${BOLD}🔴 $user: $malicious_events/$total_events eventos maliciosos (${unique_ips} IPs)${RESET}"
    elif (( unique_ips > 2 )); then
      echo -e "${YELLOW}${BOLD}🟡 $user: $total_events eventos normais (${unique_ips} IPs - suspeito)${RESET}"
    else
      echo -e "${GREEN}${BOLD}🟢 $user: $total_events eventos normais (${unique_ips} IPs)${RESET}"
    fi
  done
  echo
}

# -------------------------------------------------------------------------------
# Função de análise de payloads (MELHORADA)
# -------------------------------------------------------------------------------
analyze_payloads() {
  echo -e "${CYAN}${BOLD}${UNDERLINE}💣 Análise de Payloads${RESET}"
  echo -e "${CYAN}${BOLD}=====================${RESET}"
  
  # SQL Injection patterns
  local sqli_count=$(grep -i "SQL Injection" "$LOG" | wc -l)
  if (( sqli_count > 0 )); then
    echo -e "${RED}${BOLD}🔴 SQL Injection: $sqli_count tentativas${RESET}"
    grep -i "SQL Injection" "$LOG" | head -3 | while read line; do
      local payload=$(echo "$line" | grep -Eo 'SELECT.*|UNION.*|OR.*1=1' | head -1)
      echo -e "  ${YELLOW}Payload: $payload${RESET}"
    done
  fi
  
  # XSS patterns
  local xss_count=$(grep -i "XSS\|<script" "$LOG" | wc -l)
  if (( xss_count > 0 )); then
    echo -e "${RED}${BOLD}🔴 XSS: $xss_count tentativas${RESET}"
  fi
  
  # Command Injection
  local cmd_count=$(grep -i "Command Injection\|comando injetado" "$LOG" | wc -l)
  if (( cmd_count > 0 )); then
    echo -e "${RED}${BOLD}🔴 Command Injection: $cmd_count tentativas${RESET}"
  fi
  
  # Malicious files
  local malicious_count=$(grep -i "malicioso\|shell\.php" "$LOG" | wc -l)
  if (( malicious_count > 0 )); then
    echo -e "${RED}${BOLD}🔴 Arquivos Maliciosos: $malicious_count detectados${RESET}"
  fi
  
  echo
}

# -------------------------------------------------------------------------------
# Função de análise linha por linha (MELHORADA)
# -------------------------------------------------------------------------------
analyze_line_by_line() {
  echo -e "${CYAN}${BOLD}${UNDERLINE}📋 Análise Linha por Linha - Classificação por Peso${RESET}"
  echo -e "${CYAN}${BOLD}==================================================${RESET}"
  
  # Cabeçalho da tabela melhorado
  printf "%-6s | %-19s | %-15s | %-12s | %-5s | %-8s | %-.40s\n" "Linha" "Timestamp" "IP" "Usuário" "Peso" "Nível" "Ação"
  printf "${BLUE}%s${RESET}\n" "--------------------------------------------------------------------------------------------------------"
  
  # Contador de linha
  local line_number=0
  
  # Processa cada linha
  while IFS= read -r line; do
    ((line_number++))
    
    local timestamp=$(echo "$line" | awk '{print $1" "$2}')
    local ip=$(echo "$line" | grep -Eo 'IP: [0-9.]+' | awk '{print $2}')
    local user=$(echo "$line" | grep -Eo 'user: [^ ]+' | awk '{print $2}')
    local action=$(echo "$line" | grep -Eo 'ação: .*' | sed 's/ação: //')
    
    if [[ -n "$timestamp" && -n "$ip" && -n "$user" && -n "$action" ]]; then
      local threat_info=$(calculate_threat_weight "$line")
      local level=$(echo "$threat_info" | cut -d'|' -f1)
      local weight=$(echo "$threat_info" | cut -d'|' -f2)
      local threats=$(echo "$threat_info" | cut -d'|' -f3)
      
      # Limita o campo ação a 40 caracteres e remove quebras de linha
      local action_short=$(echo "$action" | tr '\n' ' ' | cut -c1-40)
      if [[ ${#action} -gt 40 ]]; then
        action_short="${action_short}..."
      fi
      
      # Nível: cor simples
      case "$level" in
        CRÍTICO) level_style="${RED}" ;;
        ALTO)    level_style="${MAGENTA}" ;;
        MÉDIO)   level_style="${YELLOW}" ;;
        BAIXO)   level_style="${BLUE}" ;;
        INFO)    level_style="${GREEN}" ;;
        *)       level_style="${WHITE}" ;;
      esac
      
      # Monta linha e exibe com echo -e
      linha_tabela="$(printf '%-6s | %-19s | %-15s | %-12s | %-5s | ' "$line_number" "$timestamp" "$ip" "$user" "$weight")${level_style}$(printf '%-8s' "$level")${RESET} | $action_short"
      echo -e "$linha_tabela"
      
      # Modo pedagógico
      if $PEDAGO && [[ "$level" != "INFO" ]]; then
        if [[ -n "$threats" ]]; then
          # Formata ameaças em uma linha só
          ameacas_formatadas=""
          
          # Extrai o primeiro padrão
          padrao1=$(echo "$threats" | sed -n 's/^\([^(]*\) ([0-9]*pts).*/\1/p')
          pontos1=$(echo "$threats" | sed -n 's/^[^(]* (\([0-9]*\)pts).*/\1/p')
          
          if [[ -n "$padrao1" && -n "$pontos1" ]]; then
            # Remove espaços extras do padrão
            padrao1=$(echo "$padrao1" | sed 's/^ *//;s/ *$//')
            ameacas_formatadas="${BOLD}${padrao1}${RESET} : ${pontos1}pts"
          fi
          
          # Extrai o segundo padrão (se existir)
          resto=$(echo "$threats" | sed 's/^[^(]* ([0-9]*pts) //')
          
          if [[ -n "$resto" ]]; then
            padrao2=$(echo "$resto" | sed -n 's/^\([^(]*\) ([0-9]*pts).*/\1/p')
            pontos2=$(echo "$resto" | sed -n 's/^[^(]* (\([0-9]*\)pts).*/\1/p')
            
            if [[ -n "$padrao2" && -n "$pontos2" ]]; then
              # Remove espaços extras do padrão
              padrao2=$(echo "$padrao2" | sed 's/^ *//;s/ *$//')
              ameacas_formatadas="${ameacas_formatadas} ${BOLD}${padrao2}${RESET} : ${pontos2}pts"
            fi
          fi
          
          echo -e "    ${YELLOW}➔ Ameaças detectadas: ${ameacas_formatadas}${RESET}"
        fi
      fi
      
      # Linha separadora entre entradas
      printf "${BLUE}%s${RESET}\n" "--------------------------------------------------------------------------------------------------------"
    fi
  done < "$LOG"
  
  echo
}

# -------------------------------------------------------------------------------
# Função de resumo estatístico (MELHORADA)
# -------------------------------------------------------------------------------
generate_statistics() {
  echo -e "${BLUE}${BOLD}${UNDERLINE}📊 Estatísticas Detalhadas${RESET}"
  echo -e "${BLUE}${BOLD}=====================${RESET}"
  
  local total_lines=$(wc -l < "$LOG")
  local critical_count=0
  local high_count=0
  local medium_count=0
  local low_count=0
  local info_count=0
  
  # Conta por nível de ameaça
  while IFS= read -r line; do
    local threat_info=$(calculate_threat_weight "$line")
    local level=$(echo "$threat_info" | cut -d'|' -f1)
    
    case "$level" in
      CRÍTICO) ((critical_count++)) ;;
      ALTO)    ((high_count++)) ;;
      MÉDIO)   ((medium_count++)) ;;
      BAIXO)   ((low_count++)) ;;
      INFO)    ((info_count++)) ;;
    esac
  done < "$LOG"
  
  echo -e "${BOLD}📈 Distribuição por Nível de Ameaça:${RESET}"
  echo -e "  ${RED}${BOLD}🔴 CRÍTICO: $critical_count eventos${RESET}"
  echo -e "  ${MAGENTA}${BOLD}🟣 ALTO: $high_count eventos${RESET}"
  echo -e "  ${YELLOW}${BOLD}🟡 MÉDIO: $medium_count eventos${RESET}"
  echo -e "  ${BLUE}${BOLD}🔵 BAIXO: $low_count eventos${RESET}"
  echo -e "  ${GREEN}${BOLD}🟢 INFO: $info_count eventos${RESET}"
  echo -e "  ${BOLD}📊 TOTAL: $total_lines eventos${RESET}"
  
  # Calcula score de risco geral
  local risk_score=$((critical_count * 10 + high_count * 7 + medium_count * 4 + low_count * 1))
  echo
  echo -e "${BOLD}🎯 Score de Risco Geral: $risk_score pontos${RESET}"
  
  if (( risk_score >= 50 )); then
    echo -e "${RED}${BOLD}${BLINK}🚨 ALERTA: Sistema em alto risco!${RESET}"
  elif (( risk_score >= 20 )); then
    echo -e "${YELLOW}${BOLD}⚠️  ATENÇÃO: Sistema em risco moderado${RESET}"
  else
    echo -e "${GREEN}${BOLD}✅ Sistema em risco baixo${RESET}"
  fi
  echo
}

# -------------------------------------------------------------------------------
# Função de explicação de IP (MELHORADA)
# -------------------------------------------------------------------------------
explain_ip() {
  local ip="$1"
  if [[ $ip =~ ^127\. ]]; then
    echo -e "${BLUE}${BOLD}Loopback (127.0.0.0/8) – reservado para host local${RESET}"
  elif [[ $ip =~ ^10\.|^192\.168\.|^172\.(1[6-9]|2[0-9]|3[0-1])\. ]]; then
    echo -e "${GREEN}${BOLD}Privado (RFC1918) – não roteável na internet${RESET}"
  elif [[ $ip =~ ^(192\.0\.2|198\.51\.100|203\.0\.113)\. ]]; then
    echo -e "${YELLOW}${BOLD}TEST-NET (RFC5737) – bloco usado apenas para documentação e testes${RESET}"
  else
    # Externo válido
    local geo=$(curl -s https://ipinfo.io/$ip/json)
    local city=$(jq -r '.city'   <<<"$geo")
    local region=$(jq -r '.region' <<<"$geo")
    local country=$(jq -r '.country'<<<"$geo")
    local org=$(jq -r '.org'      <<<"$geo")
    echo -e "${RED}${BOLD}Externo – $city, $region, $country ($org)${RESET}"
    echo -e "  ${CYAN}🔗 Shodan: https://shodan.io/host/$ip${RESET}"
  fi
}

# -------------------------------------------------------------------------------
# Função de recomendações (MELHORADA)
# -------------------------------------------------------------------------------
generate_recommendations() {
  echo -e "${GREEN}${BOLD}${UNDERLINE}🛡 Ações Recomendadas${RESET}"
  echo -e "${GREEN}${BOLD}=====================${RESET}"
  
  # Analisa o log para gerar recomendações específicas
  local has_sqli=$(grep -i "SQL Injection" "$LOG" | wc -l)
  local has_xss=$(grep -i "XSS\|<script" "$LOG" | wc -l)
  local has_brute=$(grep -i "Força bruta" "$LOG" | wc -l)
  local has_malware=$(grep -i "malicioso\|shell\.php" "$LOG" | wc -l)
  
  echo -e "${BOLD}🔧 Recomendações Específicas:${RESET}"
  
  if (( has_sqli > 0 )); then
    echo -e "  ${RED}• Ativar WAF contra SQL Injection${RESET}"
    echo -e "  ${RED}• Implementar prepared statements${RESET}"
  fi
  
  if (( has_xss > 0 )); then
    echo -e "  ${RED}• Implementar CSP (Content Security Policy)${RESET}"
    echo -e "  ${RED}• Sanitizar inputs de usuário${RESET}"
  fi
  
  if (( has_brute > 0 )); then
    echo -e "  ${RED}• Configurar Fail2Ban${RESET}"
    echo -e "  ${RED}• Implementar MFA${RESET}"
  fi
  
  if (( has_malware > 0 )); then
    echo -e "  ${RED}• Ativar antivírus em tempo real${RESET}"
    echo -e "  ${RED}• Implementar sandbox para uploads${RESET}"
  fi
  
  echo -e "  ${GREEN}• Monitorar logs continuamente${RESET}"
  echo -e "  ${GREEN}• Implementar SIEM${RESET}"
  echo -e "  ${GREEN}• Treinar equipe em segurança${RESET}"
  echo
}

# -------------------------------------------------------------------------------
# Função de plano de continuidade (MELHORADA com IA)
# -------------------------------------------------------------------------------
generate_business_continuity() {
  echo -e "${YELLOW}${BOLD}${UNDERLINE}📘 Plano de Continuidade de Negócios - IA${RESET}"
  echo -e "${YELLOW}${BOLD}===========================================${RESET}"
  
  # Analisa o log para determinar tipos de ataques
  local has_web_attacks=false
  local has_ssh_attacks=false
  local has_db_attacks=false
  local has_dos_attacks=false
  local has_malware=false
  local has_data_exfiltration=false
  local has_privilege_escalation=false
  local risk_level="BAIXO"
  local total_events=$(wc -l < "$LOG")
  local critical_events=0
  local high_events=0
  
  # Conta eventos por nível
  while IFS= read -r line; do
    local threat_info=$(calculate_threat_weight "$line")
    local level=$(echo "$threat_info" | cut -d'|' -f1)
    case "$level" in
      CRÍTICO) ((critical_events++)) ;;
      ALTO)    ((high_events++)) ;;
    esac
  done < "$LOG"
  
  # Determina nível de risco
  if (( critical_events > 0 )); then
    risk_level="CRÍTICO"
  elif (( high_events > 2 )); then
    risk_level="ALTO"
  elif (( high_events > 0 )); then
    risk_level="MÉDIO"
  fi
  
  # Detecta tipos de ataques específicos
  if grep -qi "SQL Injection\|XSS\|LFI\|RFI\|Command Injection" "$LOG"; then
    has_web_attacks=true
  fi
  
  if grep -qi "Invalid user\|Failed password\|preauth" "$LOG"; then
    has_ssh_attacks=true
  fi
  
  if grep -qi "Access denied\|SELECT.*FROM.*sensitive\|DROP.*TABLE" "$LOG"; then
    has_db_attacks=true
  fi
  
  if grep -qi "too large body\|Denial of Service" "$LOG"; then
    has_dos_attacks=true
  fi
  
  if grep -qi "malicioso\|shell\.php\|backdoor\|trojan" "$LOG"; then
    has_malware=true
  fi
  
  if grep -qi "data exfiltration\|SELECT.*FROM.*sensitive" "$LOG"; then
    has_data_exfiltration=true
  fi
  
  if grep -qi "privilege escalation\|root shell" "$LOG"; then
    has_privilege_escalation=true
  fi
  
  # Cabeçalho com análise de risco
  echo -e "${BOLD}🎯 Análise de Risco Atual:${RESET}"
  echo -e "  • ${BOLD}Nível de Risco: ${RESET}"
  case "$risk_level" in
    CRÍTICO) echo -e "    ${RED}${BOLD}🔴 CRÍTICO - Ação Imediata Necessária${RESET}" ;;
    ALTO)    echo -e "    ${MAGENTA}${BOLD}🟣 ALTO - Atenção Urgente${RESET}" ;;
    MÉDIO)   echo -e "    ${YELLOW}${BOLD}🟡 MÉDIO - Monitoramento Intensivo${RESET}" ;;
    BAIXO)   echo -e "    ${GREEN}${BOLD}🟢 BAIXO - Manutenção Preventiva${RESET}" ;;
  esac
  echo -e "  • ${BOLD}Total de Eventos: $total_events${RESET}"
  echo -e "  • ${BOLD}Eventos Críticos: $critical_events${RESET}"
  echo -e "  • ${BOLD}Eventos de Alto Risco: $high_events${RESET}"
  echo
  
  # Objetivos baseados no risco
  echo -e "${BOLD}🎯 Objetivos de Recuperação (RTO/RPO):${RESET}"
  case "$risk_level" in
    CRÍTICO)
      echo -e "  • ${RED}${BOLD}RTO (Recovery Time Objective): < 30 minutos${RESET}"
      echo -e "  • ${RED}${BOLD}RPO (Recovery Point Objective): < 5 minutos${RESET}"
      echo -e "  • ${RED}${BOLD}MTTR (Mean Time To Repair): < 1 hora${RESET}"
      ;;
    ALTO)
      echo -e "  • ${MAGENTA}${BOLD}RTO (Recovery Time Objective): < 1 hora${RESET}"
      echo -e "  • ${MAGENTA}${BOLD}RPO (Recovery Point Objective): < 15 minutos${RESET}"
      echo -e "  • ${MAGENTA}${BOLD}MTTR (Mean Time To Repair): < 4 horas${RESET}"
      ;;
    MÉDIO)
      echo -e "  • ${YELLOW}${BOLD}RTO (Recovery Time Objective): < 4 horas${RESET}"
      echo -e "  • ${YELLOW}${BOLD}RPO (Recovery Point Objective): < 1 hora${RESET}"
      echo -e "  • ${YELLOW}${BOLD}MTTR (Mean Time To Repair): < 8 horas${RESET}"
      ;;
    BAIXO)
      echo -e "  • ${GREEN}${BOLD}RTO (Recovery Time Objective): < 8 horas${RESET}"
      echo -e "  • ${GREEN}${BOLD}RPO (Recovery Point Objective): < 4 horas${RESET}"
      echo -e "  • ${GREEN}${BOLD}MTTR (Mean Time To Repair): < 24 horas${RESET}"
      ;;
  esac
  echo
  
  # Ativos críticos baseados nos ataques detectados
  echo -e "${BOLD}📋 Ativos Críticos Identificados:${RESET}"
  if $has_web_attacks; then
    echo -e "  • ${RED}${BOLD}🌐 Sistemas Web (Prioridade Máxima)${RESET}"
    echo -e "    - Aplicações web comprometidas"
    echo -e "    - Servidores web vulneráveis"
  fi
  
  if $has_db_attacks; then
    echo -e "  • ${RED}${BOLD}🗄️  Bancos de Dados (Prioridade Máxima)${RESET}"
    echo -e "    - Dados sensíveis em risco"
    echo -e "    - Integridade comprometida"
  fi
  
  if $has_ssh_attacks; then
    echo -e "  • ${RED}${BOLD}🔐 Sistemas de Acesso (Prioridade Alta)${RESET}"
    echo -e "    - Credenciais comprometidas"
    echo -e "    - Controle de acesso vulnerável"
  fi
  
  if $has_malware; then
    echo -e "  • ${RED}${BOLD}🦠 Sistemas Infectados (Prioridade Máxima)${RESET}"
    echo -e "    - Malware detectado"
    echo -e "    - Backdoors ativos"
  fi
  
  if $has_data_exfiltration; then
    echo -e "  • ${RED}${BOLD}📤 Dados Corporativos (Prioridade Máxima)${RESET}"
    echo -e "    - Informações confidenciais vazadas"
    echo -e "    - Propriedade intelectual comprometida"
  fi
  
  if $has_privilege_escalation; then
    echo -e "  • ${RED}${BOLD}👑 Controle de Privilégios (Prioridade Máxima)${RESET}"
    echo -e "    - Acesso root comprometido"
    echo -e "    - Controle administrativo perdido"
  fi
  
  echo -e "  • ${BLUE}${BOLD}🖥️  Infraestrutura Geral${RESET}"
  echo -e "    - Servidores e redes"
  echo -e "    - Sistemas de backup"
  echo
  echo
  
  # Estratégias de recuperação específicas
  echo -e "${BOLD}🔄 Estratégias de Recuperação Específicas:${RESET}"
  
  if $has_web_attacks; then
    echo -e "${RED}${BOLD}🌐 Para Ataques Web:${RESET}"
    echo -e "  • Isolamento imediato dos servidores web"
    echo -e "  • Ativação de WAF em modo bloqueio"
    echo -e "  • Restore de backups limpos das aplicações"
    echo -e "  • Patch de todas as vulnerabilidades web"
    echo -e "  • Implementação de HTTPS obrigatório"
    echo -e "  • Configuração de headers de segurança"
    echo
  fi
  
  if $has_db_attacks; then
    echo -e "${RED}${BOLD}🗄️  Para Ataques de Banco de Dados:${RESET}"
    echo -e "  • Isolamento imediato dos servidores de BD"
    echo -e "  • Backup de emergência dos dados críticos"
    echo -e "  • Restore de backup limpo do banco"
    echo -e "  • Implementação de prepared statements"
    echo -e "  • Configuração de firewall específico para BD"
    echo -e "  • Auditoria completa de permissões"
    echo
  fi
  
  if $has_ssh_attacks; then
    echo -e "${RED}${BOLD}🔐 Para Ataques SSH:${RESET}"
    echo -e "  • Bloqueio imediato de IPs suspeitos"
    echo -e "  • Desativação de login por senha"
    echo -e "  • Implementação de chaves SSH"
    echo -e "  • Configuração de Fail2Ban"
    echo -e "  • Mudança de todas as senhas"
    echo -e "  • Implementação de MFA"
    echo
  fi
  
  if $has_malware; then
    echo -e "${RED}${BOLD}🦠 Para Infecção por Malware:${RESET}"
    echo -e "  • Isolamento completo dos sistemas infectados"
    echo -e "  • Análise forense dos arquivos suspeitos"
    echo -e "  • Restore completo de sistemas limpos"
    echo -e "  • Ativação de antivírus em tempo real"
    echo -e "  • Implementação de sandbox para uploads"
    echo -e "  • Monitoramento contínuo de processos"
    echo
  fi
  
  if $has_data_exfiltration; then
    echo -e "${RED}${BOLD}📤 Para Vazamento de Dados:${RESET}"
    echo -e "  • Notificação imediata à equipe jurídica"
    echo -e "  • Avaliação do impacto regulatório (LGPD/GDPR)"
    echo -e "  • Implementação de DLP (Data Loss Prevention)"
    echo -e "  • Criptografia de dados sensíveis"
    echo -e "  • Auditoria de acesso a dados críticos"
    echo -e "  • Preparação para notificação de autoridades"
    echo
  fi
  
  if $has_privilege_escalation; then
    echo -e "${RED}${BOLD}👑 Para Escalação de Privilégios:${RESET}"
    echo -e "  • Revogação imediata de todos os privilégios"
    echo -e "  • Reset de todas as contas administrativas"
    echo -e "  • Implementação de PAM (Privileged Access Management)"
    echo -e "  • Auditoria completa de logs de acesso"
    echo -e "  • Implementação de just-in-time access"
    echo -e "  • Monitoramento de atividades administrativas"
    echo
  fi
  
  # Estratégias gerais
  echo -e "${BLUE}${BOLD}🛡️  Estratégias Gerais de Recuperação:${RESET}"
  echo -e "  • Restore de backups limpos e verificados"
  echo -e "  • Patch imediato de todas as vulnerabilidades"
  echo -e "  • Isolamento de sistemas comprometidos"
  echo -e "  • Implementação de monitoramento avançado"
  echo -e "  • Ativação de alertas em tempo real"
  echo -e "  • Documentação de todos os incidentes"
  echo
  echo
  
  # Plano de comunicação baseado no risco
  echo -e "${BOLD}📞 Plano de Comunicação:${RESET}"
  case "$risk_level" in
    CRÍTICO)
      echo -e "  • ${RED}${BOLD}Imediato (0-15 min):${RESET}"
      echo -e "    - SOC → CISO → Diretoria Executiva"
      echo -e "    - Ativação do plano de crise"
      echo -e "    - Notificação às autoridades (se necessário)"
      echo -e "  • ${RED}${BOLD}Curto Prazo (15-60 min):${RESET}"
      echo -e "    - Comunicação interna à equipe"
      echo -e "    - Notificação a clientes críticos"
      echo -e "    - Ativação de equipe de resposta a incidentes"
      ;;
    ALTO)
      echo -e "  • ${MAGENTA}${BOLD}Imediato (0-30 min):${RESET}"
      echo -e "    - SOC → CISO → Diretoria"
      echo -e "    - Ativação de equipe de resposta"
      echo -e "  • ${MAGENTA}${BOLD}Curto Prazo (30-120 min):${RESET}"
      echo -e "    - Comunicação interna"
      echo -e "    - Avaliação de impacto"
      ;;
    MÉDIO)
      echo -e "  • ${YELLOW}${BOLD}Imediato (0-60 min):${RESET}"
      echo -e "    - SOC → Gerente de TI"
      echo -e "    - Monitoramento intensivo"
      echo -e "  • ${YELLOW}${BOLD}Curto Prazo (1-4 horas):${RESET}"
      echo -e "    - Comunicação interna"
      echo -e "    - Implementação de correções"
      ;;
    BAIXO)
      echo -e "  • ${GREEN}${BOLD}Imediato (0-120 min):${RESET}"
      echo -e "    - SOC → Equipe de TI"
      echo -e "    - Análise e correção"
      echo -e "  • ${GREEN}${BOLD}Curto Prazo (2-8 horas):${RESET}"
      echo -e "    - Documentação do incidente"
      echo -e "    - Implementação de melhorias"
      ;;
  esac
  echo
  
  # Métricas de sucesso
  echo -e "${BOLD}📊 Métricas de Sucesso da Recuperação:${RESET}"
  echo -e "  • ${BOLD}Tempo de Detecção (MTTD):${RESET} < 5 minutos"
  echo -e "  • ${BOLD}Tempo de Resposta (MTTR):${RESET} < 1 hora"
  echo -e "  • ${BOLD}Tempo de Recuperação (RTO):${RESET} < 4 horas"
  echo -e "  • ${BOLD}Perda Máxima de Dados (RPO):${RESET} < 1 hora"
  echo -e "  • ${BOLD}Disponibilidade do Sistema:${RESET} > 99.9%"
  echo -e "  • ${BOLD}Taxa de Falsos Positivos:${RESET} < 1%"
  echo
  echo
  
  # Recomendações de melhoria
  echo -e "${BOLD}🔧 Recomendações de Melhoria Contínua:${RESET}"
  echo -e "  • ${CYAN}${BOLD}Implementar SIEM avançado${RESET}"
  echo -e "  • ${CYAN}${BOLD}Automatizar resposta a incidentes${RESET}"
  echo -e "  • ${CYAN}${BOLD}Implementar Zero Trust Architecture${RESET}"
  echo -e "  • ${CYAN}${BOLD}Treinar equipe em segurança${RESET}"
  echo -e "  • ${CYAN}${BOLD}Realizar testes de penetração regulares${RESET}"
  echo -e "  • ${CYAN}${BOLD}Implementar backup em nuvem${RESET}"
  echo -e "  • ${CYAN}${BOLD}Criar playbooks de resposta${RESET}"
  echo -e "  • ${CYAN}${BOLD}Implementar monitoramento 24/7${RESET}"
  echo
  echo
  
  # Status final
  echo -e "${BOLD}🎯 Status do Plano:${RESET}"
  case "$risk_level" in
    CRÍTICO)
      echo -e "  ${RED}${BOLD}${BLINK}🚨 PLANO DE CRISE ATIVADO${RESET}"
      echo -e "  ${RED}${BOLD}Ação imediata necessária - Todos os recursos mobilizados${RESET}"
      ;;
    ALTO)
      echo -e "  ${MAGENTA}${BOLD}⚠️  PLANO DE EMERGÊNCIA ATIVADO${RESET}"
      echo -e "  ${MAGENTA}${BOLD}Resposta rápida necessária - Equipe de resposta mobilizada${RESET}"
      ;;
    MÉDIO)
      echo -e "  ${YELLOW}${BOLD}📋 PLANO DE CONTINGÊNCIA ATIVADO${RESET}"
      echo -e "  ${YELLOW}${BOLD}Monitoramento intensivo - Equipe de TI alertada${RESET}"
      ;;
    BAIXO)
      echo -e "  ${GREEN}${BOLD}✅ PLANO PREVENTIVO ATIVADO${RESET}"
      echo -e "  ${GREEN}${BOLD}Manutenção preventiva - Monitoramento normal${RESET}"
      ;;
  esac
  echo
}

# -------------------------------------------------------------------------------
# Funções de Detecção e Processamento de Formatos de Log
# -------------------------------------------------------------------------------

# Detecta o tipo de log baseado no conteúdo
detect_log_format() {
  local file="$1"
  local first_line=$(head -1 "$file" 2>/dev/null)
  
  if [[ -z "$first_line" ]]; then
    echo "EMPTY"
    return
  fi
  
  # Apache Access Log
  if [[ "$first_line" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+.*\[.*\]\ \" ]]; then
    echo "APACHE_ACCESS"
  # SSH Auth Log
  elif [[ "$first_line" =~ ^[A-Za-z]{3}\ [0-9]{1,2}\ [0-9]{2}:[0-9]{2}:[0-9]{2}.*sshd.* ]]; then
    echo "SSH_AUTH"
  # MySQL Log
  elif [[ "$first_line" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}\.[0-9]+Z ]]; then
    echo "MYSQL"
  # Nginx Error Log
  elif [[ "$first_line" =~ ^[0-9]{4}/[0-9]{2}/[0-9]{2}\ [0-9]{2}:[0-9]{2}:[0-9]{2}\ \[.*\] ]]; then
    echo "NGINX_ERROR"
  # Nginx Access Log (similar ao Apache)
  elif [[ "$first_line" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+.*\"[A-Z]+ ]]; then
    echo "NGINX_ACCESS"
  # Log Customizado (formato padrão do script)
  elif [[ "$first_line" =~ IP:\ [0-9]+\.[0-9]+\.[0-9]+\.[0-9]+ ]]; then
    echo "CUSTOM"
  else
    echo "UNKNOWN"
  fi
}

# Normaliza linha do Apache Access Log
parse_apache_access() {
  local line="$1"
  local timestamp=$(echo "$line" | sed -n 's/.*\[\([^]]*\)\].*/\1/p')
  local ip=$(echo "$line" | awk '{print $1}')
  local user=$(echo "$line" | awk '{print $3}')
  local method=$(echo "$line" | sed -n 's/.*"\([A-Z]\+\)[^"]*".*/\1/p')
  local url=$(echo "$line" | sed -n 's/.*"[A-Z]\+ \([^"]*\)[^"]*".*/\1/p')
  local status=$(echo "$line" | awk '{print $9}')
  local user_agent=$(echo "$line" | sed -n 's/.*"\([^"]*\)"$/\1/p')
  
  # Normaliza usuário
  if [[ "$user" == "-" ]]; then
    user="anonymous"
  fi
  
  # Determina ação baseada no método e URL
  local action=""
  case "$method" in
    GET)  action="Consulta: $url" ;;
    POST) action="Envio: $url" ;;
    PUT)  action="Atualização: $url" ;;
    DELETE) action="Remoção: $url" ;;
    *)    action="$method: $url" ;;
  esac
  
  # Adiciona informações de status
  if [[ "$status" =~ ^[45] ]]; then
    action="$action (Erro $status)"
  fi
  
  # Detecta User-Agents suspeitos
  if [[ "$user_agent" =~ (nikto|sqlmap|nmap|dirb|gobuster|wpscan) ]]; then
    action="$action [Scanner: $user_agent]"
  fi
  
  echo "IP: $ip | user: $user | timestamp: $timestamp | ação: $action"
}

# Normaliza linha do SSH Auth Log
parse_ssh_auth() {
  local line="$1"
  local timestamp=$(echo "$line" | awk '{print $1" "$2" "$3}')
  local ip=$(echo "$line" | grep -oE 'from [0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | awk '{print $2}')
  local user=$(echo "$line" | grep -oE '(for|Accepted password for) [^ ]+' | awk '{print $2}')
  local event=$(echo "$line" | awk '{for(i=5;i<=NF;i++) printf "%s ", $i; print ""}' | sed 's/ $//')
  
  # Normaliza usuário
  if [[ -z "$user" ]]; then
    user="unknown"
  fi
  
  # Determina ação baseada no evento
  local action=""
  if [[ "$event" =~ "Invalid user" ]]; then
    action="Tentativa de login com usuário inválido"
  elif [[ "$event" =~ "Failed password" ]]; then
    action="Senha incorreta"
  elif [[ "$event" =~ "Accepted password" ]]; then
    action="Login bem-sucedido"
  elif [[ "$event" =~ "session opened" ]]; then
    action="Sessão iniciada"
  elif [[ "$event" =~ "session closed" ]]; then
    action="Sessão encerrada"
  elif [[ "$event" =~ "Connection closed" ]]; then
    action="Conexão encerrada"
  else
    action="$event"
  fi
  
  echo "IP: $ip | user: $user | timestamp: $timestamp | ação: $action"
}

# Normaliza linha do MySQL Log
parse_mysql_log() {
  local line="$1"
  local timestamp=$(echo "$line" | awk '{print $1}' | sed 's/T/ /' | sed 's/Z//')
  local connection_id=$(echo "$line" | awk '{print $2}')
  local event_type=$(echo "$line" | awk '{print $3}')
  local details=$(echo "$line" | awk '{for(i=4;i<=NF;i++) printf "%s ", $i; print ""}' | sed 's/ $//')
  
  # Extrai IP se presente
  local ip=$(echo "$details" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | head -1)
  if [[ -z "$ip" ]]; then
    ip="localhost"
  fi
  
  # Extrai usuário se presente
  local user=$(echo "$details" | grep -oE "user '[^']*'" | sed "s/user '//" | sed "s/'//")
  if [[ -z "$user" ]]; then
    user="mysql_user"
  fi
  
  # Determina ação baseada no tipo de evento
  local action=""
  case "$event_type" in
    Connect) action="Conexão estabelecida" ;;
    Query)   action="Consulta: $details" ;;
    Quit)    action="Conexão encerrada" ;;
    *)       action="$event_type: $details" ;;
  esac
  
  echo "IP: $ip | user: $user | timestamp: $timestamp | ação: $action"
}

# Normaliza linha do Nginx Error Log
parse_nginx_error() {
  local line="$1"
  local timestamp=$(echo "$line" | awk '{print $1" "$2}')
  local level=$(echo "$line" | sed -n 's/.*\[\([^]]*\)\].*/\1/p')
  local client=$(echo "$line" | grep -oE 'client: [0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | awk '{print $2}')
  local request=$(echo "$line" | sed -n 's/.*request: "\([^"]*\)".*/\1/p')
  local error=$(echo "$line" | awk '{for(i=4;i<=NF;i++) printf "%s ", $i; print ""}' | sed 's/ $//')
  
  # Normaliza IP
  if [[ -z "$client" ]]; then
    client="unknown"
  fi
  
  # Determina usuário (não disponível em logs de erro)
  local user="nginx_user"
  
  # Determina ação baseada no erro
  local action=""
  if [[ "$error" =~ "Permission denied" ]]; then
    action="Erro de permissão: $request"
  elif [[ "$error" =~ "upstream response" ]]; then
    action="Resposta upstream: $request"
  elif [[ "$error" =~ "too large body" ]]; then
    action="Corpo da requisição muito grande: $request"
  else
    action="$level: $error"
  fi
  
  echo "IP: $client | user: $user | timestamp: $timestamp | ação: $action"
}

# Normaliza linha do Nginx Access Log (similar ao Apache)
parse_nginx_access() {
  local line="$1"
  local timestamp=$(echo "$line" | sed -n 's/.*\[\([^]]*\)\].*/\1/p')
  local ip=$(echo "$line" | awk '{print $1}')
  local method=$(echo "$line" | sed -n 's/.*"\([A-Z]\+\)[^"]*".*/\1/p')
  local url=$(echo "$line" | sed -n 's/.*"[A-Z]\+ \([^"]*\)[^"]*".*/\1/p')
  local status=$(echo "$line" | awk '{print $9}')
  local user_agent=$(echo "$line" | sed -n 's/.*"\([^"]*\)"$/\1/p')
  
  local user="nginx_user"
  local action=""
  
  case "$method" in
    GET)  action="Consulta: $url" ;;
    POST) action="Envio: $url" ;;
    PUT)  action="Atualização: $url" ;;
    DELETE) action="Remoção: $url" ;;
    *)    action="$method: $url" ;;
  esac
  
  if [[ "$status" =~ ^[45] ]]; then
    action="$action (Erro $status)"
  fi
  
  if [[ "$user_agent" =~ (nikto|sqlmap|nmap|dirb|gobuster|wpscan) ]]; then
    action="$action [Scanner: $user_agent]"
  fi
  
  echo "IP: $ip | user: $user | timestamp: $timestamp | ação: $action"
}

# Processa linha baseada no formato detectado
process_log_line() {
  local line="$1"
  local format="$2"
  
  case "$format" in
    APACHE_ACCESS)
      parse_apache_access "$line"
      ;;
    SSH_AUTH)
      parse_ssh_auth "$line"
      ;;
    MYSQL)
      parse_mysql_log "$line"
      ;;
    NGINX_ERROR)
      parse_nginx_error "$line"
      ;;
    NGINX_ACCESS)
      parse_nginx_access "$line"
      ;;
    CUSTOM)
      echo "$line"
      ;;
    *)
      # Tenta detectar automaticamente
      if [[ "$line" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+.*\[.*\]\ \" ]]; then
        parse_apache_access "$line"
      elif [[ "$line" =~ ^[A-Za-z]{3}\ [0-9]{1,2}\ [0-9]{2}:[0-9]{2}:[0-9]{2}.*sshd.* ]]; then
        parse_ssh_auth "$line"
      elif [[ "$line" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}\.[0-9]+Z ]]; then
        parse_mysql_log "$line"
      elif [[ "$line" =~ ^[0-9]{4}/[0-9]{2}/[0-9]{2}\ [0-9]{2}:[0-9]{2}:[0-9]{2}\ \[.*\] ]]; then
        parse_nginx_error "$line"
      else
        echo "$line"
      fi
      ;;
  esac
}

# Cria arquivo temporário normalizado
create_normalized_log() {
  local input_file="$1"
  local temp_file="/tmp/normalized_log_$$.tmp"
  local format=$(detect_log_format "$input_file")
  
  echo -e "${CYAN}${BOLD}🔄 Detectado formato: $format${RESET}" >&2
  
  if [[ "$format" == "EMPTY" ]]; then
    echo -e "${YELLOW}${BOLD}⚠️  Arquivo vazio ou não legível${RESET}" >&2
    return 1
  fi
  
  # Processa cada linha
  while IFS= read -r line; do
    if [[ -n "$line" ]]; then
      process_log_line "$line" "$format" >> "$temp_file"
    fi
  done < "$input_file"
  
  echo "$temp_file"
}

# -------------------------------------------------------------------------------
# Execução principal
# -------------------------------------------------------------------------------
echo -e "${BOLD}${CYAN}${UNDERLINE}🔍 ANÁLISE AVANÇADA DE LOGS DE SEGURANÇA - v4.0${RESET}"
echo -e "${BOLD}${CYAN}=============================================${RESET}"
echo

# Inicializa sistema de aprendizado se necessário
if $TRAIN || [[ -f "$LEARNING_CONFIG_FILE" ]]; then
    init_learning_system
    echo -e "${GREEN}${BOLD}✅ Sistema de aprendizado ativo${RESET}"
fi

# Sistema de treinamento (executa antes de processar logs)
if $TRAIN; then
    train_script
    exit 0
fi

# Carrega logs (só se não estiver no modo de treinamento)
if [[ ! -f "$LOG" ]]; then
  echo -e "${RED}${BOLD}❌ Arquivo de log não encontrado: $LOG${RESET}"
  exit 1
fi

# Cria arquivo normalizado
echo -e "${CYAN}${BOLD}🔄 Normalizando formato de log...${RESET}"
NORMALIZED_LOG=$(create_normalized_log "$LOG")

if [[ $? -ne 0 ]]; then
  echo -e "${RED}${BOLD}❌ Erro ao normalizar arquivo de log${RESET}"
  exit 1
fi

# Substitui LOG pelo arquivo normalizado para todas as análises
ORIGINAL_LOG="$LOG"
LOG="$NORMALIZED_LOG"

# Função de limpeza para remover arquivo temporário
cleanup() {
  if [[ -f "$NORMALIZED_LOG" ]]; then
    rm -f "$NORMALIZED_LOG"
  fi
}

# Registra função de limpeza para execução ao sair
trap cleanup EXIT

echo -e "${GREEN}${BOLD}✅ Log normalizado criado: $NORMALIZED_LOG${RESET}"
echo

# Análise linha por linha com pesos (versão melhorada se sistema de aprendizado ativo)
if $VERBOSE; then
    if [[ -f "$LEARNING_CONFIG_FILE" ]]; then
        analyze_line_by_line_enhanced
    else
        analyze_line_by_line
    fi
fi

# Estatísticas gerais
generate_statistics

# Análise de padrões temporais
analyze_temporal_patterns

# Análise de comportamento de usuário
analyze_user_behavior

# Análise de payloads
analyze_payloads

# Correlação de eventos (se solicitado)
if $CORREL; then
  echo -e "${CYAN}${BOLD}${UNDERLINE}🔗 Correlação de Eventos${RESET}"
  echo -e "${CYAN}${BOLD}=====================${RESET}"
  
  # Pega os 3 IPs mais ativos
  top_ips=$(grep -Eo 'IP: [0-9.]+' "$LOG" | awk '{print $2}' | sort | uniq -c | sort -nr | head -3 | awk '{print $2}')
  
  for ip in $top_ips; do
    top_user=$(grep "IP: $ip" "$LOG" | grep -Eo 'user: [^ ]+' | awk '{print $2}' | sort | uniq -c | sort -nr | head -1 | awk '{print $2}')
    if [[ -n "$top_user" ]]; then
      correlate_events "$ip" "$top_user"
    fi
  done
fi

# Explicação de IPs (se solicitado)
if $EXPLICA_TESTNET; then
  echo -e "${BLUE}${BOLD}${UNDERLINE}🌐 Explicação de IPs${RESET}"
  echo -e "${BLUE}${BOLD}===================${RESET}"
  
  # Pega IPs únicos
  unique_ips=$(grep -Eo 'IP: [0-9.]+' "$LOG" | awk '{print $2}' | sort -u)
  
  for ip in $unique_ips; do
    echo -e "${BOLD}IP: $ip${RESET}"
    explain_ip "$ip"
    echo
  done
fi

# Recomendações (se solicitado)
if $ACTION_REC; then
  generate_recommendations
fi

# Plano de continuidade (se solicitado)
if $PCN; then
  generate_business_continuity
fi

echo -e "${GREEN}${BOLD}${BLINK}✅ Análise Avançada Concluída!${RESET}"
echo -e "${CYAN}${BOLD}📁 Arquivo original: $ORIGINAL_LOG${RESET}"
echo -e "${CYAN}${BOLD}📋 Formato detectado: $(detect_log_format "$ORIGINAL_LOG")${RESET}" 