#!/bin/bash

echo "=== TESTE DE CONFIGURAÇÃO ==="
echo "Diretório atual: $(pwd)"
echo ""

# Carrega configuração
if [[ -f "config/paths.conf" ]]; then
    echo "✅ Arquivo de configuração encontrado"
    source config/paths.conf
    echo "✅ Configuração carregada"
    echo ""
    echo "=== VARIÁVEIS CARREGADAS ==="
    echo "PROJECT_ROOT: $PROJECT_ROOT"
    echo "CONFIG_DIR: $CONFIG_DIR"
    echo "SRC_DIR: $SRC_DIR"
    echo "ANALOGS_DIR: $ANALOGS_DIR"
    echo "RESULTS_DIR: $RESULTS_DIR"
    echo "SYSTEM_DIR: $SYSTEM_DIR"
    echo "PAYLOADS_DIR: $PAYLOADS_DIR"
    echo "TEMP_DIR: $TEMP_DIR"
    echo "LOGS_DIR: $LOGS_DIR"
    echo "DOCS_DIR: $DOCS_DIR"
    echo "TESTS_DIR: $TESTS_DIR"
    echo "SCRIPTS_DIR: $SCRIPTS_DIR"
    echo ""
    echo "=== TESTE DE DIRETÓRIOS ==="
    echo "CONFIG_DIR existe: $([[ -d "$CONFIG_DIR" ]] && echo '✅' || echo '❌')"
    echo "SRC_DIR existe: $([[ -d "$SRC_DIR" ]] && echo '✅' || echo '❌')"
    echo "ANALOGS_DIR existe: $([[ -d "$ANALOGS_DIR" ]] && echo '✅' || echo '❌')"
    echo "RESULTS_DIR existe: $([[ -d "$RESULTS_DIR" ]] && echo '✅' || echo '❌')"
    echo "SYSTEM_DIR existe: $([[ -d "$SYSTEM_DIR" ]] && echo '✅' || echo '❌')"
    echo "PAYLOADS_DIR existe: $([[ -d "$PAYLOADS_DIR" ]] && echo '✅' || echo '❌')"
    echo "TEMP_DIR existe: $([[ -d "$TEMP_DIR" ]] && echo '✅' || echo '❌')"
    echo "LOGS_DIR existe: $([[ -d "$LOGS_DIR" ]] && echo '✅' || echo '❌')"
    echo "DOCS_DIR existe: $([[ -d "$DOCS_DIR" ]] && echo '✅' || echo '❌')"
    echo "TESTS_DIR existe: $([[ -d "$TESTS_DIR" ]] && echo '✅' || echo '❌')"
    echo "SCRIPTS_DIR existe: $([[ -d "$SCRIPTS_DIR" ]] && echo '✅' || echo '❌')"
else
    echo "❌ Arquivo de configuração não encontrado: config/paths.conf"
fi

echo ""
echo "=== TESTE CONCLUÍDO ===" 