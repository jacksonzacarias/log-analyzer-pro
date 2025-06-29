#!/bin/bash

# ===================================================================================
# VERIFICADOR DE ESTRUTURA - SISTEMA DE ANÁLISE DE LOGS
# ===================================================================================
# Script para verificar e validar a estrutura do projeto
# Autor: Jackson Savoldi | ACADe-TI - Aula 04
# ===================================================================================

# Carrega configuração centralizada
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
source "$PROJECT_ROOT/config/paths.conf"

# Cores
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
CYAN="\e[36m"
WHITE="\e[37m"
BOLD="\e[1m"
RESET="\e[0m"

# Contadores
TOTAL_ITEMS=0
EXISTING_ITEMS=0
MISSING_ITEMS=0

# Função para verificar diretório
check_dir() {
    local dir="$1"
    local description="$2"
    local required="${3:-false}"
    
    ((TOTAL_ITEMS++))
    
    if [[ -d "$dir" ]]; then
        local file_count=$(find "$dir" -type f 2>/dev/null | wc -l)
        local dir_count=$(find "$dir" -type d 2>/dev/null | wc -l)
        ((dir_count--)) # Remove o próprio diretório da contagem
        
        echo -e "${GREEN}✅ $description${RESET}"
        echo -e "   📁 $dir"
        echo -e "   📊 $file_count arquivos, $dir_count subdiretórios"
        ((EXISTING_ITEMS++))
    else
        if [[ "$required" == "true" ]]; then
            echo -e "${RED}❌ $description (OBRIGATÓRIO)${RESET}"
            echo -e "   📁 $dir"
        else
            echo -e "${YELLOW}⚠️  $description (OPCIONAL)${RESET}"
            echo -e "   📁 $dir"
        fi
        ((MISSING_ITEMS++))
    fi
}

# Função para verificar arquivo
check_file() {
    local file="$1"
    local description="$2"
    local required="${3:-false}"
    
    ((TOTAL_ITEMS++))
    
    if [[ -f "$file" ]]; then
        local size=$(du -h "$file" 2>/dev/null | cut -f1)
        echo -e "${GREEN}✅ $description${RESET}"
        echo -e "   📄 $file ($size)"
        ((EXISTING_ITEMS++))
    else
        if [[ "$required" == "true" ]]; then
            echo -e "${RED}❌ $description (OBRIGATÓRIO)${RESET}"
            echo -e "   📄 $file"
        else
            echo -e "${YELLOW}⚠️  $description (OPCIONAL)${RESET}"
            echo -e "   📄 $file"
        fi
        ((MISSING_ITEMS++))
    fi
}

# Função para mostrar estatísticas
show_statistics() {
    echo -e "\n${CYAN}${BOLD}📊 ESTATÍSTICAS DA VERIFICAÇÃO${RESET}"
    echo -e "${CYAN}${BOLD}==============================${RESET}"
    echo -e "• ${BOLD}Total verificado:${RESET} $TOTAL_ITEMS itens"
    echo -e "• ${GREEN}${BOLD}Encontrados:${RESET} $EXISTING_ITEMS itens"
    echo -e "• ${RED}${BOLD}Ausentes:${RESET} $MISSING_ITEMS itens"
    
    if [[ $MISSING_ITEMS -eq 0 ]]; then
        echo -e "\n${GREEN}${BOLD}🎉 Estrutura completa! Todos os itens estão presentes.${RESET}"
    else
        local percentage=$(( (EXISTING_ITEMS * 100) / TOTAL_ITEMS ))
        echo -e "\n${YELLOW}${BOLD}📈 Completo: ${percentage}%${RESET}"
    fi
}

