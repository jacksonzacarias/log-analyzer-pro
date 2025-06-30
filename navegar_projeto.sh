#!/bin/bash

# ===================================================================================
# NAVEGADOR INTERATIVO DO PROJETO - LOG ANALYZER PRO
# ===================================================================================
# Sistema de navegação interativa com menus e comandos rápidos
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

# Detecção do diretório raiz
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR" && pwd)"

# Carregar configuração
if [[ -f "$PROJECT_ROOT/config/paths.conf" ]]; then
    source "$PROJECT_ROOT/config/paths.conf"
else
    echo -e "${RED}❌ Arquivo de configuração não encontrado${RESET}"
    exit 1
fi

# Função para limpar tela
clear_screen() {
    clear
}

# Função para mostrar cabeçalho
show_header() {
    clear_screen
    echo -e "${BOLD}${CYAN}🗂️  NAVEGADOR INTERATIVO DO PROJETO${RESET}"
    echo -e "${BOLD}${CYAN}=====================================${RESET}"
    echo -e "${BOLD}📁 Diretório atual: $PROJECT_ROOT${RESET}"
    echo ""
}

# Função para navegar diretórios
navigate_directories() {
    while true; do
        show_header
        echo -e "${BOLD}${YELLOW}📁 NAVEGAÇÃO DE DIRETÓRIOS${RESET}"
        echo -e "${BOLD}${YELLOW}========================${RESET}"
        echo ""
        
        echo -e "${BOLD}📂 DIRETÓRIOS PRINCIPAIS:${RESET}"
        echo -e "${GREEN}1)${RESET} 📁 src/scripts/     - Scripts principais do sistema"
        echo -e "${GREEN}2)${RESET} 📁 tests/           - Scripts de teste"
        echo -e "${GREEN}3)${RESET} 📁 config/          - Configurações"
        echo -e "${GREEN}4)${RESET} 📁 analogs/         - Todos os logs organizados"
        echo -e "${GREEN}5)${RESET} 📁 system/data/     - Dados e CSV"
        echo -e "${GREEN}6)${RESET} 📁 results/         - Resultados de testes"
        echo -e "${GREEN}7)${RESET} 📁 docs/            - Documentação"
        echo -e "${GREEN}8)${RESET} 📁 payloads/        - Payloads de ataque"
        echo -e "${GREEN}9)${RESET} 📁 temp/            - Arquivos temporários"
        echo -e "${GREEN}10)${RESET} 📁 logs/           - Logs do sistema"
        echo ""
        echo -e "${GREEN}0)${RESET} 🔙 Voltar ao menu principal"
        echo ""
        
        read -p "Escolha um diretório (0-10): " choice
        
        case $choice in
            1) cd "$SRC_SCRIPTS_DIR" && echo -e "${GREEN}✅ Navegando para: $(pwd)${RESET}" && sleep 2 ;;
            2) cd "$TESTS_DIR" && echo -e "${GREEN}✅ Navegando para: $(pwd)${RESET}" && sleep 2 ;;
            3) cd "$CONFIG_DIR" && echo -e "${GREEN}✅ Navegando para: $(pwd)${RESET}" && sleep 2 ;;
            4) cd "$ANALOGS_DIR" && echo -e "${GREEN}✅ Navegando para: $(pwd)${RESET}" && sleep 2 ;;
            5) cd "$SYSTEM_DATA_DIR" && echo -e "${GREEN}✅ Navegando para: $(pwd)${RESET}" && sleep 2 ;;
            6) cd "$RESULTS_DIR" && echo -e "${GREEN}✅ Navegando para: $(pwd)${RESET}" && sleep 2 ;;
            7) cd "$DOCS_DIR" && echo -e "${GREEN}✅ Navegando para: $(pwd)${RESET}" && sleep 2 ;;
            8) cd "$PAYLOADS_DIR" && echo -e "${GREEN}✅ Navegando para: $(pwd)${RESET}" && sleep 2 ;;
            9) cd "$TEMP_DIR" && echo -e "${GREEN}✅ Navegando para: $(pwd)${RESET}" && sleep 2 ;;
            10) cd "$LOGS_DIR" && echo -e "${GREEN}✅ Navegando para: $(pwd)${RESET}" && sleep 2 ;;
            0) break ;;
            *) echo -e "${RED}❌ Opção inválida${RESET}" && sleep 2 ;;
        esac
    done
}

