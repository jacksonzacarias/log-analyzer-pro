#!/usr/bin/env bash

# ===================================================================================
# INTERFACE PRINCIPAL - LOG ANALYZER PRO
# ===================================================================================
# Wrapper principal que integra seletor interativo e chama o core avançado
# Autor: Jackson Savoldi | ACADe-TI - Aula 04
# ===================================================================================

# Carrega configuração centralizada
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$SCRIPT_DIR"
CONFIG_FILE="$PROJECT_ROOT/config/paths.conf"

if [[ -f "$CONFIG_FILE" ]]; then
    source "$CONFIG_FILE"
else
    echo "❌ Arquivo de configuração não encontrado: $CONFIG_FILE"
    exit 1
fi

# Cores para output
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
CYAN="\e[36m"
WHITE="\e[37m"
BOLD="\e[1m"
RESET="\e[0m"

# Função para mostrar banner
show_banner() {
    echo -e "${BOLD}${CYAN}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                    LOG ANALYZER PRO                          ║"
    echo "║              Interface Principal de Análise                  ║"
    echo "║                                                              ║"
    echo "║  ACADe-TI - Aula 04 | Jackson Savoldi | Erick Martinez      ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${RESET}"
}

# Função para mostrar menu de opções
show_options_menu() {
    echo -e "${BOLD}${YELLOW}🔧 OPÇÕES DE ANÁLISE:${RESET}"
    echo ""
    echo -e "${GREEN}1)${RESET} Análise Básica (rápida)"
    echo -e "${GREEN}2)${RESET} Análise Completa (recomendada)"
    echo -e "${GREEN}3)${RESET} Análise Pedagógica (com explicações)"
    echo -e "${GREEN}4)${RESET} Análise por Peso de Ameaça"
    echo -e "${GREEN}5)${RESET} Análise com Correlação de Eventos"
    echo -e "${GREEN}6)${RESET} Análise Personalizada"
    echo -e "${GREEN}0)${RESET} Sair"
    echo ""
}

# Função para análise básica
run_basic_analysis() {
    local log_file="$1"
    echo -e "${BOLD}${CYAN}🔍 Executando Análise Básica...${RESET}"
    echo ""
    
    bash "$PROJECT_ROOT/src/scripts/core/scriptlogs_avancado.sh" \
        -v \
        -r "relatorio_basico.html" \
        "$log_file"
}

# Função para análise completa
run_complete_analysis() {
    local log_file="$1"
    echo -e "${BOLD}${CYAN}🔍 Executando Análise Completa...${RESET}"
    echo ""
    
    bash "$PROJECT_ROOT/src/scripts/core/scriptlogs_avancado.sh" \
        -v -t -aR -gT -pedago -pcn -peso -correl \
        -r "relatorio_completo.html" \
        "$log_file"
}

# Função para análise pedagógica
run_pedagogical_analysis() {
    local log_file="$1"
    echo -e "${BOLD}${CYAN}🔍 Executando Análise Pedagógica...${RESET}"
    echo ""
    
    bash "$PROJECT_ROOT/src/scripts/core/scriptlogs_avancado.sh" \
        -v -t -pedago -aR \
        -r "relatorio_pedagogico.html" \
        "$log_file"
}

# Função para análise por peso
run_weight_analysis() {
    local log_file="$1"
    echo -e "${BOLD}${CYAN}🔍 Executando Análise por Peso de Ameaça...${RESET}"
    echo ""
    
    bash "$PROJECT_ROOT/src/scripts/core/scriptlogs_avancado.sh" \
        -v -peso -aR \
        -r "relatorio_peso.html" \
        "$log_file"
}

# Função para análise com correlação
run_correlation_analysis() {
    local log_file="$1"
    echo -e "${BOLD}${CYAN}🔍 Executando Análise com Correlação...${RESET}"
    echo ""
    
    bash "$PROJECT_ROOT/src/scripts/core/scriptlogs_avancado.sh" \
        -v -correl -gT -aR \
        -r "relatorio_correlacao.html" \
        "$log_file"
}

