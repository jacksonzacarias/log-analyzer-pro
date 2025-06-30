#!/bin/bash

# Teste de Compatibilidade do Detector de Ambiente
# LOG ANALYZER PRO - Versão 5.0

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Variáveis de teste
SCRIPT_PATH="src/scripts/utils/environment_detector.sh"
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

# Função para executar teste
run_test() {
    local test_name="$1"
    local test_command="$2"
    local expected_result="$3"
    
    echo -n "🧪 $test_name... "
    
    local result
    result=$(eval "$test_command" 2>/dev/null)
    
    if [[ "$result" == *"$expected_result"* ]]; then
        echo -e "${GREEN}PASS${NC}"
        ((PASSED_TESTS++))
    else
        echo -e "${RED}FAIL${NC}"
        echo "  Esperado: $expected_result"
        echo "  Obtido: $result"
        ((FAILED_TESTS++))
    fi
    
    ((TOTAL_TESTS++))
}

# Função para executar teste de existência
test_file_exists() {
    local test_name="$1"
    local file_path="$2"
    
    echo -n "🧪 $test_name... "
    
    if [[ -f "$file_path" ]]; then
        echo -e "${GREEN}PASS${NC}"
        ((PASSED_TESTS++))
    else
        echo -e "${RED}FAIL${NC}"
        echo "  Arquivo não encontrado: $file_path"
        ((FAILED_TESTS++))
    fi
    
    ((TOTAL_TESTS++))
}

# Função para executar teste de execução
test_execution() {
    local test_name="$1"
    local command="$2"
    
    echo -n "🧪 $test_name... "
    
    if bash "$SCRIPT_PATH" "$command" >/dev/null 2>&1; then
        echo -e "${GREEN}PASS${NC}"
        ((PASSED_TESTS++))
    else
        echo -e "${RED}FAIL${NC}"
        echo "  Comando falhou: $command"
        ((FAILED_TESTS++))
    fi
    
    ((TOTAL_TESTS++))
}