# Função para buscar arquivos
search_files() {
    show_header
    echo -e "${BOLD}${YELLOW}🔍 BUSCA DE ARQUIVOS${RESET}"
    echo -e "${BOLD}${YELLOW}==================${RESET}"
    echo ""
    
    read -p "Digite o termo de busca: " search_term
    
    if [[ -n "$search_term" ]]; then
        echo -e "${CYAN}🔍 Buscando por: $search_term${RESET}"
        echo ""
        
        # Buscar em todo o projeto
        find "$PROJECT_ROOT" -name "*$search_term*" -type f 2>/dev/null | head -20
        
        echo ""
        echo -e "${YELLOW}⚠️  Mostrando apenas os primeiros 20 resultados${RESET}"
    fi
    
    echo ""
    read -p "Pressione ENTER para continuar..."
}

# Função para comandos rápidos
quick_commands() {
    while true; do
        show_header
        echo -e "${BOLD}${YELLOW}🚀 COMANDOS RÁPIDOS${RESET}"
        echo -e "${BOLD}${YELLOW}=================${RESET}"
        echo ""
        
        echo -e "${BOLD}📋 COMANDOS DISPONÍVEIS:${RESET}"
        echo -e "${GREEN}1)${RESET} 🧪 Executar teste de portabilidade"
        echo -e "${GREEN}2)${RESET} 📊 Verificar estrutura do projeto"
        echo -e "${GREEN}3)${RESET} 🔧 Criar estrutura ausente"
        echo -e "${GREEN}4)${RESET} 📝 Ver README principal"
        echo -e "${GREEN}5)${RESET} 📚 Ver documentação do usuário"
        echo -e "${GREEN}6)${RESET} 🔍 Listar logs disponíveis"
        echo -e "${GREEN}7)${RESET} 📈 Ver resultados de testes"
        echo -e "${GREEN}8)${RESET} ⚙️ Ver configurações"
        echo ""
        echo -e "${GREEN}0)${RESET} 🔙 Voltar ao menu principal"
        echo ""
        
        read -p "Escolha um comando (0-8): " choice
        
        case $choice in
            1) 
                echo -e "${CYAN}🧪 Executando teste de portabilidade...${RESET}"
                bash "$PROJECT_ROOT/teste_portabilidade.sh"
                echo ""
                read -p "Pressione ENTER para continuar..."
                ;;
            2)
                echo -e "${CYAN}📊 Verificando estrutura...${RESET}"
                bash "$PROJECT_ROOT/scripts/verificar_estrutura.sh"
                echo ""
                read -p "Pressione ENTER para continuar..."
                ;;
            3)
                echo -e "${CYAN}🔧 Criando estrutura...${RESET}"
                bash "$PROJECT_ROOT/scripts/criar_estrutura.sh"
                echo ""
                read -p "Pressione ENTER para continuar..."
                ;;
            4)
                echo -e "${CYAN}📝 Mostrando README...${RESET}"
                if [[ -f "$PROJECT_ROOT/docs/user/README.md" ]]; then
                    cat "$PROJECT_ROOT/docs/user/README.md" | head -50
                else
                    echo -e "${RED}❌ README não encontrado${RESET}"
                fi
                echo ""
                read -p "Pressione ENTER para continuar..."
                ;;
            5)
                echo -e "${CYAN}📚 Abrindo documentação...${RESET}"
                ls -la "$DOCS_USER_DIR"
                echo ""
                read -p "Pressione ENTER para continuar..."
                ;;
            6)
                echo -e "${CYAN}🔍 Listando logs...${RESET}"
                find "$ANALOGS_DIR" -name "*.log" | head -20
                echo ""
                read -p "Pressione ENTER para continuar..."
                ;;
            7)
                echo -e "${CYAN}📈 Verificando resultados...${RESET}"
                ls -la "$RESULTS_DIR"
                echo ""
                read -p "Pressione ENTER para continuar..."
                ;;
            8)
                echo -e "${CYAN}⚙️ Verificando configurações...${RESET}"
                ls -la "$CONFIG_DIR"
                echo ""
                read -p "Pressione ENTER para continuar..."
                ;;
            0) break ;;
            *) echo -e "${RED}❌ Opção inválida${RESET}" && sleep 2 ;;
        esac
    done
}

