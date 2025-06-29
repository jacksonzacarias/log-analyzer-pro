#!/bin/bash

# ===================================================================================
# CONVERSOR CSV PARA SISTEMA DE TREINAMENTO
# ===================================================================================
# Converte arquivos CSV de payloads para o sistema de treinamento
# Autor: Jackson Savoldi | ACADe-TI - Aula 04
# ===================================================================================

# Carrega configuração centralizada
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
CONFIG_FILE="$PROJECT_ROOT/config/paths.conf"

if [[ -f "$CONFIG_FILE" ]]; then
    source "$CONFIG_FILE"
else
    echo "❌ Arquivo de configuração não encontrado: $CONFIG_FILE"
    exit 1
fi

# Cores
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
CYAN="\e[36m"
WHITE="\e[37m"
BOLD="\e[1m"
RESET="\e[0m"

# Arquivos de configuração (usando caminhos centralizados)
ATTACK_PATTERNS_FILE="$ATTACK_PATTERNS_FILE"
EVENT_PATTERNS_FILE="$CONFIG_DIR/event_patterns_learning.conf"
LOG_TYPES_FILE="$CONFIG_DIR/log_types_learning.conf"
IMPORT_HISTORY="$SYSTEM_LOGS_DIR/import_history.log"

# Função para verificar se padrão já existe
pattern_exists() {
    local file="$1"
    local pattern="$2"
    
    if [[ -f "$file" ]]; then
        while IFS='|' read -r existing_pattern rest; do
            [[ "$existing_pattern" =~ ^#.*$ ]] && continue
            [[ -z "$existing_pattern" ]] && continue
            
            if [[ "$existing_pattern" == "$pattern" ]]; then
                return 0  # Padrão existe
            fi
        done < "$file"
    fi
    return 1  # Padrão não existe
}

# Função para converter risco CSV para peso do sistema
convert_risk_to_weight() {
    local risk="$1"
    case "$risk" in
        "Critical") echo "10" ;;
        "High") echo "7" ;;
        "Medium") echo "4" ;;
        "Low") echo "1" ;;
        *) echo "4" ;;  # Default
    esac
}

# Função para converter risco CSV para categoria do sistema
convert_risk_to_category() {
    local risk="$1"
    case "$risk" in
        "Critical") echo "CRÍTICO" ;;
        "High") echo "ALTO" ;;
        "Medium") echo "MÉDIO" ;;
        "Low") echo "BAIXO" ;;
        *) echo "MÉDIO" ;;  # Default
    esac
}

# Função para gerar tags baseadas no tipo de ataque
generate_tags() {
    local attack="$1"
    local technique="$2"
    
    # Tags baseadas no tipo de ataque
    case "$attack" in
        *XSS*) echo "xss,web,injection" ;;
        *SQL*) echo "sql,injection,database" ;;
        *XXE*) echo "xxe,xml,external" ;;
        *LFI*) echo "lfi,file,inclusion" ;;
        *RFI*) echo "rfi,file,inclusion" ;;
        *Command*) echo "command,injection,shell" ;;
        *Brute*) echo "brute,force,auth" ;;
        *) echo "attack,web,security" ;;
    esac
}

# Função para importar CSV de payloads
import_payloads_csv() {
    local csv_file="$1"
    
    if [[ ! -f "$csv_file" ]]; then
        echo -e "${RED}${BOLD}❌ Arquivo CSV não encontrado: $csv_file${RESET}"
        return 1
    fi
    
    echo -e "${BOLD}${CYAN}📥 IMPORTANDO PAYLOADS DO CSV: $(basename "$csv_file")${RESET}"
    echo -e "${BOLD}${CYAN}==============================================${RESET}"
    
    local imported_count=0
    local skipped_count=0
    local line_number=0
    
    # Pula o cabeçalho
    tail -n +2 "$csv_file" | while IFS=',' read -r payload attack technique objective risk; do
        ((line_number++))
        
        # Remove aspas extras
        payload=$(echo "$payload" | sed 's/^"//;s/"$//')
        attack=$(echo "$attack" | sed 's/^"//;s/"$//')
        technique=$(echo "$technique" | sed 's/^"//;s/"$//')
        objective=$(echo "$objective" | sed 's/^"//;s/"$//')
        risk=$(echo "$risk" | sed 's/^"//;s/"$//')
        
        # Verifica se o padrão já existe
        if pattern_exists "$ATTACK_PATTERNS_FILE" "$payload"; then
            echo -e "${YELLOW}⚠️  Linha $line_number: Padrão já existe - $attack${RESET}"
            ((skipped_count++))
            continue
        fi
        
        # Converte risco para peso e categoria
        local weight=$(convert_risk_to_weight "$risk")
        local category=$(convert_risk_to_category "$risk")
        local tags=$(generate_tags "$attack" "$technique")
        
        # Cria descrição
        local description="$attack - $technique: $objective"
        
        # Adiciona ao arquivo de padrões
        echo "$payload|$category|$description|$weight|$tags" >> "$ATTACK_PATTERNS_FILE"
        
        echo -e "${GREEN}✅ Linha $line_number: $attack ($category - ${weight}pts)${RESET}"
        ((imported_count++))
        
        # Registra no histórico
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Importado: $attack ($payload)" >> "$IMPORT_HISTORY"
    done
    
    echo -e "\n${BOLD}📊 RESUMO DA IMPORTAÇÃO:${RESET}"
    echo -e "• ${GREEN}Importados: $imported_count padrões${RESET}"
    echo -e "• ${YELLOW}Pulados (já existiam): $skipped_count padrões${RESET}"
    echo -e "• ${CYAN}Total processados: $line_number linhas${RESET}"
}

