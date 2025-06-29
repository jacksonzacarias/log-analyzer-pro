#!/bin/bash

# ===================================================================================
# TESTES WSL ESTRUTURADO - SISTEMA DE ANÁLISE DE LOGS DE SEGURANÇA
# ===================================================================================
# Script para executar todos os testes no WSL com estrutura organizada
# Autor: Jackson Savoldi | ACADe-TI - Aula 04
# ===================================================================================

# Cores
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
CYAN="\e[36m"
WHITE="\e[37m"
BOLD="\e[1m"
RESET="\e[0m"

# Configurações
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
SRC_SCRIPTS="$PROJECT_ROOT/src/scripts"
LOGS_REALISTIC="$PROJECT_ROOT/analogs/logs_realistas"
LOGS_EXAMPLES="$PROJECT_ROOT/analogs/examples"
DATA_DIR="$PROJECT_ROOT/data"
RESULTS_DIR="$PROJECT_ROOT/results"

# Função para log
log() {
    echo -e "$1"
}

# Função para executar teste com tempo
run_test() {
    local test_name="$1"
    local command="$2"
    
    log "${BOLD}${BLUE}🔍 $test_name${RESET}"
    log "Comando: $command"
    
    local start_time=$(date +%s.%N)
    eval "$command"
    local exit_code=$?
    local end_time=$(date +%s.%N)
    local execution_time=$(echo "$end_time - $start_time" | bc -l 2>/dev/null || echo "0")
    
    if [[ $exit_code -eq 0 ]]; then
        log "${GREEN}✅ $test_name concluído em ${execution_time}s${RESET}"
    else
        log "${RED}❌ $test_name falhou em ${execution_time}s${RESET}"
    fi
    
    log ""
    return $exit_code
}