# Função para ver estatísticas
show_statistics() {
    show_header
    echo -e "${BOLD}${YELLOW}📊 ESTATÍSTICAS DO PROJETO${RESET}"
    echo -e "${BOLD}${YELLOW}==========================${RESET}"
    echo ""
    
    echo -e "${BOLD}📁 ESTRUTURA:${RESET}"
    echo -e "• Scripts principais: $(ls $SRC_CORE_DIR/*.sh 2>/dev/null | wc -l)"
    echo -e "• Testes unitários: $(ls $TESTS_UNIT_DIR/*.sh 2>/dev/null | wc -l)"
    echo -e "• Testes integração: $(ls $TESTS_INTEGRATION_DIR/*.sh 2>/dev/null | wc -l)"
    echo -e "• Testes performance: $(ls $TESTS_PERFORMANCE_DIR/*.sh 2>/dev/null | wc -l)"
    echo ""
    
    echo -e "${BOLD}📄 ARQUIVOS:${RESET}"
    echo -e "• Logs realistas: $(find $ANALOGS_DIR -name "*.log" | wc -l)"
    echo -e "• Documentação usuário: $(ls $DOCS_USER_DIR/*.md 2>/dev/null | wc -l)"
    echo -e "• Documentação dev: $(ls $DOCS_DEVELOPER_DIR/*.md 2>/dev/null | wc -l)"
    echo -e "• Configurações: $(ls $CONFIG_DIR/*.conf 2>/dev/null | wc -l)"
    echo ""
    
    echo -e "${BOLD}💾 ESPAÇO EM DISCO:${RESET}"
    du -sh "$PROJECT_ROOT" 2>/dev/null | awk '{print "• Projeto total: " $1}'
    echo ""
    
    read -p "Pressione ENTER para continuar..."
}

# Função para configurações
show_configurations() {
    show_header
    echo -e "${BOLD}${YELLOW}⚙️ CONFIGURAÇÕES DO SISTEMA${RESET}"
    echo -e "${BOLD}${YELLOW}==========================${RESET}"
    echo ""
    
    echo -e "${BOLD}📁 DIRETÓRIOS PRINCIPAIS:${RESET}"
    echo -e "• Projeto raiz: $PROJECT_ROOT"
    echo -e "• Configurações: $CONFIG_DIR"
    echo -e "• Scripts: $SRC_SCRIPTS_DIR"
    echo -e "• Logs: $ANALOGS_DIR"
    echo -e "• Resultados: $RESULTS_DIR"
    echo ""
    
    echo -e "${BOLD}📄 ARQUIVOS DE CONFIGURAÇÃO:${RESET}"
    ls -la "$CONFIG_DIR"
    echo ""
    
    echo -e "${BOLD}🔧 PERMISSÕES:${RESET}"
    echo -e "• Scripts executáveis: $(find "$PROJECT_ROOT" -name "*.sh" -executable | wc -l)"
    echo -e "• Total de scripts: $(find "$PROJECT_ROOT" -name "*.sh" | wc -l)"
    echo ""
    
    read -p "Pressione ENTER para continuar..."
}

# Menu principal
main_menu() {
    while true; do
        show_header
        echo -e "${BOLD}${CYAN}MENU PRINCIPAL${RESET}"
        echo -e "${BOLD}${CYAN}=============${RESET}"
        echo ""
        
        echo -e "${GREEN}1)${RESET} 📁 Navegar diretórios"
        echo -e "${GREEN}2)${RESET} 🔍 Buscar arquivos"
        echo -e "${GREEN}3)${RESET} 🚀 Comandos rápidos"
        echo -e "${GREEN}4)${RESET} 📊 Ver estatísticas"
        echo -e "${GREEN}5)${RESET} ⚙️ Configurações"
        echo ""
        echo -e "${GREEN}0)${RESET} 🚪 Sair"
        echo ""
        
        read -p "Escolha uma opção (0-5): " choice
        
        case $choice in
            1) navigate_directories ;;
            2) search_files ;;
            3) quick_commands ;;
            4) show_statistics ;;
            5) show_configurations ;;
            0) 
                echo -e "${GREEN}👋 Saindo do navegador...${RESET}"
                exit 0
                ;;
            *) 
                echo -e "${RED}❌ Opção inválida${RESET}"
                sleep 2
                ;;
        esac
    done
}

# Iniciar navegador
main_menu
