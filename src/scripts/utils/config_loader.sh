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

# Variáveis globais
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../../../" && pwd)"

# Função para carregar configuração de forma segura
load_config_safely() {
    local config_file="$1"
    local config_type="$2"
    
    if [[ ! -f "$config_file" ]]; then
        echo -e "${YELLOW}⚠️ Arquivo de configuração não encontrado: $config_file${RESET}"
        return 1
    fi
    
    case "$config_type" in
        "patterns")
            load_patterns_config "$config_file"
            ;;
        "main")
            load_main_config "$config_file"
            ;;
        "paths")
            load_paths_config "$config_file"
            ;;
        *)
            echo -e "${RED}❌ Tipo de configuração desconhecido: $config_type${RESET}"
            return 1
            ;;
    esac
}

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
        # Carrega configurações de forma segura, sem executar o arquivo
        while IFS= read -r line || [[ -n "$line" ]]; do
            # Pula comentários e linhas vazias
            [[ "$line" =~ ^[[:space:]]*# ]] && continue
            [[ -z "$line" ]] && continue
            
            # Processa apenas linhas que contêm atribuições
            if [[ "$line" =~ ^[[:space:]]*[A-Z_][A-Z0-9_]*[[:space:]]*=[[:space:]]* ]]; then
                # Remove espaços extras e executa a atribuição
                eval "$line"
            fi
        done < "$config_file"
        
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
        # Carrega configurações de forma segura, sem executar o arquivo
        while IFS= read -r line || [[ -n "$line" ]]; do
            # Pula comentários e linhas vazias
            [[ "$line" =~ ^[[:space:]]*# ]] && continue
            [[ -z "$line" ]] && continue
            
            # Processa apenas linhas que contêm atribuições
            if [[ "$line" =~ ^[[:space:]]*[A-Z_][A-Z0-9_]*[[:space:]]*=[[:space:]]* ]]; then
                # Remove espaços extras e executa a atribuição
                eval "$line"
            fi
        done < "$config_file"
        
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
    echo "  📋 Carregando padrões de ataque..."
    
    if [[ ! -f "$config_file" ]]; then
        echo -e "${YELLOW}⚠️ Arquivo de padrões não encontrado${RESET}"
        return 1
    fi
    
    # Inicializa arrays
    PATTERNS=()
    SEVERITIES=()
    DESCRIPTIONS=()
    SCORES=()
    TAGS=()
    
    local line_number=0
    local patterns_loaded=0
    
    while IFS= read -r line || [[ -n "$line" ]]; do
        ((line_number++))
        # Pula comentários e linhas vazias
        [[ "$line" =~ ^[[:space:]]*# ]] && continue
        [[ -z "$line" ]] && continue
        # Espera formato: regex|SEVERIDADE|descrição|pontuação|tags
        IFS='|' read -r pattern severity description score tags <<< "$line"
        # Remove espaços extras
        pattern="${pattern//\"/}"
        severity="${severity//\"/}"
        description="${description//\"/}"
        score="${score//\"/}"
        tags="${tags//\"/}"
        # Valida campos obrigatórios
        if [[ -n "$pattern" && -n "$severity" && -n "$description" ]]; then
            PATTERNS+=("$pattern")
            SEVERITIES+=("$severity")
            DESCRIPTIONS+=("$description")
            SCORES+=("${score:-0}")
            TAGS+=("${tags:-}")
            ((patterns_loaded++))
        else
            echo -e "${YELLOW}⚠️ Linha $line_number: Formato inválido${RESET}"
        fi
    done < "$config_file"
    
    echo "  ✅ $patterns_loaded padrões carregados"
    return 0
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

# Função para obter padrão por índice
get_pattern() {
    local index="$1"
    
    if [[ $index -ge 0 && $index -lt ${#PATTERNS[@]} ]]; then
        echo "${PATTERNS[$index]}"
    else
        echo ""
    fi
}

# Função para obter severidade por índice
get_severity() {
    local index="$1"
    
    if [[ $index -ge 0 && $index -lt ${#SEVERITIES[@]} ]]; then
        echo "${SEVERITIES[$index]}"
    else
        echo ""
    fi
}

# Função para obter descrição por índice
get_description() {
    local index="$1"
    
    if [[ $index -ge 0 && $index -lt ${#DESCRIPTIONS[@]} ]]; then
        echo "${DESCRIPTIONS[$index]}"
    else
        echo ""
    fi
}

# Função para obter pontuação por índice
get_score() {
    local index="$1"
    
    if [[ $index -ge 0 && $index -lt ${#SCORES[@]} ]]; then
        echo "${SCORES[$index]}"
    else
        echo "0"
    fi
}

# Função para obter tags por índice
get_tags() {
    local index="$1"
    
    if [[ $index -ge 0 && $index -lt ${#TAGS[@]} ]]; then
        echo "${TAGS[$index]}"
    else
        echo ""
    fi
}

# Função para obter número total de padrões
get_pattern_count() {
    echo "${#PATTERNS[@]}"
}

# Função para buscar padrões por tag
find_patterns_by_tag() {
    local search_tag="$1"
    local found_patterns=()
    
    for i in "${!TAGS[@]}"; do
        if [[ "${TAGS[$i]}" == *"$search_tag"* ]]; then
            found_patterns+=("$i")
        fi
    done
    
    echo "${found_patterns[@]}"
}

# Função para buscar padrões por severidade
find_patterns_by_severity() {
    local search_severity="$1"
    local found_patterns=()
    
    for i in "${!SEVERITIES[@]}"; do
        if [[ "${SEVERITIES[$i]}" == "$search_severity" ]]; then
            found_patterns+=("$i")
        fi
    done
    
    echo "${found_patterns[@]}"
}

# Função para listar todos os padrões
list_all_patterns() {
    echo "📋 PADRÕES CARREGADOS"
    echo "===================="
    
    for i in "${!PATTERNS[@]}"; do
        echo "[$i] ${PATTERNS[$i]}"
        echo "    Severidade: ${SEVERITIES[$i]}"
        echo "    Pontuação: ${SCORES[$i]}"
        echo "    Descrição: ${DESCRIPTIONS[$i]}"
        echo "    Tags: ${TAGS[$i]}"
        echo
    done
}

# Função para validar configuração
validate_config() {
    echo "🔍 Validando configuração..."
    
    local errors=0
    
    # Valida padrões
    if [[ ${#PATTERNS[@]} -eq 0 ]]; then
        echo -e "${YELLOW}⚠️ Nenhum padrão carregado${RESET}"
        ((errors++))
    else
        echo "  ✅ ${#PATTERNS[@]} padrões válidos"
    fi
    
    # Valida severidades
    if [[ ${#SEVERITIES[@]} -eq 0 ]]; then
        echo -e "${YELLOW}⚠️ Nenhuma severidade carregada${RESET}"
        ((errors++))
    else
        echo "  ✅ ${#SEVERITIES[@]} severidades válidas"
    fi
    
    # Valida descrições
    if [[ ${#DESCRIPTIONS[@]} -eq 0 ]]; then
        echo -e "${YELLOW}⚠️ Nenhuma descrição carregada${RESET}"
        ((errors++))
    else
        echo "  ✅ ${#DESCRIPTIONS[@]} descrições válidas"
    fi
    
    if [[ $errors -eq 0 ]]; then
        echo -e "${GREEN}✅ Configuração válida${RESET}"
        return 0
    else
        echo -e "${YELLOW}⚠️ $errors problema(s) encontrado(s)${RESET}"
        return 1
    fi
}

# Função para mostrar estatísticas
show_config_stats() {
    echo "📊 ESTATÍSTICAS DA CONFIGURAÇÃO"
    echo "==============================="
    
    echo "Padrões: ${#PATTERNS[@]}"
    echo "Severidades: ${#SEVERITIES[@]}"
    echo "Descrições: ${#DESCRIPTIONS[@]}"
    echo "Pontuações: ${#SCORES[@]}"
    echo "Tags: ${#TAGS[@]}"
    
    # Conta severidades
    local critical=0 medium=0 low=0 high=0
    
    for severity in "${SEVERITIES[@]}"; do
        case "$severity" in
            "CRÍTICO"|"10") ((critical++)) ;;
            "ALTO"|"7") ((high++)) ;;
            "MÉDIO"|"4") ((medium++)) ;;
            "BAIXO"|"1") ((low++)) ;;
        esac
    done
    
    echo
    echo "Distribuição por Severidade:"
    echo "  Crítico: $critical"
    echo "  Alto: $high"
    echo "  Médio: $medium"
    echo "  Baixo: $low"
}

# Função principal
main() {
    case "${1:-load}" in
        "load")
            # Inicializa arrays
            PATTERNS=()
            SEVERITIES=()
            DESCRIPTIONS=()
            SCORES=()
            TAGS=()
            
            # Carrega configurações
            load_config_safely "$PROJECT_ROOT/config/attack_patterns_learning.conf" "patterns"
            load_config_safely "$PROJECT_ROOT/config/main.conf" "main"
            load_config_safely "$PROJECT_ROOT/config/paths.conf" "paths"
            
            # Valida configuração
            validate_config
            ;;
        "list")
            # Carrega e lista padrões
            PATTERNS=()
            SEVERITIES=()
            DESCRIPTIONS=()
            SCORES=()
            TAGS=()
            
            load_config_safely "$PROJECT_ROOT/config/attack_patterns_learning.conf" "patterns"
            list_all_patterns
            ;;
        "stats")
            # Carrega e mostra estatísticas
            PATTERNS=()
            SEVERITIES=()
            DESCRIPTIONS=()
            SCORES=()
            TAGS=()
            
            load_config_safely "$PROJECT_ROOT/config/attack_patterns_learning.conf" "patterns"
            show_config_stats
            ;;
        "validate")
            # Valida configuração
            PATTERNS=()
            SEVERITIES=()
            DESCRIPTIONS=()
            SCORES=()
            TAGS=()
            
            load_config_safely "$PROJECT_ROOT/config/attack_patterns_learning.conf" "patterns"
            validate_config
            ;;
        "help"|*)
            echo "Uso: $0 [comando]"
            echo
            echo "Comandos:"
            echo "  load     - Carrega todas as configurações (padrão)"
            echo "  list     - Lista todos os padrões carregados"
            echo "  stats    - Mostra estatísticas da configuração"
            echo "  validate - Valida a configuração"
            echo "  help     - Mostra esta ajuda"
            ;;
    esac
}

# Executa se chamado diretamente
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi 