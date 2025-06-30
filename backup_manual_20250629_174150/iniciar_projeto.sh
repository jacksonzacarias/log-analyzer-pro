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
TESTS_DIR="$PROJECT_ROOT/tests"
LOGS_REALISTIC="$PROJECT_ROOT/logs/realistic"
LOGS_EXAMPLES="$PROJECT_ROOT/logs/examples"
DATA_DIR="$PROJECT_ROOT/data"
RESULTS_DIR="$PROJECT_ROOT/results"
DOCS_DIR="$PROJECT_ROOT/docs"

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
    
    if [[ -f "$TESTS_DIR/testes_wsl_estruturado.sh" ]]; then
        bash "$TESTS_DIR/testes_wsl_estruturado.sh"
    else
        log "${YELLOW}⚠️  Script de testes estruturado não encontrado${RESET}"
        log "${BLUE}💡 Executando testes básicos...${RESET}"
        bash "$TESTS_DIR/testes_wsl.sh"
    fi
    
    echo ""
    read -p "Pressione ENTER para continuar..."
}

# Função para executar testes de performance
run_performance_tests() {
    log "${BOLD}📊 EXECUTANDO TESTES DE PERFORMANCE...${RESET}"
    echo ""
    
    if [[ -f "$TESTS_DIR/teste_performance_completo.sh" ]]; then
        bash "$TESTS_DIR/teste_performance_completo.sh"
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
    
    if [[ -f "$SRC_SCRIPTS/gerador_logs_realistas.sh" ]]; then
        bash "$SRC_SCRIPTS/gerador_logs_realistas.sh"
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
        ls -la "$LOGS_REALISTIC"/*.log 2>/dev/null | while read line; do
            echo "  $line"
        done
        echo ""
    fi
    
    # Listar logs de exemplo
    if [[ -d "$LOGS_EXAMPLES" ]]; then
        echo -e "${GREEN}📂 Logs de Exemplo:${RESET}"
        ls -la "$LOGS_EXAMPLES"/*.log 2>/dev/null | while read line; do
            echo "  $line"
        done
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
        bash "$SRC_SCRIPTS/scriptlogs_avancado.sh" -v -t -aR -gT -pedago -pcn -peso -correl "$log_path"
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
    
    if [[ -d "$DOCS_DIR" ]]; then
        echo -e "${GREEN}📂 Documentação:${RESET}"
        ls -la "$DOCS_DIR"/*.md 2>/dev/null | while read line; do
            echo "  $line"
        done
        echo ""
        
        echo -e "${BOLD}Digite o nome do arquivo para visualizar ou 'menu' para voltar:${RESET} "
        read doc_file
        
        if [[ "$doc_file" == "menu" ]]; then
            return
        fi
        
        if [[ -f "$DOCS_DIR/$doc_file" ]]; then
            clear
            cat "$DOCS_DIR/$doc_file"
        else
            log "${RED}❌ Arquivo não encontrado: $doc_file${RESET}"
        fi
    else
        log "${YELLOW}⚠️  Diretório de documentação não encontrado${RESET}"
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
            if [[ -f "$PROJECT_ROOT/config/attack_patterns_learning.conf" ]]; then
                log "${GREEN}📝 Editando padrões de ataque...${RESET}"
                # Aqui você pode abrir o editor de preferência
                echo "Arquivo: $PROJECT_ROOT/config/attack_patterns_learning.conf"
            else
                log "${YELLOW}⚠️  Arquivo de padrões não encontrado${RESET}"
            fi
            ;;
        2)
            log "${GREEN}🔧 Configurações atuais:${RESET}"
            if [[ -d "$PROJECT_ROOT/config" ]]; then
                ls -la "$PROJECT_ROOT/config/"
            fi
            ;;
        3)
            log "${GREEN}📊 Importando padrões CSV...${RESET}"
            if [[ -f "$DATA_DIR/payloads_patterns.csv" ]]; then
                bash "$SRC_SCRIPTS/csv_to_training_system.sh" "$DATA_DIR/payloads_patterns.csv"
            else
                log "${YELLOW}⚠️  Arquivo CSV não encontrado${RESET}"
            fi
            ;;
        4)
            log "${GREEN}🎓 Treinando sistema...${RESET}"
            echo "5" | bash "$SRC_SCRIPTS/scriptlogs_avancado.sh" --treinar
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
        ls -la "$RESULTS_DIR"/*.txt 2>/dev/null | while read line; do
            echo "  $line"
        done
        echo ""
        
        echo -e "${BOLD}Digite o nome do arquivo para visualizar ou 'menu' para voltar:${RESET} "
        read result_file
        
        if [[ "$result_file" == "menu" ]]; then
            return
        fi
        
        if [[ -f "$RESULTS_DIR/$result_file" ]]; then
            clear
            cat "$RESULTS_DIR/$result_file"
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
            if [[ -d "$PROJECT_ROOT/temp" ]]; then
                rm -rf "$PROJECT_ROOT/temp"/*
                log "${GREEN}✅ Limpeza concluída${RESET}"
            fi
            ;;
        2)
            log "${GREEN}📦 Fazendo backup...${RESET}"
            bash "$PROJECT_ROOT/estrutura_projeto.sh"
            ;;
        3)
            log "${GREEN}🔄 Reorganizando estrutura...${RESET}"
            bash "$PROJECT_ROOT/estrutura_projeto.sh"
            ;;
        4)
            log "${GREEN}📊 Verificando espaço em disco...${RESET}"
            df -h
            ;;
        5)
            log "${GREEN}🔍 Verificando integridade...${RESET}"
            echo "Scripts principais: $(ls $SRC_SCRIPTS/*.sh 2>/dev/null | wc -l)"
            echo "Testes: $(ls $TESTS_DIR/*.sh 2>/dev/null | wc -l)"
            echo "Logs realistas: $(ls $LOGS_REALISTIC/*.log 2>/dev/null | wc -l)"
            echo "Documentação: $(ls $DOCS_DIR/*.md 2>/dev/null | wc -l)"
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