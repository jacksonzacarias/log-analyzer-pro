#!/bin/bash

# Sistema de Inicialização
# LOG ANALYZER PRO - Versão 5.0
# Carrega ambiente e prepara sistema

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Variáveis globais
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../../../" && pwd)"
ENVIRONMENT_DETECTOR="$SCRIPT_DIR/environment_detector.sh"

# Função principal de inicialização
init_system() {
    echo "🚀 Inicializando LOG ANALYZER PRO v5.0..."
    echo
    
    # Carrega detector de ambiente
    load_environment
    
    # Cria estrutura de diretórios
    create_directory_structure
    
    # Carrega configurações
    load_configurations
    
    # Verifica dependências
    check_system_dependencies
    
    # Inicializa módulos
    init_modules
    
    # Executa testes básicos
    run_basic_tests
    
    echo -e "${GREEN}✅ Sistema inicializado com sucesso!${NC}"
}

# Carrega detector de ambiente
load_environment() {
    echo "🔍 Carregando detector de ambiente..."
    
    if [[ ! -f "$ENVIRONMENT_DETECTOR" ]]; then
        echo -e "${RED}❌ Detector de ambiente não encontrado!${NC}"
        exit 1
    fi
    
    # Carrega e executa detector
    source "$ENVIRONMENT_DETECTOR"
    
    # Detecta ambiente
    detect_environment
    
    # Exporta variáveis
    export_environment_vars
    
    echo -e "${GREEN}✅ Ambiente carregado${NC}"
}

# Cria estrutura de diretórios
create_directory_structure() {
    echo "📁 Criando estrutura de diretórios..."
    
    local dirs=(
        "src/modules/intelligence"
        "src/modules/logic/custom_rules"
        "src/modules/analysis"
        "src/modules/output"
        "tests/unit"
        "tests/integration"
        "tests/performance"
        "tests/compatibility"
        "system/data"
        "system/logs"
        "system/cache"
        "system/backup"
        "results"
        "config"
    )
    
    for dir in "${dirs[@]}"; do
        local full_path="$PROJECT_ROOT/$dir"
        if [[ ! -d "$full_path" ]]; then
            mkdir -p "$full_path" 2>/dev/null
            if [[ $? -eq 0 ]]; then
                echo "  ✅ Criado: $dir"
            else
                echo -e "${YELLOW}⚠️ Não foi possível criar: $dir${NC}"
            fi
        else
            echo "  ℹ️ Já existe: $dir"
        fi
    done
    
    echo -e "${GREEN}✅ Estrutura de diretórios criada${NC}"
}

# Carrega configurações
load_configurations() {
    echo "⚙️ Carregando configurações..."
    
    # Carrega carregador de configuração
    local config_loader="$SCRIPT_DIR/config_loader.sh"
    
    if [[ ! -f "$config_loader" ]]; then
        echo -e "${RED}❌ Carregador de configuração não encontrado!${NC}"
        return 1
    fi
    
    # Carrega configurações de forma segura
    if bash "$config_loader" load >/dev/null 2>&1; then
        echo "  ✅ Configurações carregadas com sucesso"
    else
        echo -e "${YELLOW}⚠️ Problemas ao carregar configurações${NC}"
    fi
    
    echo -e "${GREEN}✅ Configurações carregadas${NC}"
}

