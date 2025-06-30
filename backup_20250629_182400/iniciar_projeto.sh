#!/bin/bash

# ===================================================================================
# INICIADOR RÁPIDO DO PROJETO - SISTEMA DE ANÁLISE DE LOGS
# ===================================================================================
# Script para inicializar e navegar rapidamente no projeto organizado
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
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_SCRIPTS="$PROJECT_ROOT/src/scripts"
CORE_SCRIPTS="$SRC_SCRIPTS/core"
UTILS_SCRIPTS="$SRC_SCRIPTS/utils"
GENERATORS_SCRIPTS="$SRC_SCRIPTS/generators"
TESTS_DIR="$PROJECT_ROOT/tests"
LOGS_REALISTIC="$PROJECT_ROOT/logs/realistic/logs_realistas"
LOGS_EXAMPLES="$PROJECT_ROOT/logs/examples"
LOGS_ATTACKS="$PROJECT_ROOT/logs/attacks"
LOGS_SERVICES="$PROJECT_ROOT/logs/services"
DATA_DIR="$PROJECT_ROOT/data"
PATTERNS_DIR="$DATA_DIR/patterns"
RESULTS_DIR="$PROJECT_ROOT/results"
DOCS_DIR="$PROJECT_ROOT/docs"
CONFIG_DIR="$PROJECT_ROOT/config"
TEMP_DIR="$PROJECT_ROOT/temp"

# Função para log
log() {
    echo -e "$1"
}

# Função para mostrar menu principal
show_main_menu() {
    clear
    echo -e "${BOLD}${CYAN}🚀 SISTEMA DE ANÁLISE DE LOGS DE SEGURANÇA${RESET}"
    echo -e "${BOLD}${CYAN}==========================================${RESET}"
    echo -e "${BOLD}Data/Hora: $(date '+%Y-%m-%d %H:%M:%S')${RESET}"
    echo -e "${BOLD}Estrutura: Organizada${RESET}"
    echo ""
    echo -e "${BOLD}📋 MENU PRINCIPAL:${RESET}"
    echo ""
    echo -e "${GREEN}1.${RESET} 🧪 Executar Testes Completos"
    echo -e "${GREEN}2.${RESET} 📊 Executar Testes de Performance"
    echo -e "${GREEN}3.${RESET} 📝 Gerar Logs Realistas"
    echo -e "${GREEN}4.${RESET} 🔍 Analisar Log Específico"
    echo -e "${GREEN}5.${RESET} 📚 Ver Documentação"
    echo -e "${GREEN}6.${RESET} 📁 Navegar Estrutura"
    echo -e "${GREEN}7.${RESET} ⚙️  Configurar Sistema"
    echo -e "${GREEN}8.${RESET} 📈 Ver Resultados"
    echo -e "${GREEN}9.${RESET} 🔧 Manutenção"
    echo -e "${GREEN}0.${RESET} 🚪 Sair"
    echo ""
    echo -e "${BOLD}Escolha uma opção:${RESET} "
}

# Função para executar testes completos
run_complete_tests() {
    log "${BOLD}🧪 EXECUTANDO TESTES COMPLETOS...${RESET}"
    echo ""
    if [[ -f "$TESTS_DIR/integration/testes_wsl_estruturado.sh" ]]; then
        bash "$TESTS_DIR/integration/testes_wsl_estruturado.sh"
    else
        log "${YELLOW}⚠️  Script de testes estruturado não encontrado${RESET}"
    fi
    echo ""
    read -p "Pressione ENTER para continuar..."
}

# Função para executar testes de performance
run_performance_tests() {
    log "${BOLD}📊 EXECUTANDO TESTES DE PERFORMANCE...${RESET}"
    echo ""
    if [[ -f "$TESTS_DIR/performance/teste_performance_completo.sh" ]]; then
        bash "$TESTS_DIR/performance/teste_performance_completo.sh"
    else
        log "${RED}❌ Script de performance não encontrado${RESET}"
    fi
    echo ""
    read -p "Pressione ENTER para continuar..."
}

# Função para gerar logs realistas
generate_realistic_logs() {
    log "${BOLD}📝 GERANDO LOGS REALISTAS...${RESET}"
    echo ""
    if [[ -f "$GENERATORS_SCRIPTS/gerador_logs_realistas.sh" ]]; then
        bash "$GENERATORS_SCRIPTS/gerador_logs_realistas.sh"
    else
        log "${RED}❌ Gerador de logs não encontrado${RESET}"
    fi
    echo ""
    read -p "Pressione ENTER para continuar..."
}