# Função para mostrar estrutura visual
show_structure() {
    echo -e "\n${CYAN}${BOLD}🌳 ESTRUTURA DO PROJETO${RESET}"
    echo -e "${CYAN}${BOLD}=======================${RESET}"
    
    cat << 'EOF'
logs/                                    # PROJETO PRINCIPAL
├── 📁 config/                          # CONFIGURAÇÕES
│   ├── main.conf                       # Configuração principal
│   ├── paths.conf                      # Caminhos do projeto
│   ├── patterns.conf                   # Padrões de detecção
│   └── attack_patterns_learning.conf   # Padrões de aprendizado
│
├── 📁 src/                             # CÓDIGO FONTE
│   ├── 📁 scripts/
│   │   ├── 📁 core/                    # Scripts principais
│   │   ├── 📁 utils/                   # Utilitários
│   │   └── 📁 generators/              # Geradores
│   └── 📁 modules/                     # Módulos específicos
│
├── 📁 analogs/                         # LOGS PARA ANÁLISE
│   ├── 📁 services/                    # Logs de serviços
│   ├── 📁 attacks/                     # Logs de ataques
│   ├── 📁 examples/                    # Exemplos de logs
│   ├── 📁 realistic/                   # Logs realistas
│   └── 📁 custom/                      # Logs customizados
│
├── 📁 payloads/                        # PAYLOADS PARA DESENVOLVIMENTO
│   ├── 📁 sql-injection-payload-list/
│   └── 📁 xss/
│
├── 📁 results/                         # RESULTADOS
│   ├── 📁 analysis/                    # Resultados de análises
│   ├── 📁 reports/                     # Relatórios gerados
│   └── 📁 exports/                     # Dados exportados
│
├── 📁 system/                          # SISTEMA DE TREINAMENTO
│   ├── 📁 data/
│   │   ├── 📁 import/                  # Dados de entrada
│   │   ├── 📁 export/                  # Dados exportados
│   │   └── 📁 templates/               # Templates
│   ├── 📁 backup/                      # Backups
│   └── 📁 logs/                        # Logs do sistema
│
├── 📁 tests/                           # TESTES
│   ├── 📁 unit/                        # Testes unitários
│   ├── 📁 integration/                 # Testes de integração
│   ├── 📁 performance/                 # Testes de performance
│   └── 📁 results/                     # Resultados dos testes
│
├── 📁 docs/                            # DOCUMENTAÇÃO
│   ├── 📁 user/                        # Documentação para usuários
│   └── 📁 developer/                   # Documentação para desenvolvedores
│
├── 📁 temp/                            # ARQUIVOS TEMPORÁRIOS
├── 📁 scripts/                         # SCRIPTS DE AUTOMAÇÃO
├── 📁 logs/                            # LOGS DO SISTEMA
└── 📁 compilado/                       # VERSÕES COMPILADAS (FUTURO)
EOF
}

