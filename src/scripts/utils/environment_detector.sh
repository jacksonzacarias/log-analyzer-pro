#!/bin/bash

# Sistema de Detecção de Ambiente
# LOG ANALYZER PRO - Versão 5.0
# Compatibilidade Multi-Plataforma

# Variáveis globais de ambiente
ENVIRONMENT=""
SHELL_TYPE=""
OS_TYPE=""
TEMP_DIR=""
CONFIG_DIR=""
LOG_DIR=""

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Função principal de detecção
detect_environment() {
    echo "🔍 Detectando ambiente..."
    
    # Detecta tipo de shell
    detect_shell_type
    
    # Detecta sistema operacional
    detect_os_type
    
    # Detecta ambiente específico
    detect_specific_environment
    
    # Configura diretórios
    setup_directories
    
    # Valida ambiente
    validate_environment
    
    echo -e "${GREEN}✅ Ambiente detectado: $ENVIRONMENT ($OS_TYPE)${NC}"
}

# Detecta tipo de shell
detect_shell_type() {
    if [[ -n "$BASH_VERSION" ]]; then
        SHELL_TYPE="bash"
    elif [[ -n "$ZSH_VERSION" ]]; then
        SHELL_TYPE="zsh"
    else
        SHELL_TYPE="unknown"
    fi
    
    echo "  Shell: $SHELL_TYPE"
}

# Detecta sistema operacional
detect_os_type() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        OS_TYPE="linux"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        OS_TYPE="macos"
    elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
        OS_TYPE="windows"
    elif [[ "$OSTYPE" == "freebsd"* ]]; then
        OS_TYPE="freebsd"
    else
        OS_TYPE="unknown"
    fi
    
    echo "  OS: $OS_TYPE"
}

# Detecta ambiente específico
detect_specific_environment() {
    case $OS_TYPE in
        "linux")
            # Verifica se é WSL
            if [[ -f "/proc/version" ]] && grep -q "Microsoft" "/proc/version" 2>/dev/null; then
                ENVIRONMENT="wsl"
                echo "  Ambiente: WSL (Windows Subsystem for Linux)"
            elif [[ -f "/etc/os-release" ]] && grep -q "kali" "/etc/os-release" 2>/dev/null; then
                ENVIRONMENT="kali"
                echo "  Ambiente: Kali Linux"
            elif [[ -f "/etc/os-release" ]] && grep -q "ubuntu" "/etc/os-release" 2>/dev/null; then
                ENVIRONMENT="ubuntu"
                echo "  Ambiente: Ubuntu"
            elif [[ -f "/etc/os-release" ]] && grep -q "debian" "/etc/os-release" 2>/dev/null; then
                ENVIRONMENT="debian"
                echo "  Ambiente: Debian"
            else
                ENVIRONMENT="linux"
                echo "  Ambiente: Linux Genérico"
            fi
            ;;
        "windows")
            ENVIRONMENT="windows"
            echo "  Ambiente: Windows"
            ;;
        "macos")
            ENVIRONMENT="macos"
            echo "  Ambiente: macOS"
            ;;
        *)
            ENVIRONMENT="unknown"
            echo "  Ambiente: Desconhecido"
            ;;
    esac
}

# Configura diretórios baseados no ambiente
setup_directories() {
    case $ENVIRONMENT in
        "wsl"|"kali"|"ubuntu"|"debian"|"linux")
            TEMP_DIR="/tmp"
            CONFIG_DIR="$HOME/.config/log-analyzer-pro"
            LOG_DIR="/var/log/log-analyzer-pro"
            ;;
        "windows")
            TEMP_DIR="C:/temp"
            CONFIG_DIR="$HOME/AppData/Local/log-analyzer-pro"
            LOG_DIR="C:/logs/log-analyzer-pro"
            ;;
        "macos")
            TEMP_DIR="/tmp"
            CONFIG_DIR="$HOME/Library/Application Support/log-analyzer-pro"
            LOG_DIR="/var/log/log-analyzer-pro"
            ;;
        *)
            TEMP_DIR="/tmp"
            CONFIG_DIR="./config"
            LOG_DIR="./logs"
            ;;
    esac
    
    echo "  Temp: $TEMP_DIR"
    echo "  Config: $CONFIG_DIR"
    echo "  Logs: $LOG_DIR"
}