# Função para analisar log específico
analyze_specific_log() {
    log "${BOLD}🔍 ANÁLISE DE LOG ESPECÍFICO${RESET}"
    echo ""
    echo -e "${BOLD}📁 Logs disponíveis:${RESET}"
    echo ""
    # Listar logs realistas
    if [[ -d "$LOGS_REALISTIC" ]]; then
        echo -e "${GREEN}📂 Logs Realistas:${RESET}"
        ls -1 "$LOGS_REALISTIC"/*.log 2>/dev/null
        echo ""
    fi
    # Listar logs de exemplo
    if [[ -d "$LOGS_EXAMPLES" ]]; then
        echo -e "${GREEN}📂 Logs de Exemplo:${RESET}"
        ls -1 "$LOGS_EXAMPLES"/*.log 2>/dev/null
        echo ""
    fi
    # Listar logs de ataques
    if [[ -d "$LOGS_ATTACKS" ]]; then
        echo -e "${GREEN}📂 Logs de Ataques:${RESET}"
        ls -1 "$LOGS_ATTACKS"/*.log 2>/dev/null
        echo ""
    fi
    # Listar logs por serviço
    if [[ -d "$LOGS_SERVICES" ]]; then
        echo -e "${GREEN}📂 Logs por Serviço:${RESET}"
        ls -1 "$LOGS_SERVICES"/*/*.log 2>/dev/null
        echo ""
    fi
    echo -e "${BOLD}Digite o caminho completo do log ou 'menu' para voltar:${RESET} "
    read log_path
    if [[ "$log_path" == "menu" ]]; then
        return
    fi
    if [[ -f "$log_path" ]]; then
        log "${GREEN}✅ Analisando: $log_path${RESET}"
        echo ""
        bash "$CORE_SCRIPTS/scriptlogs_avancado.sh" -v -t -aR -gT -pedago -pcn -peso -correl "$log_path"
    else
        log "${RED}❌ Arquivo não encontrado: $log_path${RESET}"
    fi
    echo ""
    read -p "Pressione ENTER para continuar..."
}