# Função principal
main() {
    echo -e "${BOLD}${CYAN}🔍 VERIFICADOR DE ESTRUTURA - SISTEMA DE ANÁLISE DE LOGS${RESET}"
    echo -e "${BOLD}${CYAN}=====================================================${RESET}"
    echo -e "${BOLD}ACADe-TI - Aula 04 (28/06/2025)${RESET}"
    echo -e "${BOLD}Autor: Jackson Savoldi | Professor: Erick Martinez${RESET}"
    echo -e "${BOLD}Diretório raiz: $PROJECT_ROOT${RESET}\n"
    
    echo -e "${CYAN}${BOLD}📁 VERIFICANDO DIRETÓRIOS PRINCIPAIS${RESET}"
    echo -e "${CYAN}${BOLD}===================================${RESET}"
    
    # Diretórios principais (obrigatórios)
    check_dir "$CONFIG_DIR" "Configurações do sistema" "true"
    check_dir "$SRC_DIR" "Código fonte" "true"
    check_dir "$ANALOGS_DIR" "Logs para análise" "true"
    check_dir "$RESULTS_DIR" "Resultados" "true"
    check_dir "$SYSTEM_DIR" "Sistema de treinamento" "true"
    check_dir "$PAYLOADS_DIR" "Payloads para desenvolvimento" "true"
    check_dir "$TEMP_DIR" "Arquivos temporários" "true"
    check_dir "$LOGS_DIR" "Logs do sistema" "true"
    check_dir "$DOCS_DIR" "Documentação" "true"
    check_dir "$TESTS_DIR" "Testes" "true"
    check_dir "$SCRIPTS_DIR" "Scripts de automação" "true"
    
    echo -e "\n${CYAN}${BOLD}📁 VERIFICANDO SUBDIRETÓRIOS${RESET}"
    echo -e "${CYAN}${BOLD}============================${RESET}"
    
    # Subdiretórios do src
    check_dir "$SRC_SCRIPTS_DIR" "Scripts do código fonte"
    check_dir "$SRC_CORE_DIR" "Scripts principais"
    check_dir "$SRC_UTILS_DIR" "Utilitários"
    check_dir "$SRC_GENERATORS_DIR" "Geradores"
    
    # Subdiretórios do analogs
    check_dir "$ANALOGS_SERVICES_DIR" "Logs de serviços"
    check_dir "$ANALOGS_ATTACKS_DIR" "Logs de ataques"
    check_dir "$ANALOGS_EXAMPLES_DIR" "Exemplos de logs"
    check_dir "$ANALOGS_REALISTIC_DIR" "Logs realistas"
    check_dir "$ANALOGS_CUSTOM_DIR" "Logs customizados"
    
    # Subdiretórios do results
    check_dir "$RESULTS_ANALYSIS_DIR" "Resultados de análises"
    check_dir "$RESULTS_REPORTS_DIR" "Relatórios gerados"
    check_dir "$RESULTS_EXPORTS_DIR" "Dados exportados"
    
    # Subdiretórios do system
    check_dir "$SYSTEM_DATA_DIR" "Dados do sistema"
    check_dir "$SYSTEM_IMPORT_DIR" "Dados de importação"
    check_dir "$SYSTEM_EXPORT_DIR" "Dados de exportação"
    check_dir "$SYSTEM_TEMPLATES_DIR" "Templates"
    check_dir "$SYSTEM_BACKUP_DIR" "Backups"
    check_dir "$SYSTEM_LOGS_DIR" "Logs do sistema"
    
    # Subdiretórios do tests
    check_dir "$TESTS_UNIT_DIR" "Testes unitários"
    check_dir "$TESTS_INTEGRATION_DIR" "Testes de integração"
    check_dir "$TESTS_PERFORMANCE_DIR" "Testes de performance"
    check_dir "$TESTS_RESULTS_DIR" "Resultados dos testes"
    
    # Subdiretórios do docs
    check_dir "$DOCS_USER_DIR" "Documentação para usuários"
    check_dir "$DOCS_DEVELOPER_DIR" "Documentação para desenvolvedores"
    
    # Subdiretórios do temp
    check_dir "$TEMP_CACHE_DIR" "Cache temporário"
    check_dir "$TEMP_DOWNLOADS_DIR" "Downloads temporários"
    check_dir "$TEMP_PROCESSING_DIR" "Processamento temporário"
    
    echo -e "\n${CYAN}${BOLD}📄 VERIFICANDO ARQUIVOS DE CONFIGURAÇÃO${RESET}"
    echo -e "${CYAN}${BOLD}========================================${RESET}"
    
    # Arquivos de configuração (obrigatórios)
    check_file "$MAIN_CONFIG_FILE" "Configuração principal" "true"
    check_file "$PATTERNS_CONFIG_FILE" "Configuração de padrões" "true"
    check_file "$ATTACK_PATTERNS_FILE" "Padrões de aprendizado" "true"
    
    # Arquivos de configuração de caminhos
    check_file "$CONFIG_DIR/paths.conf" "Configuração de caminhos" "true"
    
    echo -e "\n${CYAN}${BOLD}📄 VERIFICANDO SCRIPT PRINCIPAL${RESET}"
    echo -e "${CYAN}${BOLD}==============================${RESET}"
    
    # Scripts principais
    check_file "$SRC_CORE_DIR/scriptlogs.sh" "Script principal"
    check_file "$SRC_CORE_DIR/scriptlogs_avancado.sh" "Script avançado"
    check_file "$SRC_UTILS_DIR/config_loader.sh" "Carregador de configuração"
    check_file "$SRC_UTILS_DIR/csv_to_training_system.sh" "Conversor CSV"
    
    # Mostrar estatísticas
    show_statistics
    
    # Mostrar estrutura visual
    show_structure
    
    echo -e "\n${CYAN}${BOLD}💡 COMANDOS ÚTEIS${RESET}"
    echo -e "${CYAN}${BOLD}================${RESET}"
    echo -e "• ${GREEN}cd $ANALOGS_DIR${RESET} - Navegar para logs de análise"
    echo -e "• ${GREEN}cd $RESULTS_DIR${RESET} - Ver resultados"
    echo -e "• ${GREEN}cd $PAYLOADS_DIR${RESET} - Ver payloads"
    echo -e "• ${GREEN}cd $DOCS_USER_DIR${RESET} - Ver documentação do usuário"
    echo -e "• ${GREEN}ls -la $ANALOGS_ATTACKS_DIR${RESET} - Listar logs de ataques"
    echo -e "• ${GREEN}ls -la $RESULTS_REPORTS_DIR${RESET} - Listar relatórios"
}

# Executar função principal
main "$@" 