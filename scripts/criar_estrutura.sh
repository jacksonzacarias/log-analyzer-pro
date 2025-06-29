#!/bin/bash

# ===================================================================================
# CRIADOR DE ESTRUTURA - SISTEMA DE ANÁLISE DE LOGS
# ===================================================================================
# Cria todos os diretórios essenciais do projeto
# Autor: Jackson Savoldi | ACADe-TI - Aula 04
# ===================================================================================

# Carrega configuração centralizada
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
CONFIG_FILE="$PROJECT_ROOT/config/paths.conf"

if [[ -f "$CONFIG_FILE" ]]; then
    source "$CONFIG_FILE"
else
    echo "❌ Arquivo de configuração não encontrado: $CONFIG_FILE"
    exit 1
fi

# Lista de diretórios essenciais
DIRS=(
    "$CONFIG_DIR"
    "$SRC_DIR"
    "$ANALOGS_DIR"
    "$RESULTS_DIR"
    "$SYSTEM_DIR"
    "$PAYLOADS_DIR"
    "$TEMP_DIR"
    "$LOGS_DIR"
    "$DOCS_DIR"
    "$TESTS_DIR"
    "$SCRIPTS_DIR"
    "$COMPILADO_DIR"
    "$SRC_SCRIPTS_DIR"
    "$SRC_CORE_DIR"
    "$SRC_UTILS_DIR"
    "$SRC_GENERATORS_DIR"
    "$SRC_MODULES_DIR"
    "$ANALOGS_SERVICES_DIR"
    "$ANALOGS_ATTACKS_DIR"
    "$ANALOGS_EXAMPLES_DIR"
    "$ANALOGS_REALISTIC_DIR"
    "$ANALOGS_CUSTOM_DIR"
    "$RESULTS_ANALYSIS_DIR"
    "$RESULTS_REPORTS_DIR"
    "$RESULTS_EXPORTS_DIR"
    "$SYSTEM_DATA_DIR"
    "$SYSTEM_IMPORT_DIR"
    "$SYSTEM_EXPORT_DIR"
    "$SYSTEM_TEMPLATES_DIR"
    "$SYSTEM_BACKUP_DIR"
    "$SYSTEM_LOGS_DIR"
    "$TESTS_UNIT_DIR"
    "$TESTS_INTEGRATION_DIR"
    "$TESTS_PERFORMANCE_DIR"
    "$TESTS_REGRESSION_DIR"
    "$TESTS_RESULTS_DIR"
    "$DOCS_USER_DIR"
    "$DOCS_DEVELOPER_DIR"
    "$TEMP_CACHE_DIR"
    "$TEMP_DOWNLOADS_DIR"
    "$TEMP_PROCESSING_DIR"
    "$PAYLOADS_SQL_DIR"
    "$PAYLOADS_XSS_DIR"
)

# Cria diretórios
for dir in "${DIRS[@]}"; do
    if [[ ! -d "$dir" ]]; then
        mkdir -p "$dir"
        echo "✅ Criado: $dir"
    else
        echo "ℹ️  Já existe: $dir"
    fi
done

echo "\n🎉 Estrutura garantida!" 