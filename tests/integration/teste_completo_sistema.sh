#!/bin/bash

# ===================================================================================
# TESTE COMPLETO DO SISTEMA DE ANÁLISE DE LOGS
# ===================================================================================
# Testa todos os logs disponíveis e salva resultados para análise
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

# Arquivo de resultados
RESULTADOS_FILE="resultados_teste_completo_$(date +%Y%m%d_%H%M%S).txt"
SCRIPT_PRINCIPAL="src/scripts/core/scriptlogs_avancado.sh"

# Função para testar um arquivo de log
testar_log() {
    local arquivo="$1"
    local nome_arquivo=$(basename "$arquivo")
    
    echo -e "\n${BOLD}${CYAN}🔍 TESTANDO: $nome_arquivo${RESET}"
    echo -e "${BOLD}${CYAN}================================${RESET}"
    
    # Verifica se o arquivo existe e não está vazio
    if [[ ! -f "$arquivo" ]]; then
        echo -e "${RED}❌ Arquivo não encontrado: $arquivo${RESET}"
        return 1
    fi
    
    if [[ ! -s "$arquivo" ]]; then
        echo -e "${YELLOW}⚠️  Arquivo vazio: $arquivo${RESET}"
        return 1
    fi
    
    # Salva cabeçalho no arquivo de resultados
    echo "==================================================================================" >> "$RESULTADOS_FILE"
    echo "TESTE: $nome_arquivo" >> "$RESULTADOS_FILE"
    echo "ARQUIVO: $arquivo" >> "$RESULTADOS_FILE"
    echo "DATA/HORA: $(date '+%Y-%m-%d %H:%M:%S')" >> "$RESULTADOS_FILE"
    echo "==================================================================================" >> "$RESULTADOS_FILE"
    
    # Executa o script com todas as funcionalidades
    echo -e "${GREEN}✅ Executando análise completa...${RESET}"
    
    # Captura a saída do script
    local output=$(bash "$SCRIPT_PRINCIPAL" -v -t -aR -gT -pedago -pcn -peso -correl "$arquivo" 2>&1)
    local exit_code=$?
    
    # Salva a saída no arquivo de resultados
    echo "$output" >> "$RESULTADOS_FILE"
    echo "" >> "$RESULTADOS_FILE"
    echo "==================================================================================" >> "$RESULTADOS_FILE"
    echo "" >> "$RESULTADOS_FILE"
    
    # Exibe resultado resumido
    if [[ $exit_code -eq 0 ]]; then
        echo -e "${GREEN}✅ Análise concluída com sucesso${RESET}"
        
        # Extrai informações importantes
        local score=$(echo "$output" | grep "Score de Risco Geral" | grep -o "[0-9]\+ pontos" | head -1)
        local eventos_criticos=$(echo "$output" | grep "CRÍTICO:" | grep -o "[0-9]\+ eventos" | head -1)
        local eventos_altos=$(echo "$output" | grep "ALTO:" | grep -o "[0-9]\+ eventos" | head -1)
        local formato=$(echo "$output" | grep "Formato detectado:" | grep -o "[A-Z_]*" | head -1)
        
        echo -e "  📊 Score: $score"
        echo -e "  🔴 Críticos: $eventos_criticos"
        echo -e "  🟣 Altos: $eventos_altos"
        echo -e "  📋 Formato: $formato"
        
    else
        echo -e "${RED}❌ Erro na análise${RESET}"
        echo -e "  💬 Erro: $output"
    fi
    
    echo ""
}