# Função para ver documentação
show_documentation() {
    log "${BOLD}📚 DOCUMENTAÇÃO DISPONÍVEL${RESET}"
    echo ""
    for subdir in "$DOCS_DIR"/*/; do
        if [[ -d "$subdir" ]]; then
            echo -e "${GREEN}📂 Documentação: $(basename "$subdir")${RESET}"
            ls -1 "$subdir"*.md 2>/dev/null
            echo ""
        fi
    done
    echo -e "${BOLD}Digite o caminho do arquivo para visualizar ou 'menu' para voltar:${RESET} "
    read doc_file
    if [[ "$doc_file" == "menu" ]]; then
        return
    fi
    if [[ -f "$doc_file" ]]; then
        clear
        cat "$doc_file"
    else
        log "${RED}❌ Arquivo não encontrado: $doc_file${RESET}"
    fi
    echo ""
    read -p "Pressione ENTER para continuar..."
}

# Função para navegar estrutura
navigate_structure() {
    log "${BOLD}📁 NAVEGAÇÃO DA ESTRUTURA${RESET}"
    echo ""
    
    bash "$PROJECT_ROOT/navegar_projeto.sh"
    
    echo ""
    read -p "Pressione ENTER para continuar..."
}

# Função para configurar sistema
configure_system() {
    log "${BOLD}⚙️  CONFIGURAÇÃO DO SISTEMA${RESET}"
    echo ""
    echo -e "${BOLD}📋 Opções de Configuração:${RESET}"
    echo ""
    echo -e "${GREEN}1.${RESET} 📝 Editar padrões de ataque"
    echo -e "${GREEN}2.${RESET} 🔧 Ver configurações atuais"
    echo -e "${GREEN}3.${RESET} 📊 Importar padrões CSV"
    echo -e "${GREEN}4.${RESET} 🎓 Treinar sistema"
    echo -e "${GREEN}0.${RESET} 🔙 Voltar"
    echo ""
    echo -e "${BOLD}Escolha uma opção:${RESET} "
    read config_option
    case $config_option in
        1)
            if [[ -f "$CONFIG_DIR/attack_patterns_learning.conf" ]]; then
                log "${GREEN}📝 Editando padrões de ataque...${RESET}"
                echo "Arquivo: $CONFIG_DIR/attack_patterns_learning.conf"
            else
                log "${YELLOW}⚠️  Arquivo de padrões não encontrado${RESET}"
            fi
            ;;
        2)
            log "${GREEN}🔧 Configurações atuais:${RESET}"
            if [[ -d "$CONFIG_DIR" ]]; then
                ls -la "$CONFIG_DIR/"
            fi
            ;;
        3)
            log "${GREEN}📊 Importando padrões CSV...${RESET}"
            if [[ -f "$PATTERNS_DIR/payloads_patterns.csv" ]]; then
                bash "$UTILS_SCRIPTS/csv_to_training_system.sh" "$PATTERNS_DIR/payloads_patterns.csv"
            else
                log "${YELLOW}⚠️  Arquivo CSV não encontrado${RESET}"
            fi
            ;;
        4)
            log "${GREEN}🎓 Treinando sistema...${RESET}"
            bash "$CORE_SCRIPTS/scriptlogs_avancado.sh" -train
            ;;
        0)
            return
            ;;
        *)
            log "${RED}❌ Opção inválida${RESET}"
            ;;
    esac
    echo ""
    read -p "Pressione ENTER para continuar..."
}

# Função para ver resultados
show_results() {
    log "${BOLD}📈 RESULTADOS DISPONÍVEIS${RESET}"
    echo ""
    if [[ -d "$RESULTS_DIR" ]]; then
        echo -e "${GREEN}📂 Resultados:${RESET}"
        ls -1 "$RESULTS_DIR"/* 2>/dev/null
        echo ""
        echo -e "${BOLD}Digite o caminho do arquivo para visualizar ou 'menu' para voltar:${RESET} "
        read result_file
        if [[ "$result_file" == "menu" ]]; then
            return
        fi
        if [[ -f "$result_file" ]]; then
            clear
            cat "$result_file"
        else
            log "${RED}❌ Arquivo não encontrado: $result_file${RESET}"
        fi
    else
        log "${YELLOW}⚠️  Diretório de resultados não encontrado${RESET}"
    fi
    echo ""
    read -p "Pressione ENTER para continuar..."
}

# Função para manutenção
maintenance_menu() {
    log "${BOLD}🔧 MENU DE MANUTENÇÃO${RESET}"
    echo ""
    echo -e "${BOLD}📋 Opções de Manutenção:${RESET}"
    echo ""
    echo -e "${GREEN}1.${RESET} 🧹 Limpar arquivos temporários"
    echo -e "${GREEN}2.${RESET} 📦 Fazer backup"
    echo -e "${GREEN}3.${RESET} 🔄 Reorganizar estrutura"
    echo -e "${GREEN}4.${RESET} 📊 Verificar espaço em disco"
    echo -e "${GREEN}5.${RESET} 🔍 Verificar integridade"
    echo -e "${GREEN}0.${RESET} 🔙 Voltar"
    echo ""
    echo -e "${BOLD}Escolha uma opção:${RESET} "
    read maintenance_option
    case $maintenance_option in
        1)
            log "${GREEN}🧹 Limpando arquivos temporários...${RESET}"
            if [[ -d "$TEMP_DIR" ]]; then
                rm -rf "$TEMP_DIR"/*
                log "${GREEN}✅ Limpeza concluída${RESET}"
            fi
            ;;
        2)
            log "${GREEN}📦 Fazendo backup...${RESET}"
            bash "$PROJECT_ROOT/estrutura_projeto.sh"
            ;;
        3)
            log "${GREEN}🔄 Reorganizando estrutura...${RESET}"
            bash "$PROJECT_ROOT/reorganizar_manual.sh"
            ;;
        4)
            log "${GREEN}📊 Verificando espaço em disco...${RESET}"
            df -h
            ;;
        5)
            log "${GREEN}🔍 Verificando integridade...${RESET}"
            echo "Scripts principais: $(ls $CORE_SCRIPTS/*.sh 2>/dev/null | wc -l)"
            echo "Testes unitários: $(ls $TESTS_DIR/unit/*.sh 2>/dev/null | wc -l)"
            echo "Testes integração: $(ls $TESTS_DIR/integration/*.sh 2>/dev/null | wc -l)"
            echo "Testes performance: $(ls $TESTS_DIR/performance/*.sh 2>/dev/null | wc -l)"
            echo "Logs realistas: $(ls $LOGS_REALISTIC/*.log 2>/dev/null | wc -l)"
            echo "Documentação usuário: $(ls $DOCS_DIR/user/*.md 2>/dev/null | wc -l)"
            echo "Documentação dev: $(ls $DOCS_DIR/developer/*.md 2>/dev/null | wc -l)"
            ;;
        0)
            return
            ;;
        *)
            log "${RED}❌ Opção inválida${RESET}"
            ;;
    esac
    echo ""
    read -p "Pressione ENTER para continuar..."
}

# Função principal
main() {
    while true; do
        show_main_menu
        read option
        
        case $option in
            1)
                run_complete_tests
                ;;
            2)
                run_performance_tests
                ;;
            3)
                generate_realistic_logs
                ;;
            4)
                analyze_specific_log
                ;;
            5)
                show_documentation
                ;;
            6)
                navigate_structure
                ;;
            7)
                configure_system
                ;;
            8)
                show_results
                ;;
            9)
                maintenance_menu
                ;;
            0)
                log "${BOLD}${GREEN}👋 Até logo!${RESET}"
                exit 0
                ;;
            *)
                log "${RED}❌ Opção inválida${RESET}"
                sleep 2
                ;;
        esac
    done
}

# Executar função principal
main "$@" 