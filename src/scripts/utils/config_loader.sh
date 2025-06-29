#!/bin/bash

# ===================================================================================
# CARREGADOR DE CONFIGURAÇÃO - SISTEMA DE ANÁLISE DE LOGS
# ===================================================================================
# Utilitário para carregar configurações de forma centralizada
# Autor: Jackson Savoldi | ACADe-TI - Aula 04
# ===================================================================================

# Cores para output
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
CYAN="\e[36m"
WHITE="\e[37m"
BOLD="\e[1m"
RESET="\e[0m"

# Função para carregar configuração de caminhos
load_paths_config() {
    local config_file="$1"
    
    if [[ -z "$config_file" ]]; then
        # Tenta encontrar o arquivo de configuração automaticamente
        local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
        local project_root="$(cd "$script_dir/../../.." && pwd)"
        config_file="$project_root/config/paths.conf"
    fi
    
    if [[ -f "$config_file" ]]; then
        source "$config_file"
        if [[ "$VERBOSE" == "true" ]]; then
            echo -e "${GREEN}${BOLD}✅ Configuração carregada: $config_file${RESET}"
        fi
        return 0
    else
        echo -e "${RED}${BOLD}❌ Arquivo de configuração não encontrado: $config_file${RESET}"
        return 1
    fi
}

# Função para carregar configuração principal
load_main_config() {
    local config_file="$1"
    
    if [[ -z "$config_file" ]]; then
        config_file="$MAIN_CONFIG_FILE"
    fi
    
    if [[ -f "$config_file" ]]; then
        source "$config_file"
        if [[ "$VERBOSE" == "true" ]]; then
            echo -e "${GREEN}${BOLD}✅ Configuração principal carregada: $config_file${RESET}"
        fi
        return 0
    else
        echo -e "${YELLOW}${BOLD}⚠️  Arquivo de configuração principal não encontrado: $config_file${RESET}"
        return 1
    fi
}

# Função para carregar configuração de padrões
load_patterns_config() {
    local config_file="$1"
    
    if [[ -z "$config_file" ]]; then
        config_file="$PATTERNS_CONFIG_FILE"
    fi
    
    if [[ -f "$config_file" ]]; then
        source "$config_file"
        if [[ "$VERBOSE" == "true" ]]; then
            echo -e "${GREEN}${BOLD}✅ Configuração de padrões carregada: $config_file${RESET}"
        fi
        return 0
    else
        echo -e "${YELLOW}${BOLD}⚠️  Arquivo de configuração de padrões não encontrado: $config_file${RESET}"
        return 1
    fi
}

# Função para carregar todas as configurações
load_all_configs() {
    local verbose="${1:-false}"
    VERBOSE="$verbose"
    
    echo -e "${CYAN}${BOLD}🔧 CARREGANDO CONFIGURAÇÕES DO SISTEMA${RESET}"
    echo -e "${CYAN}${BOLD}=====================================${RESET}"
    
    # Carrega configuração de caminhos primeiro
    if ! load_paths_config; then
        echo -e "${RED}${BOLD}❌ Falha ao carregar configuração de caminhos${RESET}"
        return 1
    fi
    
    # Carrega outras configurações
    load_main_config
    load_patterns_config
    
    echo -e "${GREEN}${BOLD}✅ Todas as configurações carregadas com sucesso${RESET}"
    return 0
}

# Função para verificar se todos os diretórios necessários existem
verify_directories() {
    local missing_dirs=()
    
    echo -e "${CYAN}${BOLD}📁 VERIFICANDO ESTRUTURA DE DIRETÓRIOS${RESET}"
    echo -e "${CYAN}${BOLD}=====================================${RESET}"
    
    # Lista de diretórios essenciais
    local essential_dirs=(
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
    )
    
    for dir in "${essential_dirs[@]}"; do
        if [[ ! -d "$dir" ]]; then
            missing_dirs+=("$dir")
            echo -e "${RED}❌ Diretório não encontrado: $dir${RESET}"
        else
            echo -e "${GREEN}✅ Diretório encontrado: $dir${RESET}"
        fi
    done
    
    if [[ ${#missing_dirs[@]} -gt 0 ]]; then
        echo -e "${YELLOW}${BOLD}⚠️  Diretórios ausentes: ${missing_dirs[*]}${RESET}"
        return 1
    else
        echo -e "${GREEN}${BOLD}✅ Todos os diretórios essenciais encontrados${RESET}"
        return 0
    fi
}

# Função para criar diretórios ausentes
create_missing_directories() {
    local dirs_to_create=(
        "$RESULTS_ANALYSIS_DIR"
        "$RESULTS_REPORTS_DIR"
        "$RESULTS_EXPORTS_DIR"
        "$TEMP_CACHE_DIR"
        "$TEMP_DOWNLOADS_DIR"
        "$TEMP_PROCESSING_DIR"
        "$COMPILADO_DIR"
    )
    
    echo -e "${CYAN}${BOLD}📁 CRIANDO DIRETÓRIOS AUSENTES${RESET}"
    echo -e "${CYAN}${BOLD}==============================${RESET}"
    
    for dir in "${dirs_to_create[@]}"; do
        if [[ ! -d "$dir" ]]; then
            mkdir -p "$dir"
            echo -e "${GREEN}✅ Criado: $dir${RESET}"
        else
            echo -e "${BLUE}ℹ️  Já existe: $dir${RESET}"
        fi
    done
}

# Função para mostrar informações do projeto
show_project_info() {
    echo -e "${CYAN}${BOLD}📊 INFORMAÇÕES DO PROJETO${RESET}"
    echo -e "${CYAN}${BOLD}========================${RESET}"
    echo -e "• ${BOLD}Diretório raiz:${RESET} $PROJECT_ROOT"
    echo -e "• ${BOLD}Configurações:${RESET} $CONFIG_DIR"
    echo -e "• ${BOLD}Código fonte:${RESET} $SRC_DIR"
    echo -e "• ${BOLD}Logs para análise:${RESET} $ANALOGS_DIR"
    echo -e "• ${BOLD}Resultados:${RESET} $RESULTS_DIR"
    echo -e "• ${BOLD}Sistema:${RESET} $SYSTEM_DIR"
    echo -e "• ${BOLD}Payloads:${RESET} $PAYLOADS_DIR"
    echo -e "• ${BOLD}Documentação:${RESET} $DOCS_DIR"
    echo -e "• ${BOLD}Testes:${RESET} $TESTS_DIR"
}

# Função principal para inicialização
initialize_system() {
    local verbose="${1:-false}"
    
    echo -e "${BOLD}${CYAN}🚀 INICIALIZANDO SISTEMA DE ANÁLISE DE LOGS${RESET}"
    echo -e "${BOLD}${CYAN}============================================${RESET}"
    
    # Carrega todas as configurações
    if ! load_all_configs "$verbose"; then
        return 1
    fi
    
    # Verifica diretórios
    if ! verify_directories; then
        echo -e "${YELLOW}${BOLD}⚠️  Alguns diretórios estão ausentes${RESET}"
    fi
    
    # Cria diretórios ausentes
    create_missing_directories
    
    # Mostra informações
    show_project_info
    
    echo -e "${GREEN}${BOLD}✅ Sistema inicializado com sucesso${RESET}"
    return 0
}

# Se executado diretamente, inicializa o sistema
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    initialize_system "true"
fi 