# Função para listar todos os arquivos de log
listar_logs() {
    local logs=()
    
    # Logs na raiz
    for log in *.log; do
        [[ -f "$log" ]] && logs+=("$log")
    done
    
    # Logs em subdiretórios
    for dir in analogs/*/; do
        if [[ -d "$dir" ]]; then
            for log in "$dir"*.log; do
                [[ -f "$log" ]] && logs+=("$log")
            done
        fi
    done
    
    # Logs específicos de ataques
    for log in analogs/attacks/*.log; do
        [[ -f "$log" ]] && logs+=("$log")
    done
    
    echo "${logs[@]}"
}

# Função principal
main() {
    echo -e "${BOLD}${CYAN}🚀 TESTE COMPLETO DO SISTEMA DE ANÁLISE DE LOGS${RESET}"
    echo -e "${BOLD}${CYAN}================================================${RESET}"
    echo -e "${BOLD}Data/Hora: $(date '+%Y-%m-%d %H:%M:%S')${RESET}"
    echo -e "${BOLD}Arquivo de resultados: $RESULTADOS_FILE${RESET}"
    echo ""
    
    # Verifica se o script principal existe
    if [[ ! -f "$SCRIPT_PRINCIPAL" ]]; then
        echo -e "${RED}${BOLD}❌ Script principal não encontrado: $SCRIPT_PRINCIPAL${RESET}"
        exit 1
    fi
    
    # Cria arquivo de resultados
    echo "TESTE COMPLETO DO SISTEMA DE ANÁLISE DE LOGS" > "$RESULTADOS_FILE"
    echo "Data/Hora: $(date '+%Y-%m-%d %H:%M:%S')" >> "$RESULTADOS_FILE"
    echo "Script: $SCRIPT_PRINCIPAL" >> "$RESULTADOS_FILE"
    echo "==================================================================================" >> "$RESULTADOS_FILE"
    echo "" >> "$RESULTADOS_FILE"
    
    # Lista todos os logs disponíveis
    echo -e "${BOLD}📋 ARQUIVOS DE LOG ENCONTRADOS:${RESET}"
    logs_array=($(listar_logs))
    
    if [[ ${#logs_array[@]} -eq 0 ]]; then
        echo -e "${YELLOW}⚠️  Nenhum arquivo de log encontrado${RESET}"
        exit 1
    fi
    
    # Mostra lista de logs
    for i in "${!logs_array[@]}"; do
        echo -e "  $((i+1))) ${logs_array[$i]}"
    done
    
    echo ""
    echo -e "${BOLD}Total de arquivos: ${#logs_array[@]}${RESET}"
    echo ""
    
    # Pergunta se quer testar todos ou selecionar
    read -p "Testar todos os arquivos? (s/n): " testar_todos
    
    if [[ "$testar_todos" =~ ^[Ss]$ ]]; then
        # Testa todos os logs
        echo -e "${BOLD}${GREEN}🔄 Iniciando testes de todos os arquivos...${RESET}"
        echo ""
        
        for arquivo in "${logs_array[@]}"; do
            testar_log "$arquivo"
        done
        
    else
        # Seleção manual
        echo -e "${BOLD}Selecione os arquivos para testar (números separados por espaço):${RESET}"
        read -p "Arquivos: " selecao
        
        for num in $selecao; do
            if [[ $num -ge 1 && $num -le ${#logs_array[@]} ]]; then
                arquivo="${logs_array[$((num-1))]}"
                testar_log "$arquivo"
            else
                echo -e "${RED}❌ Número inválido: $num${RESET}"
            fi
        done
    fi
    
    # Resumo final
    echo -e "\n${BOLD}${GREEN}🎉 TESTE COMPLETO FINALIZADO!${RESET}"
    echo -e "${BOLD}📁 Resultados salvos em: $RESULTADOS_FILE${RESET}"
    echo ""
    echo -e "${BOLD}📊 PRÓXIMOS PASSOS:${RESET}"
    echo -e "  1. Analisar o arquivo de resultados"
    echo -e "  2. Identificar padrões e problemas"
    echo -e "  3. Documentar melhorias necessárias"
    echo -e "  4. Implementar lógicas de pontuação"
    echo ""
    echo -e "${BOLD}💡 DICA: Use 'less $RESULTADOS_FILE' para visualizar os resultados${RESET}"
}

# Executa função principal
main "$@" 