# Função para mostrar estatísticas dos padrões importados
show_import_statistics() {
    echo -e "\n${BOLD}📈 ESTATÍSTICAS DOS PADRÕES IMPORTADOS${RESET}"
    echo -e "${BOLD}========================================${RESET}"
    
    if [[ -f "$ATTACK_PATTERNS_FILE" ]]; then
        local total_patterns=$(grep -v '^#' "$ATTACK_PATTERNS_FILE" | wc -l)
        local critical_count=$(grep -c "CRÍTICO" "$ATTACK_PATTERNS_FILE" 2>/dev/null || echo "0")
        local high_count=$(grep -c "ALTO" "$ATTACK_PATTERNS_FILE" 2>/dev/null || echo "0")
        local medium_count=$(grep -c "MÉDIO" "$ATTACK_PATTERNS_FILE" 2>/dev/null || echo "0")
        local low_count=$(grep -c "BAIXO" "$ATTACK_PATTERNS_FILE" 2>/dev/null || echo "0")
        
        echo -e "• ${BOLD}Total de padrões:${RESET} $total_patterns"
        echo -e "• ${RED}CRÍTICO: $critical_count${RESET}"
        echo -e "• ${MAGENTA}ALTO: $high_count${RESET}"
        echo -e "• ${YELLOW}MÉDIO: $medium_count${RESET}"
        echo -e "• ${BLUE}BAIXO: $low_count${RESET}"
        
        # Mostra tipos de ataque mais comuns
        echo -e "\n${BOLD}🎯 TIPOS DE ATAQUE MAIS COMUNS:${RESET}"
        grep -v '^#' "$ATTACK_PATTERNS_FILE" | cut -d'|' -f2 | sort | uniq -c | sort -nr | head -5 | while read count type; do
            echo -e "• $type: $count padrões"
        done
    else
        echo -e "${YELLOW}Nenhum arquivo de padrões encontrado${RESET}"
    fi
}

# Função para exportar padrões para CSV
export_patterns_to_csv() {
    local output_file="exported_patterns_$(date +%Y%m%d_%H%M%S).csv"
    
    echo -e "\n${BOLD}📤 EXPORTANDO PADRÕES PARA CSV${RESET}"
    echo -e "${BOLD}================================${RESET}"
    
    # Cabeçalho
    echo "payload,attack,category,weight,description,tags" > "$output_file"
    
    if [[ -f "$ATTACK_PATTERNS_FILE" ]]; then
        while IFS='|' read -r pattern category description weight tags; do
            [[ "$pattern" =~ ^#.*$ ]] && continue
            [[ -z "$pattern" ]] && continue
            
            # Escapa vírgulas e aspas para CSV
            pattern=$(echo "$pattern" | sed 's/"/""/g')
            description=$(echo "$description" | sed 's/"/""/g')
            tags=$(echo "$tags" | sed 's/"/""/g')
            
            echo "\"$pattern\",\"$category\",\"$category\",\"$weight\",\"$description\",\"$tags\"" >> "$output_file"
        done < "$ATTACK_PATTERNS_FILE"
        
        echo -e "${GREEN}${BOLD}✅ Padrões exportados: $output_file${RESET}"
    else
        echo -e "${YELLOW}Nenhum arquivo de padrões para exportar${RESET}"
    fi
}

# Função para mostrar histórico de importações
show_import_history() {
    echo -e "\n${BOLD}📜 HISTÓRICO DE IMPORTAÇÕES${RESET}"
    echo -e "${BOLD}==========================${RESET}"
    
    if [[ -f "$IMPORT_HISTORY" ]]; then
        tail -20 "$IMPORT_HISTORY"
    else
        echo -e "${YELLOW}Nenhum histórico encontrado${RESET}"
    fi
}

# Função principal
main() {
    echo -e "${BOLD}${CYAN}🔄 CONVERSOR CSV PARA SISTEMA DE TREINAMENTO${RESET}"
    echo -e "${BOLD}${CYAN}============================================${RESET}"
    
    # Inicializa arquivos se não existirem
    [[ ! -f "$ATTACK_PATTERNS_FILE" ]] && touch "$ATTACK_PATTERNS_FILE"
    [[ ! -f "$IMPORT_HISTORY" ]] && touch "$IMPORT_HISTORY"
    
    while true; do
        echo -e "\n${BOLD}Escolha uma opção:${RESET}"
        echo "1) Importar CSV de payloads"
        echo "2) Ver estatísticas dos padrões"
        echo "3) Exportar padrões para CSV"
        echo "4) Ver histórico de importações"
        echo "5) Sair"
        
        read -p "Opção: " choice
        
        case $choice in
            1)
                read -p "Caminho do arquivo CSV: " csv_file
                import_payloads_csv "$csv_file"
                ;;
            2)
                show_import_statistics
                ;;
            3)
                export_patterns_to_csv
                ;;
            4)
                show_import_history
                ;;
            5)
                echo -e "${GREEN}${BOLD}✅ Conversão concluída!${RESET}"
                exit 0
                ;;
            *)
                echo -e "${RED}Opção inválida${RESET}"
                ;;
        esac
    done
}

# Executa função principal
main "$@" 