# Função para análise personalizada
run_custom_analysis() {
    local log_file="$1"
    echo -e "${BOLD}${CYAN}🔧 ANÁLISE PERSONALIZADA${RESET}"
    echo ""
    echo -e "${YELLOW}Selecione as opções desejadas:${RESET}"
    echo ""
    
    local options=""
    
    read -p "Incluir modo verboso? (s/n): " verbose
    if [[ "$verbose" =~ ^[Ss]$ ]]; then
        options="$options -v"
    fi
    
    read -p "Explicar IPs TEST-NET? (s/n): " testnet
    if [[ "$testnet" =~ ^[Ss]$ ]]; then
        options="$options -t"
    fi
    
    read -p "Incluir ações recomendadas? (s/n): " actions
    if [[ "$actions" =~ ^[Ss]$ ]]; then
        options="$options -aR"
    fi
    
    read -p "Gerar timeline? (s/n): " timeline
    if [[ "$timeline" =~ ^[Ss]$ ]]; then
        options="$options -gT"
    fi
    
    read -p "Modo pedagógico? (s/n): " pedagogic
    if [[ "$pedagogic" =~ ^[Ss]$ ]]; then
        options="$options -pedago"
    fi
    
    read -p "Incluir Plano de Continuidade? (s/n): " pcn
    if [[ "$pcn" =~ ^[Ss]$ ]]; then
        options="$options -pcn"
    fi
    
    read -p "Análise por peso? (s/n): " weight
    if [[ "$weight" =~ ^[Ss]$ ]]; then
        options="$options -peso"
    fi
    
    read -p "Correlação de eventos? (s/n): " correlation
    if [[ "$correlation" =~ ^[Ss]$ ]]; then
        options="$options -correl"
    fi
    
    read -p "Nome do relatório (padrão: relatorio_personalizado.html): " report_name
    if [[ -z "$report_name" ]]; then
        report_name="relatorio_personalizado.html"
    fi
    
    echo -e "${BOLD}${CYAN}🔍 Executando Análise Personalizada...${RESET}"
    echo -e "${YELLOW}Opções selecionadas: $options${RESET}"
    echo ""
    
    bash "$PROJECT_ROOT/src/scripts/core/scriptlogs_avancado.sh" \
        $options \
        -r "$report_name" \
        "$log_file"
}

# Função principal
main() {
    show_banner
    
    # Verificar se arquivo foi passado como argumento
    local log_file=""
    if [[ $# -gt 0 ]]; then
        log_file="$1"
        if [[ ! -f "$log_file" ]]; then
            echo -e "${RED}❌ Arquivo não encontrado: $log_file${RESET}"
            exit 1
        fi
    else
        # Se não passou argumento, usar seletor interativo
        if [[ -f "$PROJECT_ROOT/src/scripts/utils/file_selector.sh" ]]; then
            source "$PROJECT_ROOT/src/scripts/utils/file_selector.sh"
            
            echo -e "${BOLD}${CYAN}📁 NAVEGAR E SELECIONAR ARQUIVO DE LOG${RESET}"
            echo ""
            
            # Usar a nova função de navegação
            navigate_and_select_file "$ANALOGS_DIR" "*.log" "Navegar e Selecionar Arquivo de Log"
            
            if [[ ${#SELECTED_FILES[@]} -eq 0 ]]; then
                echo -e "${RED}❌ Nenhum arquivo selecionado. Abortando.${RESET}"
                exit 1
            fi
            
            log_file="${SELECTED_FILES[0]}"
            
            if [[ ${#SELECTED_FILES[@]} -gt 1 ]]; then
                echo -e "${YELLOW}⚠️  Múltiplos arquivos selecionados. Usando apenas o primeiro: $(basename "$log_file")${RESET}"
            fi
            
            echo ""
        else
            echo -e "${RED}❌ Seletor de arquivos não encontrado.${RESET}"
            echo -e "${YELLOW}Uso: $0 <arquivo_de_log>${RESET}"
            exit 1
        fi
    fi
    
    # Verificar se o core existe
    if [[ ! -f "$PROJECT_ROOT/src/scripts/core/scriptlogs_avancado.sh" ]]; then
        echo -e "${RED}❌ Core avançado não encontrado: scriptlogs_avancado.sh${RESET}"
        exit 1
    fi
    
    echo -e "${GREEN}✅ Arquivo selecionado: $(basename "$log_file")${RESET}"
    echo ""
    
    # Menu de opções
    while true; do
        show_options_menu
        read -p "Digite sua escolha: " choice
        
        case $choice in
            1)
                run_basic_analysis "$log_file"
                break
                ;;
            2)
                run_complete_analysis "$log_file"
                break
                ;;
            3)
                run_pedagogical_analysis "$log_file"
                break
                ;;
            4)
                run_weight_analysis "$log_file"
                break
                ;;
            5)
                run_correlation_analysis "$log_file"
                break
                ;;
            6)
                run_custom_analysis "$log_file"
                break
                ;;
            0)
                echo -e "${CYAN}👋 Saindo...${RESET}"
                exit 0
                ;;
            *)
                echo -e "${RED}❌ Opção inválida. Tente novamente.${RESET}"
                ;;
        esac
    done
    
    echo ""
    echo -e "${GREEN}✅ Análise concluída!${RESET}"
    echo -e "${CYAN}📄 Relatório HTML gerado no diretório atual.${RESET}"
}

# Executar função principal
main "$@" 