# Função principal de teste
main() {
    echo "🔍 TESTE DE COMPATIBILIDADE - DETECTOR DE AMBIENTE"
    echo "=================================================="
    echo
    
    # Verifica se o script existe
    test_file_exists "Script existe" "$SCRIPT_PATH"
    
    # Testa execução básica
    test_execution "Execução básica" "detect"
    
    # Testa comando info
    test_execution "Comando info" "info"
    
    # Testa comando test
    test_execution "Comando test" "test"
    
    # Testa comando export
    test_execution "Comando export" "export"
    
    # Testa comando help
    test_execution "Comando help" "help"
    
    # Testa detecção de ambiente
    echo -n "🧪 Detecção de ambiente... "
    local env_result
    env_result=$(bash "$SCRIPT_PATH" detect 2>/dev/null | grep "Ambiente detectado")
    if [[ -n "$env_result" ]]; then
        echo -e "${GREEN}PASS${NC}"
        echo "  $env_result"
        ((PASSED_TESTS++))
    else
        echo -e "${RED}FAIL${NC}"
        ((FAILED_TESTS++))
    fi
    ((TOTAL_TESTS++))
    
    # Testa informações do sistema
    echo -n "🧪 Informações do sistema... "
    local info_result
    info_result=$(bash "$SCRIPT_PATH" info 2>/dev/null | grep "Informações do Sistema")
    if [[ -n "$info_result" ]]; then
        echo -e "${GREEN}PASS${NC}"
        ((PASSED_TESTS++))
    else
        echo -e "${RED}FAIL${NC}"
        ((FAILED_TESTS++))
    fi
    ((TOTAL_TESTS++))
    
    # Testa compatibilidade
    echo -n "🧪 Teste de compatibilidade... "
    local compat_result
    compat_result=$(bash "$SCRIPT_PATH" test 2>/dev/null | grep "Compatibilidade validada")
    if [[ -n "$compat_result" ]]; then
        echo -e "${GREEN}PASS${NC}"
        ((PASSED_TESTS++))
    else
        echo -e "${YELLOW}WARN${NC}"
        echo "  Verificar dependências"
        ((FAILED_TESTS++))
    fi
    ((TOTAL_TESTS++))
    
    # Testa exportação de variáveis
    echo -n "🧪 Exportação de variáveis... "
    local export_result
    export_result=$(bash "$SCRIPT_PATH" export 2>/dev/null | grep "Variáveis de ambiente exportadas")
    if [[ -n "$export_result" ]]; then
        echo -e "${GREEN}PASS${NC}"
        ((PASSED_TESTS++))
    else
        echo -e "${RED}FAIL${NC}"
        ((FAILED_TESTS++))
    fi
    ((TOTAL_TESTS++))
    
    # Testa sintaxe do script
    echo -n "🧪 Sintaxe do script... "
    if bash -n "$SCRIPT_PATH" 2>/dev/null; then
        echo -e "${GREEN}PASS${NC}"
        ((PASSED_TESTS++))
    else
        echo -e "${RED}FAIL${NC}"
        ((FAILED_TESTS++))
    fi
    ((TOTAL_TESTS++))
    
    # Testa permissões de execução
    echo -n "🧪 Permissões de execução... "
    if [[ -x "$SCRIPT_PATH" ]]; then
        echo -e "${GREEN}PASS${NC}"
        ((PASSED_TESTS++))
    else
        echo -e "${YELLOW}WARN${NC}"
        echo "  Script não tem permissão de execução"
        ((FAILED_TESTS++))
    fi
    ((TOTAL_TESTS++))
    
    # Testa dependências básicas
    echo -n "🧪 Dependências básicas... "
    local missing_deps=()
    
    for dep in bash grep sed awk; do
        if ! command -v "$dep" >/dev/null 2>&1; then
            missing_deps+=("$dep")
        fi
    done
    
    if [[ ${#missing_deps[@]} -eq 0 ]]; then
        echo -e "${GREEN}PASS${NC}"
        ((PASSED_TESTS++))
    else
        echo -e "${YELLOW}WARN${NC}"
        echo "  Dependências faltando: ${missing_deps[*]}"
        ((FAILED_TESTS++))
    fi
    ((TOTAL_TESTS++))
    
    # Testa jq (opcional)
    echo -n "🧪 Dependência jq (opcional)... "
    if command -v jq >/dev/null 2>&1; then
        echo -e "${GREEN}PASS${NC}"
        ((PASSED_TESTS++))
    else
        echo -e "${YELLOW}WARN${NC}"
        echo "  jq não encontrado (opcional)"
        ((FAILED_TESTS++))
    fi
    ((TOTAL_TESTS++))
    
    # Testa detecção de WSL
    echo -n "🧪 Detecção de WSL... "
    if [[ -f "/proc/version" ]] && grep -q "Microsoft" "/proc/version" 2>/dev/null; then
        local wsl_result
        wsl_result=$(bash "$SCRIPT_PATH" detect 2>/dev/null | grep "WSL")
        if [[ -n "$wsl_result" ]]; then
            echo -e "${GREEN}PASS${NC}"
            ((PASSED_TESTS++))
        else
            echo -e "${RED}FAIL${NC}"
            ((FAILED_TESTS++))
        fi
    else
        echo -e "${BLUE}SKIP${NC}"
        echo "  Não é ambiente WSL"
    fi
    ((TOTAL_TESTS++))
    
    # Testa detecção de Kali
    echo -n "🧪 Detecção de Kali... "
    if [[ -f "/etc/os-release" ]] && grep -q "kali" "/etc/os-release" 2>/dev/null; then
        local kali_result
        kali_result=$(bash "$SCRIPT_PATH" detect 2>/dev/null | grep "Kali")
        if [[ -n "$kali_result" ]]; then
            echo -e "${GREEN}PASS${NC}"
            ((PASSED_TESTS++))
        else
            echo -e "${RED}FAIL${NC}"
            ((FAILED_TESTS++))
        fi
    else
        echo -e "${BLUE}SKIP${NC}"
        echo "  Não é ambiente Kali"
    fi
    ((TOTAL_TESTS++))
    
    # Testa criação de diretórios
    echo -n "🧪 Criação de diretórios... "
    local temp_test_dir
    temp_test_dir=$(bash "$SCRIPT_PATH" detect 2>/dev/null | grep "Temp:" | awk '{print $2}')
    
    if [[ -n "$temp_test_dir" ]] && mkdir -p "$temp_test_dir/test_dir" 2>/dev/null; then
        echo -e "${GREEN}PASS${NC}"
        rmdir "$temp_test_dir/test_dir" 2>/dev/null
        ((PASSED_TESTS++))
    else
        echo -e "${RED}FAIL${NC}"
        ((FAILED_TESTS++))
    fi
    ((TOTAL_TESTS++))
    
    # Resultados finais
    echo
    echo "📊 RESULTADOS DOS TESTES"
    echo "========================"
    echo "Total de testes: $TOTAL_TESTS"
    echo -e "Passaram: ${GREEN}$PASSED_TESTS${NC}"
    echo -e "Falharam: ${RED}$FAILED_TESTS${NC}"
    
    local success_rate
    success_rate=$(echo "scale=1; $PASSED_TESTS * 100 / $TOTAL_TESTS" | bc 2>/dev/null || echo "0")
    echo "Taxa de sucesso: ${success_rate}%"
    
    if [[ $FAILED_TESTS -eq 0 ]]; then
        echo -e "${GREEN}🎉 Todos os testes passaram!${NC}"
        return 0
    else
        echo -e "${YELLOW}⚠️ $FAILED_TESTS teste(s) falharam${NC}"
        return 1
    fi
}

# Função para mostrar informações detalhadas
show_detailed_info() {
    echo
    echo "📋 INFORMAÇÕES DETALHADAS"
    echo "========================="
    
    echo "🔍 Detecção de Ambiente:"
    bash "$SCRIPT_PATH" detect
    
    echo
    echo "📊 Informações do Sistema:"
    bash "$SCRIPT_PATH" info
    
    echo
    echo "🧪 Teste de Compatibilidade:"
    bash "$SCRIPT_PATH" test
}

# Função para mostrar ajuda
show_help() {
    echo "Uso: $0 [opção]"
    echo
    echo "Opções:"
    echo "  test    - Executa testes de compatibilidade (padrão)"
    echo "  info    - Mostra informações detalhadas"
    echo "  help    - Mostra esta ajuda"
    echo
    echo "Exemplos:"
    echo "  $0 test    # Executa todos os testes"
    echo "  $0 info    # Mostra informações do sistema"
    echo "  $0 help    # Mostra esta ajuda"
}

# Função principal
case "${1:-test}" in
    "test")
        main
        ;;
    "info")
        show_detailed_info
        ;;
    "help"|*)
        show_help
        ;;
esac 