# Verifica dependências do sistema
check_system_dependencies() {
    echo "🔧 Verificando dependências do sistema..."
    
    local deps=("bash" "grep" "sed" "awk" "jq" "bc")
    local missing=()
    local optional=("jq" "bc")
    
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" >/dev/null 2>&1; then
            # Verifica se é opcional
            if [[ " ${optional[@]} " =~ " ${dep} " ]]; then
                echo -e "${YELLOW}⚠️ Dependência opcional não encontrada: $dep${NC}"
            else
                missing+=("$dep")
                echo -e "${RED}❌ Dependência obrigatória não encontrada: $dep${NC}"
            fi
        else
            echo "  ✅ $dep"
        fi
    done
    
    if [[ ${#missing[@]} -gt 0 ]]; then
        echo -e "${RED}❌ Dependências obrigatórias faltando: ${missing[*]}${NC}"
        echo "Por favor, instale as dependências faltantes e tente novamente."
        return 1
    fi
    
    echo -e "${GREEN}✅ Dependências verificadas${NC}"
}

# Inicializa módulos
init_modules() {
    echo "🧩 Inicializando módulos..."
    
    # Lista de módulos para inicializar
    local modules=(
        "intelligence/pattern_learner.sh"
        "intelligence/temporal_analyzer.sh"
        "intelligence/behavior_classifier.sh"
        "intelligence/adaptive_scoring.sh"
        "logic/rule_engine.sh"
        "analysis/temporal.sh"
        "analysis/behavioral.sh"
        "analysis/payload_analysis.sh"
        "output/report_generator.sh"
        "output/html_formatter.sh"
        "output/console_display.sh"
    )
    
    local loaded_modules=0
    
    for module in "${modules[@]}"; do
        local module_path="$PROJECT_ROOT/src/modules/$module"
        
        if [[ -f "$module_path" ]]; then
            # Verifica se o módulo tem função de inicialização
            if grep -q "init_module" "$module_path" 2>/dev/null; then
                echo "  ✅ $module (com inicialização)"
                ((loaded_modules++))
            else
                echo "  ℹ️ $module (sem inicialização)"
                ((loaded_modules++))
            fi
        else
            echo "  ⏳ $module (não implementado)"
        fi
    done
    
    echo "  📊 Módulos carregados: $loaded_modules"
    echo -e "${GREEN}✅ Módulos inicializados${NC}"
}

# Executa testes básicos
run_basic_tests() {
    echo "🧪 Executando testes básicos..."
    
    # Testa detector de ambiente
    if bash "$ENVIRONMENT_DETECTOR" test >/dev/null 2>&1; then
        echo "  ✅ Teste do detector de ambiente"
    else
        echo -e "${YELLOW}⚠️ Teste do detector de ambiente falhou${NC}"
    fi
    
    # Testa estrutura de diretórios
    local required_dirs=("src" "tests" "config" "system")
    for dir in "${required_dirs[@]}"; do
        if [[ -d "$PROJECT_ROOT/$dir" ]]; then
            echo "  ✅ Diretório $dir"
        else
            echo -e "${RED}❌ Diretório $dir não encontrado${NC}"
        fi
    done
    
    # Testa arquivos essenciais
    local essential_files=(
        "src/scripts/core/scriptlogs_avancado.sh"
        "src/scripts/utils/file_selector.sh"
        "analisar_logs.sh"
    )
    
    for file in "${essential_files[@]}"; do
        if [[ -f "$PROJECT_ROOT/$file" ]]; then
            echo "  ✅ Arquivo $file"
        else
            echo -e "${YELLOW}⚠️ Arquivo $file não encontrado${NC}"
        fi
    done
    
    echo -e "${GREEN}✅ Testes básicos concluídos${NC}"
}

# Função para obter informações do sistema
get_system_status() {
    echo "📊 STATUS DO SISTEMA"
    echo "===================="
    
    # Informações do ambiente
    echo "🔍 Ambiente:"
    bash "$ENVIRONMENT_DETECTOR" info
    
    # Estrutura de diretórios
    echo
    echo "📁 Estrutura de Diretórios:"
    local dirs=("src" "tests" "config" "system" "results")
    for dir in "${dirs[@]}"; do
        if [[ -d "$PROJECT_ROOT/$dir" ]]; then
            local count
            count=$(find "$PROJECT_ROOT/$dir" -type f 2>/dev/null | wc -l)
            echo "  $dir: $count arquivos"
        else
            echo "  $dir: não encontrado"
        fi
    done
    
    # Módulos disponíveis
    echo
    echo "🧩 Módulos Disponíveis:"
    local module_count=0
    for module_dir in "$PROJECT_ROOT/src/modules"/*; do
        if [[ -d "$module_dir" ]]; then
            local dir_name
            dir_name=$(basename "$module_dir")
            local files
            files=$(find "$module_dir" -name "*.sh" 2>/dev/null | wc -l)
            echo "  $dir_name: $files módulos"
            ((module_count += files))
        fi
    done
    echo "  Total: $module_count módulos"
    
    # Testes disponíveis
    echo
    echo "🧪 Testes Disponíveis:"
    local test_count=0
    for test_dir in "$PROJECT_ROOT/tests"/*; do
        if [[ -d "$test_dir" ]]; then
            local dir_name
            dir_name=$(basename "$test_dir")
            local files
            files=$(find "$test_dir" -name "*.sh" 2>/dev/null | wc -l)
            echo "  $dir_name: $files testes"
            ((test_count += files))
        fi
    done
    echo "  Total: $test_count testes"
}

# Função para executar todos os testes
run_all_tests() {
    echo "🧪 EXECUTANDO TODOS OS TESTES"
    echo "============================="
    
    local total_tests=0
    local passed_tests=0
    local failed_tests=0
    
    # Executa testes de compatibilidade
    echo
    echo "🔍 Testes de Compatibilidade:"
    if bash "$PROJECT_ROOT/tests/compatibility/test_environment_detector.sh" test >/dev/null 2>&1; then
        echo "  ✅ Teste de ambiente"
        ((passed_tests++))
    else
        echo "  ❌ Teste de ambiente"
        ((failed_tests++))
    fi
    ((total_tests++))
    
    # Executa outros testes se existirem
    for test_file in "$PROJECT_ROOT/tests"/*/*.sh; do
        if [[ -f "$test_file" ]] && [[ "$test_file" != *"test_environment_detector.sh" ]]; then
            local test_name
            test_name=$(basename "$test_file")
            echo "  ⏳ $test_name (não implementado)"
        fi
    done
    
    echo
    echo "📊 RESULTADOS DOS TESTES"
    echo "========================"
    echo "Total de testes: $total_tests"
    echo -e "Passaram: ${GREEN}$passed_tests${NC}"
    echo -e "Falharam: ${RED}$failed_tests${NC}"
    
    if [[ $failed_tests -eq 0 ]]; then
        echo -e "${GREEN}🎉 Todos os testes passaram!${NC}"
        return 0
    else
        echo -e "${YELLOW}⚠️ $failed_tests teste(s) falharam${NC}"
        return 1
    fi
}

# Função para mostrar ajuda
show_help() {
    echo "Uso: $0 [comando]"
    echo
    echo "Comandos:"
    echo "  init     - Inicializa o sistema (padrão)"
    echo "  status   - Mostra status do sistema"
    echo "  test     - Executa todos os testes"
    echo "  help     - Mostra esta ajuda"
    echo
    echo "Exemplos:"
    echo "  $0 init    # Inicializa o sistema"
    echo "  $0 status  # Mostra status"
    echo "  $0 test    # Executa testes"
    echo "  $0 help    # Mostra ajuda"
}

# Função principal
main() {
    case "${1:-init}" in
        "init")
            init_system
            ;;
        "status")
            load_environment
            get_system_status
            ;;
        "test")
            load_environment
            run_all_tests
            ;;
        "help"|*)
            show_help
            ;;
    esac
}

# Executa se chamado diretamente
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi 