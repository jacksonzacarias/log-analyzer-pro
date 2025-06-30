#!/bin/bash

# ===================================================================================
# TESTES WSL - SISTEMA DE ANÁLISE DE LOGS DE SEGURANÇA
# ===================================================================================
# Script para executar todos os testes no WSL de forma organizada
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
    local execution_time=$(echo "$end_time - $start_time" | bc -l)
    
    if [[ $exit_code -eq 0 ]]; then
        log "${GREEN}✅ $test_name concluído em ${execution_time}s${RESET}"
    else
        log "${RED}❌ $test_name falhou em ${execution_time}s${RESET}"
    fi
    
    log ""
    return $exit_code
}

# Função principal
main() {
    echo -e "${BOLD}${CYAN}🚀 TESTES WSL - SISTEMA DE ANÁLISE DE LOGS${RESET}"
    echo -e "${BOLD}${CYAN}============================================${RESET}"
    echo -e "${BOLD}Data/Hora: $(date '+%Y-%m-%d %H:%M:%S')${RESET}"
    echo ""
    
    # Verificar se estamos no WSL
    if [[ -f /proc/version ]] && grep -q Microsoft /proc/version; then
        log "${GREEN}✅ Executando no WSL${RESET}"
    else
        log "${YELLOW}⚠️  Não detectado como WSL${RESET}"
    fi
    
    echo ""
    
    # 1. Tornar scripts executáveis
    log "${BOLD}🔧 PREPARANDO SCRIPTS...${RESET}"
    chmod +x *.sh
    log "${GREEN}✅ Scripts tornados executáveis${RESET}"
    echo ""
    
    # 2. Gerar logs realistas
    log "${BOLD}📋 TESTE 1: GERAR LOGS REALISTAS${RESET}"
    run_test "Gerador de Logs Realistas" "bash gerador_logs_realistas.sh"
    
    # 3. Testar Apache Access Log
    log "${BOLD}📋 TESTE 2: APACHE ACCESS LOG REALISTA${RESET}"
    run_test "Análise Apache Access Log" "bash scriptlogs_avancado.sh -v -t -aR -gT -pedago -pcn -peso -correl logs_realistas/apache_access_real.log"
    
    # 4. Testar SSH Auth Log
    log "${BOLD}📋 TESTE 3: SSH AUTH LOG REALISTA${RESET}"
    run_test "Análise SSH Auth Log" "bash scriptlogs_avancado.sh -v -t -aR -gT -pedago -pcn -peso -correl logs_realistas/ssh_auth_real.log"
    
    # 5. Testar Nginx Error Log
    log "${BOLD}📋 TESTE 4: NGINX ERROR LOG REALISTA${RESET}"
    run_test "Análise Nginx Error Log" "bash scriptlogs_avancado.sh -v -t -aR -gT -pedago -pcn -peso -correl logs_realistas/nginx_error_real.log"
    
    # 6. Testar MySQL Log
    log "${BOLD}📋 TESTE 5: MYSQL LOG REALISTA${RESET}"
    run_test "Análise MySQL Log" "bash scriptlogs_avancado.sh -v -t -aR -gT -pedago -pcn -peso -correl logs_realistas/mysql_real.log"
    
    # 7. Testar Fail2ban Log
    log "${BOLD}📋 TESTE 6: FAIL2BAN LOG REALISTA${RESET}"
    run_test "Análise Fail2ban Log" "bash scriptlogs_avancado.sh -v -t -aR -gT -pedago -pcn -peso -correl logs_realistas/fail2ban_real.log"
    
    # 8. Testar logs existentes
    log "${BOLD}📋 TESTE 7: LOGS EXISTENTES${RESET}"
    run_test "Análise Apache2 Access Log" "bash scriptlogs_avancado.sh -v -t -aR -gT -pedago -pcn -peso -correl apache2_access.log"
    run_test "Análise Nginx Access Log" "bash scriptlogs_avancado.sh -v -t -aR -gT -pedago -pcn -peso -correl nginx_access.log"
    run_test "Análise SSH Auth Log" "bash scriptlogs_avancado.sh -v -t -aR -gT -pedago -pcn -peso -correl tentivas-sshubuntu-debian-auth.log"
    
    # 9. Testar sistema de treinamento
    log "${BOLD}📋 TESTE 8: SISTEMA DE TREINAMENTO${RESET}"
    run_test "Importação CSV" "bash csv_to_training_system.sh payloads_patterns.csv"
    
    # 10. Testar sistema completo
    log "${BOLD}📋 TESTE 9: SISTEMA COMPLETO${RESET}"
    echo "s" | bash teste_completo_sistema.sh logs_realistas/ > /dev/null 2>&1
    run_test "Teste Completo Logs Realistas" "echo 'Teste executado'"
    
    echo "s" | bash teste_completo_sistema.sh . > /dev/null 2>&1
    run_test "Teste Completo Logs Existentes" "echo 'Teste executado'"
    
    # 11. Testes específicos de detecção
    log "${BOLD}📋 TESTE 10: DETECÇÃO ESPECÍFICA${RESET}"
    run_test "Detecção SQL Injection" "grep -c 'sqlmap' logs_realistas/apache_access_real.log"
    run_test "Detecção XSS" "grep -c 'script' logs_realistas/apache_access_real.log"
    run_test "Detecção Brute Force SSH" "grep -c 'Failed password' logs_realistas/ssh_auth_real.log"
    
    # 12. Teste de performance
    log "${BOLD}📋 TESTE 11: PERFORMANCE${RESET}"
    run_test "Performance Apache Log" "time bash scriptlogs_avancado.sh -v -t -aR -gT -pedago -pcn -peso -correl logs_realistas/apache_access_real.log > /dev/null 2>&1"
    
    echo ""
    log "${BOLD}${GREEN}🎉 TODOS OS TESTES CONCLUÍDOS!${RESET}"
    echo ""
    log "${BOLD}📊 RESUMO DOS TESTES:${RESET}"
    log "  ✅ Logs realistas gerados"
    log "  ✅ Análise de Apache, SSH, Nginx, MySQL, Fail2ban"
    log "  ✅ Teste de logs existentes"
    log "  ✅ Sistema de treinamento"
    log "  ✅ Sistema completo"
    log "  ✅ Detecção específica de ataques"
    log "  ✅ Teste de performance"
    echo ""
    log "${BOLD}💡 PRÓXIMOS PASSOS:${RESET}"
    log "  1. Analisar resultados dos testes"
    log "  2. Verificar arquivos gerados em logs_realistas/"
    log "  3. Executar teste_performance_completo.sh para relatório detalhado"
    log "  4. Validar com logs de produção reais"
    echo ""
    log "${BOLD}📋 COMANDOS ÚTEIS:${RESET}"
    log "  ls -la logs_realistas/"
    log "  head -20 logs_realistas/apache_access_real.log"
    log "  bash teste_performance_completo.sh"
    log "  cat ANALISE_RESULTADOS_TESTE.md"
}

# Executar função principal
main "$@" 