#!/bin/bash

echo "🧪 TESTE COMPLETO - ANÁLISE DE LOGS COM DETECÇÃO DE BACKUPS SUSPEITOS"
echo "====================================================================="
echo

# Função para converter timestamp
to_epoch() {
  date --date="$1" +%s 2>/dev/null || echo "0"
}

# Função de detecção de backup suspeito (versão corrigida)
declare -A LAST_MALICIOUS_TS
WINDOW=300

is_suspect_backup() {
  local usr="$1"
  local ts="$2"
  local act="$3"

  # Detecta atividades maliciosas
  if [[ "$act" =~ (shell\.php|malicioso|reverse shell|shell reverse|trojan|backdoor|virus) ]]; then
    LAST_MALICIOUS_TS["$usr"]="$ts"
    return 1
  fi

  # Detecta backups
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

# Função para classificar ataques
classify_attack() {
  local line="$1"
  
  if [[ "$line" =~ shell\.php|malicioso ]]; then
    echo "Malicious File"
  elif [[ "$line" =~ SQL\ Injection ]]; then
    echo "SQL Injection"
  elif [[ "$line" =~ Força\ bruta ]]; then
    echo "Brute Force"
  elif [[ "$line" =~ backup ]]; then
    echo "Backup"
  elif [[ "$line" =~ antivírus ]]; then
    echo "System Maintenance"
  else
    echo "Normal"
  fi
}

# Processa os logs
echo "📋 PROCESSANDO LOGS..."
echo "====================="
echo

# Arrays para estatísticas
declare -A EVENTS_BY_IP EVENTS_BY_USER
declare -A FAIL_COUNT SUCCESS_COUNT

# Lê e processa os logs
while IFS= read -r line; do
  timestamp=$(echo "$line" | awk '{print $1" "$2}')
  ip=$(echo "$line" | grep -Eo 'IP: [0-9.]+' | awk '{print $2}')
  user=$(echo "$line" | grep -Eo 'user: [^ ]+' | awk '{print $2}')
  action=$(echo "$line" | grep -Eo 'ação: .*' | sed 's/ação: //')
  
  if [[ -n "$user" && -n "$timestamp" && -n "$action" ]]; then
    # Acumula estatísticas
    EVENTS_BY_IP["$ip"]+="$action|"
    EVENTS_BY_USER["$user"]+="$action|"
    
    # Conta logins
    [[ $action =~ [Ll]ogin\ falha ]] && ((FAIL_COUNT["$ip"]++))
    [[ $action =~ [Ll]ogin\ sucesso ]] && ((SUCCESS_COUNT["$ip"]++))
    
    # Testa backup suspeito
    if is_suspect_backup "$user" "$timestamp" "$action"; then
      echo "🚨 BACKUP SUSPEITO DETECTADO!"
      echo "   Usuário: $user"
      echo "   IP: $ip"
      echo "   Ação: $action"
      echo "   Motivo: $SUS_REASON"
      echo "   Timestamp: $timestamp"
      echo
    fi
    
    # Classifica o ataque
    attack_type=$(classify_attack "$line")
    if [[ "$attack_type" != "Normal" ]]; then
      echo "📊 $timestamp | $ip | $user | $attack_type"
    fi
  fi
done < "logs_analise.txt"

echo
echo "📈 ESTATÍSTICAS GERAIS"
echo "======================"
echo

# Conta eventos por tipo
malicious_count=0
backup_count=0
login_fail_count=0

while IFS= read -r line; do
  action=$(echo "$line" | grep -Eo 'ação: .*' | sed 's/ação: //')
  if [[ "$action" =~ shell\.php|malicioso ]]; then
    ((malicious_count++))
  elif [[ "$action" =~ backup ]]; then
    ((backup_count++))
  elif [[ "$action" =~ [Ll]ogin\ falha ]]; then
    ((login_fail_count++))
  fi
done < "logs_analise.txt"

echo "🔴 Atividades maliciosas: $malicious_count"
echo "📦 Backups: $backup_count"
echo "❌ Falhas de login: $login_fail_count"
echo

echo "🌐 IPs COM ATIVIDADES SUSPEITAS"
echo "==============================="
for ip in "${!EVENTS_BY_IP[@]}"; do
  if grep -Eqi "shell\.php|malicioso|SQL Injection|Força bruta" <<<"${EVENTS_BY_IP[$ip]}"; then
    echo "🔴 $ip"
  fi
done
echo

echo "👥 USUÁRIOS COM ATIVIDADES SUSPEITAS"
echo "===================================="
for user in "${!EVENTS_BY_USER[@]}"; do
  if grep -Eqi "shell\.php|malicioso|SQL Injection|Força bruta" <<<"${EVENTS_BY_USER[$user]}"; then
    echo "🔴 $user"
  fi
done
echo

echo "✅ ANÁLISE CONCLUÍDA!" 