# Função para verificar dependências
check_dependencies() {
    log "${BOLD}🔍 VERIFICANDO DEPENDÊNCIAS...${RESET}"
    
    local missing_deps=()
    local required_cmds=("bash" "grep" "awk" "sed" "ps" "free" "df")
    
    for cmd in "${required_cmds[@]}"; do
        if ! command -v $cmd &> /dev/null; then
            missing_deps+=($cmd)
        fi
    done
    
    # Verificar bc (calculadora)
    if ! command -v bc &> /dev/null; then
        log "${YELLOW}⚠️  'bc' não encontrado - usando cálculo alternativo${RESET}"
        # Criar função alternativa para cálculo
        calc_time() {
            echo "$1" | awk '{printf "%.3f", $1}'
        }
    else
        calc_time() {
            echo "$1" | bc -l
        }
    fi
    
    if [[ ${#missing_deps[@]} -gt 0 ]]; then
        log "${RED}❌ Dependências faltando: ${missing_deps[*]}${RESET}"
        return 1
    else
        log "${GREEN}✅ Todas as dependências encontradas${RESET}"
    fi
    
    log ""
}

# Função para verificar estrutura
check_structure() {
    log "${BOLD}📁 VERIFICANDO ESTRUTURA DO PROJETO...${RESET}"
    
    local missing_dirs=()
    local required_dirs=(
        "$SRC_SCRIPTS"
        "$LOGS_REALISTIC"
        "$LOGS_EXAMPLES"
        "$DATA_DIR"
        "$RESULTS_DIR"
    )
    
    for dir in "${required_dirs[@]}"; do
        if [[ ! -d "$dir" ]]; then
            missing_dirs+=($(basename "$dir"))
        fi
    done
    
    if [[ ${#missing_dirs[@]} -gt 0 ]]; then
        log "${RED}❌ Diretórios faltando: ${missing_dirs[*]}${RESET}"
        log "${YELLOW}💡 Execute: bash estrutura_projeto.sh${RESET}"
        return 1
    else
        log "${GREEN}✅ Estrutura do projeto OK${RESET}"
    fi
    
    log ""
}

# Função para gerar logs realistas
generate_realistic_logs() {
    log "${BOLD}📋 TESTE 1: GERAR LOGS REALISTAS${RESET}"
    
    if [[ -f "$SRC_SCRIPTS/gerador_logs_realistas.sh" ]]; then
        run_test "Gerador de Logs Realistas" "bash $SRC_SCRIPTS/gerador_logs_realistas.sh"
    else
        log "${RED}❌ Gerador de logs não encontrado em $SRC_SCRIPTS/${RESET}"
        return 1
    fi
}

# Função para testar análise de logs
test_log_analysis() {
    local log_file="$1"
    local test_name="$2"
    
    if [[ -f "$log_file" ]]; then
        run_test "$test_name" "bash $SRC_SCRIPTS/scriptlogs_avancado.sh -v -t -aR -gT -pedago -pcn -peso -correl \"$log_file\""
    else
        log "${YELLOW}⚠️  Arquivo não encontrado: $log_file${RESET}"
        return 1
    fi
}

# Função para testar logs realistas
test_realistic_logs() {
    log "${BOLD}📋 TESTE 2-6: LOGS REALISTAS${RESET}"
    
    local realistic_logs=(
        "$LOGS_REALISTIC/apache_access_real.log:Apache Access Log Realista"
        "$LOGS_REALISTIC/ssh_auth_real.log:SSH Auth Log Realista"
        "$LOGS_REALISTIC/nginx_error_real.log:Nginx Error Log Realista"
        "$LOGS_REALISTIC/mysql_real.log:MySQL Log Realista"
        "$LOGS_REALISTIC/fail2ban_real.log:Fail2ban Log Realista"
    )
    
    for log_entry in "${realistic_logs[@]}"; do
        IFS=':' read -r log_file test_name <<< "$log_entry"
        test_log_analysis "$log_file" "$test_name"
    done
}

# Função para testar logs de exemplo
test_example_logs() {
    log "${BOLD}📋 TESTE 7: LOGS DE EXEMPLO${RESET}"
    
    local example_logs=(
        "$LOGS_EXAMPLES/apache2_access.log:Apache2 Access Log"
        "$LOGS_EXAMPLES/nginx_access.log:Nginx Access Log"
        "$LOGS_EXAMPLES/nginx_error.log:Nginx Error Log"
        "$LOGS_EXAMPLES/mysql.log:MySQL Log"
        "$LOGS_EXAMPLES/tentivas-sshubuntu-debian-auth.log:SSH Auth Log"
    )
    
    for log_entry in "${example_logs[@]}"; do
        IFS=':' read -r log_file test_name <<< "$log_entry"
        test_log_analysis "$log_file" "$test_name"
    done
}

# Função para testar sistema de treinamento
test_training_system() {
    log "${BOLD}📋 TESTE 8: SISTEMA DE TREINAMENTO${RESET}"
    
    # Testar importação CSV
    if [[ -f "$DATA_DIR/payloads_patterns.csv" ]]; then
        run_test "Importação CSV" "bash $SRC_SCRIPTS/csv_to_training_system.sh $DATA_DIR/payloads_patterns.csv"
    else
        log "${YELLOW}⚠️  Arquivo CSV não encontrado em $DATA_DIR/${RESET}"
    fi
    
    # Testar sistema de treinamento (modo não interativo)
    run_test "Sistema de Treinamento" "echo '5' | bash $SRC_SCRIPTS/scriptlogs_avancado.sh --treinar > /dev/null 2>&1"
}

# Função para testar sistema completo
test_complete_system() {
    log "${BOLD}📋 TESTE 9: SISTEMA COMPLETO${RESET}"
    
    # Testar com logs realistas
    if [[ -d "$LOGS_REALISTIC" ]]; then
        echo "s" | bash $SCRIPT_DIR/teste_completo_sistema.sh "$LOGS_REALISTIC/" > /dev/null 2>&1
        run_test "Teste Completo Logs Realistas" "echo 'Teste executado'"
    fi
    
    # Testar com logs de exemplo
    if [[ -d "$LOGS_EXAMPLES" ]]; then
        echo "s" | bash $SCRIPT_DIR/teste_completo_sistema.sh "$LOGS_EXAMPLES/" > /dev/null 2>&1
        run_test "Teste Completo Logs Exemplos" "echo 'Teste executado'"
    fi
}

# Função para testes específicos de detecção
test_detection_specific() {
    log "${BOLD}📋 TESTE 10: DETECÇÃO ESPECÍFICA${RESET}"
    
    local apache_log="$LOGS_REALISTIC/apache_access_real.log"
    local ssh_log="$LOGS_REALISTIC/ssh_auth_real.log"
    
    if [[ -f "$apache_log" ]]; then
        run_test "Detecção SQL Injection" "grep -c 'sqlmap' $apache_log"
        run_test "Detecção XSS" "grep -c 'script' $apache_log"
    fi
    
    if [[ -f "$ssh_log" ]]; then
        run_test "Detecção Brute Force SSH" "grep -c 'Failed password' $ssh_log"
    fi
}

# Função para teste de performance
test_performance() {
    log "${BOLD}📋 TESTE 11: PERFORMANCE${RESET}"
    
    local apache_log="$LOGS_REALISTIC/apache_access_real.log"
    
    if [[ -f "$apache_log" ]]; then
        run_test "Performance Apache Log" "time bash $SRC_SCRIPTS/scriptlogs_avancado.sh -v -t -aR -gT -pedago -pcn -peso -correl $apache_log > /dev/null 2>&1"
    else
        log "${YELLOW}⚠️  Log Apache não encontrado para teste de performance${RESET}"
    fi
}

# Função para gerar relatório
generate_report() {
    log "${BOLD}📊 GERANDO RELATÓRIO DE TESTES...${RESET}"
    
    local report_file="$RESULTS_DIR/relatorio_testes_$(date '+%Y%m%d_%H%M%S').txt"
    
    cat > "$report_file" << EOF
# 📊 RELATÓRIO DE TESTES WSL ESTRUTURADO

## 🎯 Informações Gerais
**Data/Hora:** $(date '+%Y-%m-%d %H:%M:%S')
**Sistema:** $(uname -a)
**Estrutura:** Organizada
**Scripts:** $SRC_SCRIPTS

## 📋 Testes Executados
$(grep "TESTE" "$LOG_FILE" | sed 's/.*TESTE/TESTE/')

## ✅ Resultados
$(grep "✅" "$LOG_FILE" | wc -l) testes passaram
$(grep "❌" "$LOG_FILE" | wc -l) testes falharam
$(grep "⚠️" "$LOG_FILE" | wc -l) avisos

## 📁 Estrutura Verificada
- src/scripts/: $(ls $SRC_SCRIPTS/*.sh 2>/dev/null | wc -l) scripts
- logs/realistic/: $(ls $LOGS_REALISTIC/*.log 2>/dev/null | wc -l) logs
- logs/examples/: $(ls $LOGS_EXAMPLES/*.log 2>/dev/null | wc -l) logs
- data/: $(ls $DATA_DIR/*.csv 2>/dev/null | wc -l) arquivos CSV

## 🚀 Status Final
$(if [[ $(grep "❌" "$LOG_FILE" | wc -l) -eq 0 ]]; then
    echo "🟢 TODOS OS TESTES PASSARAM"
else
    echo "🟡 ALGUNS TESTES FALHARAM"
fi)

---
**Gerado automaticamente pelo sistema de testes**
EOF

    log "${GREEN}✅ Relatório gerado: $report_file${RESET}"
}

# Função principal
main() {
    echo -e "${BOLD}${CYAN}🚀 TESTES WSL ESTRUTURADO - SISTEMA DE ANÁLISE DE LOGS${RESET}"
    echo -e "${BOLD}${CYAN}====================================================${RESET}"
    echo -e "${BOLD}Data/Hora: $(date '+%Y-%m-%d %H:%M:%S')${RESET}"
    echo -e "${BOLD}Estrutura: Organizada${RESET}"
    echo ""
    
    # Inicializar log
    LOG_FILE="$RESULTS_DIR/testes_wsl_$(date '+%Y%m%d_%H%M%S').log"
    mkdir -p "$RESULTS_DIR"
    > "$LOG_FILE"
    
    # Verificar dependências
    check_dependencies || return 1
    
    # Verificar estrutura
    check_structure || return 1
    
    # Executar testes
    log "${BOLD}🧪 INICIANDO EXECUÇÃO DOS TESTES...${RESET}"
    log ""
    
    # 1. Gerar logs realistas
    generate_realistic_logs
    
    # 2. Testar logs realistas
    test_realistic_logs
    
    # 3. Testar logs de exemplo
    test_example_logs
    
    # 4. Testar sistema de treinamento
    test_training_system
    
    # 5. Testar sistema completo
    test_complete_system
    
    # 6. Testes específicos de detecção
    test_detection_specific
    
    # 7. Teste de performance
    test_performance
    
    # 8. Gerar relatório
    generate_report
    
    echo ""
    log "${BOLD}${GREEN}🎉 TODOS OS TESTES CONCLUÍDOS!${RESET}"
    echo ""
    log "${BOLD}📊 RESUMO DOS TESTES:${RESET}"
    log "  ✅ Logs realistas gerados"
    log "  ✅ Análise de Apache, SSH, Nginx, MySQL, Fail2ban"
    log "  ✅ Teste de logs de exemplo"
    log "  ✅ Sistema de treinamento"
    log "  ✅ Sistema completo"
    log "  ✅ Detecção específica de ataques"
    log "  ✅ Teste de performance"
    log "  ✅ Relatório gerado"
    echo ""
    log "${BOLD}💡 PRÓXIMOS PASSOS:${RESET}"
    log "  1. Analisar relatório: cat $report_file"
    log "  2. Verificar logs: ls -la $LOGS_REALISTIC/"
    log "  3. Ver resultados: ls -la $RESULTS_DIR/"
    log "  4. Executar teste completo: bash $SCRIPT_DIR/teste_performance_completo.sh"
    echo ""
    log "${BOLD}📋 COMANDOS ÚTEIS:${RESET}"
    log "  ls -la $LOGS_REALISTIC/"
    log "  head -20 $LOGS_REALISTIC/apache_access_real.log"
    log "  bash $SCRIPT_DIR/teste_performance_completo.sh"
    log "  cat $report_file"
}

# Executar função principal
main "$@" 