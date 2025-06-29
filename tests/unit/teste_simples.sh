#!/bin/bash

# Script simplificado para testar a função de detecção de backups suspeitos
# Sem dependências externas como jq

echo "🧪 TESTE SIMPLIFICADO - DETECÇÃO DE BACKUPS SUSPEITOS"
echo "====================================================="
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
    echo "🔴 Atividade maliciosa detectada para usuário $usr: $act"
    return 1
  fi

  # Detecta backups
  if [[ "$act" =~ (backup\.(zip|tar\.gz|rar|7z)|Backup (iniciado|conclu[ií]do)) ]]; then
    local last="${LAST_MALICIOUS_TS[$usr]}"
    if [[ -n "$last" ]]; then
      local delta=$(( $(to_epoch "$ts") - $(to_epoch "$last") ))
      if (( delta <= WINDOW )); then
        echo "🚨 BACKUP SUSPEITO DETECTADO!"
        echo "   Usuário: $usr"
        echo "   Ação: $act"
        echo "   Tempo desde atividade maliciosa: ${delta}s"
        echo "   Janela de detecção: ${WINDOW}s"
        return 0
      else
        echo "✅ Backup normal para usuário $usr (${delta}s após atividade maliciosa)"
      fi
    else
      echo "✅ Backup normal para usuário $usr (sem atividade maliciosa prévia)"
    fi
  fi

  return 1
}

# Função para processar os logs
process_logs() {
  local log_file="$1"
  
  echo "📋 Processando logs do arquivo: $log_file"
  echo "----------------------------------------"
  echo

  # Lê o arquivo linha por linha
  while IFS= read -r line; do
    # Extrai informações da linha
    timestamp=$(echo "$line" | awk '{print $1" "$2}')
    ip=$(echo "$line" | grep -Eo 'IP: [0-9.]+' | awk '{print $2}')
    user=$(echo "$line" | grep -Eo 'user: [^ ]+' | awk '{print $2}')
    action=$(echo "$line" | grep -Eo 'ação: .*' | sed 's/ação: //')
    
    # Testa a função de backup suspeito
    if [[ -n "$user" && -n "$timestamp" && -n "$action" ]]; then
      is_suspect_backup "$user" "$timestamp" "$action"
    fi
  done < "$log_file"
}

# Executa o teste
if [[ -f "logs_analise.txt" ]]; then
  process_logs "logs_analise.txt"
else
  echo "❌ Arquivo logs_analise.txt não encontrado!"
  echo "Criando dados de teste..."
  
  # Cria dados de teste
  cat > teste_logs.txt << 'EOF'
2025-06-25 09:00:00 | IP: 192.168.10.11 | user: marcos.silva | ação: Upload arquivo: relatorio_vendas.pdf
2025-06-25 09:01:12 | IP: 203.0.113.55 | user: aline.costa | ação: Upload arquivo malicioso: shell.php
2025-06-25 09:00:14 | IP: 192.168.10.10 | user: aline.costa | ação: Upload arquivo: backup.zip
2025-06-25 09:00:23 | IP: 198.51.100.23 | user: carlos.junior | ação: Upload arquivo malicioso: shell.php
2025-06-25 09:02:23 | IP: 192.168.10.10 | user: carlos.junior | ação: Upload arquivo: backup.zip
2025-06-25 09:00:14 | IP: 192.168.10.10 | user: marcos.silva | ação: Upload arquivo: backup.zip
EOF
  
  process_logs "teste_logs.txt"
fi

echo
echo "✅ Teste concluído!" 