#!/bin/bash

# Script de teste para verificar a função de detecção de backups suspeitos

# Simula a função to_epoch
to_epoch() {
  date --date="$1" +%s
}

# Função corrigida de detecção de backup suspeito
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

echo "🧪 TESTE DA FUNÇÃO DE DETECÇÃO DE BACKUPS SUSPEITOS"
echo "=================================================="
echo

# Teste 1: Cenário real dos logs
echo "📋 Teste 1: Cenário real dos logs"
echo "---------------------------------"

# Simula o cenário de aline.costa
echo "1. aline.costa faz upload de shell.php:"
is_suspect_backup "aline.costa" "2025-06-25 09:01:12" "Upload arquivo malicioso: shell.php"

echo "2. aline.costa faz backup (deveria ser suspeito):"
is_suspect_backup "aline.costa" "2025-06-25 09:00:14" "Upload arquivo: backup.zip"

echo

# Teste 2: Cenário de carlos.junior
echo "📋 Teste 2: Cenário de carlos.junior"
echo "-----------------------------------"

echo "1. carlos.junior faz upload de shell.php:"
is_suspect_backup "carlos.junior" "2025-06-25 09:00:23" "Upload arquivo malicioso: shell.php"

echo "2. carlos.junior faz backup (deveria ser suspeito):"
is_suspect_backup "carlos.junior" "2025-06-25 09:02:23" "Upload arquivo: backup.zip"

echo

# Teste 3: Backup sem atividade maliciosa prévia
echo "📋 Teste 3: Backup sem atividade maliciosa"
echo "------------------------------------------"

echo "1. marcos.silva faz backup (deveria ser normal):"
is_suspect_backup "marcos.silva" "2025-06-25 09:00:14" "Upload arquivo: backup.zip"

echo

# Teste 4: Backup após muito tempo
echo "📋 Teste 4: Backup após muito tempo (fora da janela)"
echo "---------------------------------------------------"

echo "1. ana.souza faz atividade maliciosa:"
is_suspect_backup "ana.souza" "2025-06-25 09:00:00" "Upload arquivo malicioso: trojan.exe"

echo "2. ana.souza faz backup 10 minutos depois (deveria ser normal):"
is_suspect_backup "ana.souza" "2025-06-25 09:10:00" "Upload arquivo: backup.zip"

echo

# Teste 5: Diferentes formatos de backup
echo "📋 Teste 5: Diferentes formatos de backup"
echo "----------------------------------------"

echo "1. tiago.pereira faz atividade maliciosa:"
is_suspect_backup "tiago.pereira" "2025-06-25 09:00:00" "Upload arquivo malicioso: backdoor.sh"

echo "2. tiago.pereira faz backup em diferentes formatos:"
is_suspect_backup "tiago.pereira" "2025-06-25 09:01:00" "Upload arquivo: backup.tar.gz"
is_suspect_backup "tiago.pereira" "2025-06-25 09:02:00" "Backup iniciado"
is_suspect_backup "tiago.pereira" "2025-06-25 09:03:00" "Backup concluído"

echo
echo "✅ Teste concluído!" 