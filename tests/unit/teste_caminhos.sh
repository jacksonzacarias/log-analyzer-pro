#!/bin/bash

echo "=== TESTE DE CAMINHOS DO SCRIPT AVANÇADO ==="
echo ""

# Simula o que o script avançado faz (corrigido)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "SCRIPT_DIR: $SCRIPT_DIR"

PROJECT_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
echo "PROJECT_ROOT: $PROJECT_ROOT"

CONFIG_FILE="$PROJECT_ROOT/config/paths.conf"
echo "CONFIG_FILE: $CONFIG_FILE"

if [[ -f "$CONFIG_FILE" ]]; then
    echo "✅ Arquivo de configuração encontrado"
    source "$CONFIG_FILE"
    echo "✅ Configuração carregada"
    echo "PROJECT_ROOT da config: $PROJECT_ROOT"
else
    echo "❌ Arquivo de configuração não encontrado"
fi

echo ""
echo "=== TESTE CONCLUÍDO ===" 