# Valida ambiente
validate_environment() {
    local issues=0
    
    # Verifica se é um ambiente suportado
    if [[ "$ENVIRONMENT" == "unknown" ]]; then
        echo -e "${YELLOW}⚠️ Ambiente não reconhecido${NC}"
        ((issues++))
    fi
    
    # Verifica permissões de escrita
    if ! is_writable "$TEMP_DIR"; then
        echo -e "${YELLOW}⚠️ Diretório temporário não tem permissão de escrita${NC}"
        ((issues++))
    fi
    
    # Verifica dependências básicas
    check_dependencies
    
    if [[ $issues -eq 0 ]]; then
        echo -e "${GREEN}✅ Ambiente validado com sucesso${NC}"
    else
        echo -e "${YELLOW}⚠️ $issues problema(s) encontrado(s)${NC}"
    fi
}

# Verifica se diretório é gravável
is_writable() {
    local dir="$1"
    
    if [[ "$ENVIRONMENT" == "windows" ]]; then
        # Teste específico para Windows
        if [[ -d "$dir" ]] && [[ -w "$dir" ]]; then
            return 0
        else
            # Tenta criar o diretório
            mkdir -p "$dir" 2>/dev/null && return 0 || return 1
        fi
    else
        # Teste para Unix/Linux
        [[ -d "$dir" ]] && [[ -w "$dir" ]]
    fi
}

# Verifica dependências
check_dependencies() {
    echo "  Verificando dependências..."
    
    local deps=("bash" "grep" "sed" "awk" "jq")
    local missing=()
    
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" >/dev/null 2>&1; then
            missing+=("$dep")
        fi
    done
    
    if [[ ${#missing[@]} -gt 0 ]]; then
        echo -e "${YELLOW}⚠️ Dependências faltando: ${missing[*]}${NC}"
        return 1
    else
        echo -e "${GREEN}✅ Todas as dependências encontradas${NC}"
        return 0
    fi
}

# Função para obter diretório temporário
get_temp_dir() {
    echo "$TEMP_DIR"
}

# Função para obter diretório de configuração
get_config_dir() {
    echo "$CONFIG_DIR"
}

# Função para obter diretório de logs
get_log_dir() {
    echo "$LOG_DIR"
}

# Função para adaptar comandos
adapt_command() {
    local command="$1"
    
    case $ENVIRONMENT in
        "windows")
            # Adapta comandos para Windows
            command=$(echo "$command" | sed 's/\/tmp\//C:\/temp\//g')
            command=$(echo "$command" | sed 's/\/home\//C:\/Users\//g')
            ;;
        "wsl")
            # Comandos nativos WSL
            ;;
        "kali"|"ubuntu"|"debian"|"linux")
            # Comandos nativos Linux
            ;;
    esac
    
    echo "$command"
}

# Função para obter comando de data
get_date_command() {
    if command -v gdate >/dev/null 2>&1; then
        echo "gdate"
    else
        echo "date"
    fi
}

# Função para obter comando de sed
get_sed_command() {
    if command -v gsed >/dev/null 2>&1; then
        echo "gsed"
    else
        echo "sed"
    fi
}

# Função para obter comando de awk
get_awk_command() {
    if command -v gawk >/dev/null 2>&1; then
        echo "gawk"
    else
        echo "awk"
    fi
}

# Função para normalizar caminhos
normalize_path() {
    local path="$1"
    
    case $ENVIRONMENT in
        "windows")
            # Converte barras para Windows
            echo "$path" | sed 's/\//\\/g'
            ;;
        *)
            # Mantém barras Unix
            echo "$path"
            ;;
    esac
}

# Função para criar diretórios necessários
create_required_directories() {
    local dirs=("$CONFIG_DIR" "$LOG_DIR")
    
    for dir in "${dirs[@]}"; do
        if [[ ! -d "$dir" ]]; then
            mkdir -p "$dir" 2>/dev/null
            if [[ $? -eq 0 ]]; then
                echo "  Criado: $dir"
            else
                echo -e "${YELLOW}⚠️ Não foi possível criar: $dir${NC}"
            fi
        fi
    done
}

