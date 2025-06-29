#!/bin/bash

# ===================================================================================
# CRIADOR DE CONFIGURAÇÃO DINÂMICA - SISTEMA DE ANÁLISE DE LOGS
# ===================================================================================
# Script para criar arquivo de configuração de forma dinâmica e portável
# Autor: Jackson Savoldi | ACADe-TI - Aula 04
# ===================================================================================

# Detecção dinâmica do diretório raiz do projeto
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"

echo "🔧 Criando arquivo de configuração dinâmico..."
echo "📁 Diretório raiz detectado: $PROJECT_ROOT"

# Limpar arquivo existente
CONFIG_FILE="$PROJECT_ROOT/config/paths.conf"
> "$CONFIG_FILE"

# Adicionar cabeçalho
cat >> "$CONFIG_FILE" << 'EOF'
# ===================================================================================
# CONFIGURAÇÃO DE CAMINHOS - SISTEMA DE ANÁLISE DE LOGS
# ===================================================================================
# Este arquivo define todos os caminhos do projeto de forma centralizada
# Autor: Jackson Savoldi | ACADe-TI - Aula 04
# ===================================================================================

# Detecção automática do diretório raiz do projeto
# O arquivo paths.conf está em config/paths.conf, então o projeto raiz é 1 nível acima
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

EOF

# Adicionar variáveis principais
cat >> "$CONFIG_FILE" << EOF
# Diretórios principais
CONFIG_DIR="\$PROJECT_ROOT/config"
SRC_DIR="\$PROJECT_ROOT/src"
ANALOGS_DIR="\$PROJECT_ROOT/analogs"
RESULTS_DIR="\$PROJECT_ROOT/results"
SYSTEM_DIR="\$PROJECT_ROOT/system"
PAYLOADS_DIR="\$PROJECT_ROOT/payloads"
TEMP_DIR="\$PROJECT_ROOT/temp"
LOGS_DIR="\$PROJECT_ROOT/logs"
DOCS_DIR="\$PROJECT_ROOT/docs"
TESTS_DIR="\$PROJECT_ROOT/tests"
SCRIPTS_DIR="\$PROJECT_ROOT/scripts"
COMPILADO_DIR="\$PROJECT_ROOT/compilado"

EOF

# Subdiretórios do src
cat >> "$CONFIG_FILE" << 'EOF'
# Subdiretórios do src
SRC_SCRIPTS_DIR=$SRC_DIR/scripts
SRC_CORE_DIR=$SRC_SCRIPTS_DIR/core
SRC_UTILS_DIR=$SRC_SCRIPTS_DIR/utils
SRC_GENERATORS_DIR=$SRC_SCRIPTS_DIR/generators
SRC_MODULES_DIR=$SRC_DIR/modules

EOF

# Subdiretórios do analogs
cat >> "$CONFIG_FILE" << 'EOF'
# Subdiretórios do analogs
ANALOGS_SERVICES_DIR=$ANALOGS_DIR/services
ANALOGS_ATTACKS_DIR=$ANALOGS_DIR/attacks
ANALOGS_EXAMPLES_DIR=$ANALOGS_DIR/examples
ANALOGS_REALISTIC_DIR=$ANALOGS_DIR/realistic
ANALOGS_CUSTOM_DIR=$ANALOGS_DIR/custom

EOF

# Subdiretórios do results
cat >> "$CONFIG_FILE" << 'EOF'
# Subdiretórios do results
RESULTS_ANALYSIS_DIR=$RESULTS_DIR/analysis
RESULTS_REPORTS_DIR=$RESULTS_DIR/reports
RESULTS_EXPORTS_DIR=$RESULTS_DIR/exports

EOF

# Subdiretórios do system
cat >> "$CONFIG_FILE" << 'EOF'
# Subdiretórios do system
SYSTEM_DATA_DIR=$SYSTEM_DIR/data
SYSTEM_IMPORT_DIR=$SYSTEM_DATA_DIR/import
SYSTEM_EXPORT_DIR=$SYSTEM_DATA_DIR/export
SYSTEM_TEMPLATES_DIR=$SYSTEM_DATA_DIR/templates
SYSTEM_BACKUP_DIR=$SYSTEM_DIR/backup
SYSTEM_LOGS_DIR=$SYSTEM_DIR/logs

EOF

# Subdiretórios do tests
cat >> "$CONFIG_FILE" << 'EOF'
# Subdiretórios do tests
TESTS_UNIT_DIR=$TESTS_DIR/unit
TESTS_INTEGRATION_DIR=$TESTS_DIR/integration
TESTS_PERFORMANCE_DIR=$TESTS_DIR/performance
TESTS_REGRESSION_DIR=$TESTS_DIR/regression
TESTS_RESULTS_DIR=$TESTS_DIR/results

EOF

# Subdiretórios do docs
cat >> "$CONFIG_FILE" << 'EOF'
# Subdiretórios do docs
DOCS_USER_DIR=$DOCS_DIR/user
DOCS_DEVELOPER_DIR=$DOCS_DIR/developer

EOF

# Subdiretórios do temp
cat >> "$CONFIG_FILE" << 'EOF'
# Subdiretórios do temp
TEMP_CACHE_DIR=$TEMP_DIR/cache
TEMP_DOWNLOADS_DIR=$TEMP_DIR/downloads
TEMP_PROCESSING_DIR=$TEMP_DIR/processing

EOF

# Subdiretórios do payloads
cat >> "$CONFIG_FILE" << 'EOF'
# Subdiretórios do payloads
PAYLOADS_SQL_DIR=$PAYLOADS_DIR/sql-injection-payload-list
PAYLOADS_XSS_DIR=$PAYLOADS_DIR/xss

EOF

# Arquivos de configuração
cat >> "$CONFIG_FILE" << 'EOF'
# Arquivos de configuração
MAIN_CONFIG_FILE=$CONFIG_DIR/main.conf
PATTERNS_CONFIG_FILE=$CONFIG_DIR/patterns.conf
ATTACK_PATTERNS_FILE=$CONFIG_DIR/attack_patterns_learning.conf

EOF

# Arquivos de log do sistema
cat >> "$CONFIG_FILE" << 'EOF'
# Arquivos de log do sistema
SYSTEM_LOG_FILE=$LOGS_DIR/system.log
ERROR_LOG_FILE=$LOGS_DIR/error.log
DEBUG_LOG_FILE=$LOGS_DIR/debug.log

EOF

# Arquivos de relatório padrão
cat >> "$CONFIG_FILE" << 'EOF'
# Arquivos de relatório padrão
DEFAULT_REPORT_FILE=$RESULTS_REPORTS_DIR/relatorio.html
DEFAULT_REPORT_ADVANCED_FILE=$RESULTS_REPORTS_DIR/relatorio_avancado.html

EOF

# Exportar todas as variáveis
cat >> "$CONFIG_FILE" << 'EOF'
# Exportar todas as variáveis
export PROJECT_ROOT CONFIG_DIR SRC_DIR ANALOGS_DIR RESULTS_DIR SYSTEM_DIR
export PAYLOADS_DIR TEMP_DIR LOGS_DIR DOCS_DIR TESTS_DIR SCRIPTS_DIR
export COMPILADO_DIR SRC_SCRIPTS_DIR SRC_CORE_DIR SRC_UTILS_DIR
export SRC_GENERATORS_DIR SRC_MODULES_DIR ANALOGS_SERVICES_DIR
export ANALOGS_ATTACKS_DIR ANALOGS_EXAMPLES_DIR ANALOGS_REALISTIC_DIR
export ANALOGS_CUSTOM_DIR RESULTS_ANALYSIS_DIR RESULTS_REPORTS_DIR
export RESULTS_EXPORTS_DIR SYSTEM_DATA_DIR SYSTEM_IMPORT_DIR
export SYSTEM_EXPORT_DIR SYSTEM_TEMPLATES_DIR SYSTEM_BACKUP_DIR
export SYSTEM_LOGS_DIR TESTS_UNIT_DIR TESTS_INTEGRATION_DIR
export TESTS_PERFORMANCE_DIR TESTS_REGRESSION_DIR TESTS_RESULTS_DIR
export DOCS_USER_DIR DOCS_DEVELOPER_DIR TEMP_CACHE_DIR
export TEMP_DOWNLOADS_DIR TEMP_PROCESSING_DIR PAYLOADS_SQL_DIR
export PAYLOADS_XSS_DIR MAIN_CONFIG_FILE PATTERNS_CONFIG_FILE
export ATTACK_PATTERNS_FILE SYSTEM_LOG_FILE ERROR_LOG_FILE
export DEBUG_LOG_FILE DEFAULT_REPORT_FILE DEFAULT_REPORT_ADVANCED_FILE

EOF

echo "✅ Arquivo de configuração criado com sucesso!"
echo "📄 Localização: $CONFIG_FILE"
echo "🌍 Agora o projeto é totalmente portável!" 