# Função para obter informações do sistema
get_system_info() {
    echo "📊 Informações do Sistema:"
    echo "  Ambiente: $ENVIRONMENT"
    echo "  OS: $OS_TYPE"
    echo "  Shell: $SHELL_TYPE"
    echo "  Temp: $TEMP_DIR"
    echo "  Config: $CONFIG_DIR"
    echo "  Logs: $LOG_DIR"
    
    # Informações adicionais
    if [[ "$ENVIRONMENT" == "wsl" ]]; then
        echo "  WSL Version: $(wsl.exe --version 2>/dev/null | head -1 || echo 'N/A')"
    fi
    
    if [[ "$ENVIRONMENT" == "kali" ]]; then
        echo "  Kali Version: $(cat /etc/os-release | grep VERSION= | cut -d'"' -f2 2>/dev/null || echo 'N/A')"
    fi
}

# Função para testar compatibilidade
test_compatibility() {
    echo "🧪 Testando compatibilidade..."
    
    local tests_passed=0
    local total_tests=5
    
    # Teste 1: Detecção de ambiente
    if [[ -n "$ENVIRONMENT" ]]; then
        echo "  ✅ Teste 1: Detecção de ambiente"
        ((tests_passed++))
    else
        echo "  ❌ Teste 1: Falha na detecção"
    fi
    
    # Teste 2: Diretório temporário
    if is_writable "$TEMP_DIR"; then
        echo "  ✅ Teste 2: Diretório temporário"
        ((tests_passed++))
    else
        echo "  ❌ Teste 2: Diretório temporário não acessível"
    fi
    
    # Teste 3: Dependências
    if check_dependencies >/dev/null 2>&1; then
        echo "  ✅ Teste 3: Dependências"
        ((tests_passed++))
    else
        echo "  ❌ Teste 3: Dependências faltando"
    fi
    
    # Teste 4: Comandos adaptados
    local adapted_cmd
    adapted_cmd=$(adapt_command "/tmp/test.log")
    if [[ -n "$adapted_cmd" ]]; then
        echo "  ✅ Teste 4: Adaptação de comandos"
        ((tests_passed++))
    else
        echo "  ❌ Teste 4: Falha na adaptação"
    fi
    
    # Teste 5: Criação de diretórios
    create_required_directories >/dev/null 2>&1
    if [[ $? -eq 0 ]]; then
        echo "  ✅ Teste 5: Criação de diretórios"
        ((tests_passed++))
    else
        echo "  ❌ Teste 5: Falha na criação"
    fi
    
    echo "📊 Resultado: $tests_passed/$total_tests testes passaram"
    
    if [[ $tests_passed -eq $total_tests ]]; then
        echo -e "${GREEN}🎉 Compatibilidade validada!${NC}"
        return 0
    else
        echo -e "${YELLOW}⚠️ Problemas de compatibilidade detectados${NC}"
        return 1
    fi
}

# Função para exportar variáveis
export_environment_vars() {
    export LOG_ANALYZER_ENVIRONMENT="$ENVIRONMENT"
    export LOG_ANALYZER_OS_TYPE="$OS_TYPE"
    export LOG_ANALYZER_SHELL_TYPE="$SHELL_TYPE"
    export LOG_ANALYZER_TEMP_DIR="$TEMP_DIR"
    export LOG_ANALYZER_CONFIG_DIR="$CONFIG_DIR"
    export LOG_ANALYZER_LOG_DIR="$LOG_DIR"
}

# Função principal
main() {
    case "${1:-detect}" in
        "detect")
            detect_environment
            ;;
        "info")
            detect_environment
            get_system_info
            ;;
        "test")
            detect_environment
            test_compatibility
            ;;
        "export")
            detect_environment
            export_environment_vars
            echo "Variáveis de ambiente exportadas"
            ;;
        "help"|*)
            echo "Uso: $0 {detect|info|test|export|help}"
            echo
            echo "Comandos:"
            echo "  detect  - Detecta ambiente (padrão)"
            echo "  info    - Mostra informações detalhadas"
            echo "  test    - Testa compatibilidade"
            echo "  export  - Exporta variáveis de ambiente"
            echo "  help    - Mostra esta ajuda"
            ;;
    esac
}

# Executa se chamado diretamente
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi 