#!/bin/bash

# ===================================================================================
# SELETOR DE ARQUIVOS POR ÍNDICE - LOG ANALYZER PRO
# ===================================================================================
# Utilitário para seleção interativa de arquivos com suporte a seleção múltipla
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

# Variável global para armazenar arquivos selecionados
SELECTED_FILES=()

# Função para selecionar arquivos por índice
select_files_by_index() {
    local directory="$1"
    local pattern="${2:-*.log}"
    local title="${3:-Arquivos disponíveis}"
    
    # Limpar array global
    SELECTED_FILES=()
    
    # Verificar se o diretório existe
    if [[ ! -d "$directory" ]]; then
        echo -e "${RED}❌ Diretório não encontrado: $directory${RESET}" >&2
        return 1
    fi
    
    # Encontrar arquivos
    local files=()
    while IFS= read -r -d '' file; do
        files+=("$file")
    done < <(find "$directory" -name "$pattern" -type f -print0 2>/dev/null)
    
    if [[ ${#files[@]} -eq 0 ]]; then
        echo -e "${YELLOW}⚠️  Nenhum arquivo encontrado em: $directory${RESET}" >&2
        return 1
    fi
    
    # Mostrar lista de arquivos
    echo -e "${BOLD}${CYAN}$title${RESET}"
    echo -e "${BOLD}${CYAN}$(printf '=%.0s' {1..50})${RESET}"
    echo ""
    
    for i in "${!files[@]}"; do
        local filename=$(basename "${files[$i]}")
        local relative_path=$(realpath --relative-to="$directory" "${files[$i]}")
        echo -e "${GREEN}$((i+1)))${RESET} $filename"
        echo -e "    📁 $relative_path"
    done
    
    echo ""
    echo -e "${GREEN}0)${RESET} TODOS OS ARQUIVOS"
    echo ""
    echo -e "${YELLOW}💡 Dicas de seleção:${RESET}"
    echo -e "   • Único: 1"
    echo -e "   • Múltiplos: 1,3,5"
    echo -e "   • Intervalo: 1-5"
    echo -e "   • Misto: 1-3,5,7-9"
    echo -e "   • Todos: 0"
    echo ""
    
    # Ler seleção do usuário
    read -p "Digite sua escolha: " selection
    
    # Processar seleção
    local selected_files=()
    
    # Se '0' estiver em qualquer parte da seleção, selecionar todos
    if [[ ",${selection}," =~ ",0," ]]; then
        selected_files=("${files[@]}")
        echo -e "${GREEN}✅ Todos os ${#files[@]} arquivos selecionados${RESET}" >&2
    else
        # Processar seleção múltipla
        IFS=',' read -ra choices <<< "$selection"
        
        for choice in "${choices[@]}"; do
            choice=$(echo "$choice" | tr -d ' ')
            
            if [[ "$choice" =~ ^[0-9]+$ ]]; then
                # Número único
                local index=$((choice - 1))
                if [[ $index -ge 0 && $index -lt ${#files[@]} ]]; then
                    selected_files+=("${files[$index]}")
                else
                    echo -e "${RED}❌ Índice inválido: $choice${RESET}" >&2
                fi
            elif [[ "$choice" =~ ^[0-9]+-[0-9]+$ ]]; then
                # Intervalo
                local start=$(echo "$choice" | cut -d'-' -f1)
                local end=$(echo "$choice" | cut -d'-' -f2)
                start=$((start - 1))
                end=$((end - 1))
                
                if [[ $start -ge 0 && $end -ge $start && $end -lt ${#files[@]} ]]; then
                    for ((i=start; i<=end; i++)); do
                        selected_files+=("${files[$i]}")
                    done
                else
                    echo -e "${RED}❌ Intervalo inválido: $choice${RESET}" >&2
                fi
            else
                echo -e "${RED}❌ Formato inválido: $choice${RESET}" >&2
            fi
        done
    fi
    
    # Remover duplicatas
    if [[ ${#selected_files[@]} -gt 0 ]]; then
        local unique_files=()
        for file in "${selected_files[@]}"; do
            if [[ ! " ${unique_files[@]} " =~ " ${file} " ]]; then
                unique_files+=("$file")
            fi
        done
        selected_files=("${unique_files[@]}")
        
        echo -e "${GREEN}✅ ${#selected_files[@]} arquivo(s) selecionado(s):${RESET}" >&2
        for file in "${selected_files[@]}"; do
            echo -e "   📄 $(basename "$file")" >&2
        done
        
        # Armazenar na variável global
        SELECTED_FILES=("${selected_files[@]}")
    else
        echo -e "${RED}❌ Nenhum arquivo válido selecionado${RESET}" >&2
        return 1
    fi
}

# Função para seleção simples (apenas um arquivo)
select_single_file() {
    local directory="$1"
    local pattern="${2:-*.log}"
    local title="${3:-Selecione um arquivo}"
    
    local files=($(select_files_by_index "$directory" "$pattern" "$title"))
    
    if [[ ${#files[@]} -eq 1 ]]; then
        echo "${files[0]}"
        return 0
    elif [[ ${#files[@]} -gt 1 ]]; then
        echo -e "${YELLOW}⚠️  Múltiplos arquivos selecionados, usando o primeiro${RESET}"
        echo "${files[0]}"
        return 0
    else
        return 1
    fi
}

# Função para mostrar arquivos disponíveis sem seleção
list_available_files() {
    local directory="$1"
    local pattern="${2:-*.log}"
    local title="${3:-Arquivos disponíveis}"
    
    if [[ ! -d "$directory" ]]; then
        echo -e "${RED}❌ Diretório não encontrado: $directory${RESET}"
        return 1
    fi
    
    local files=()
    while IFS= read -r -d '' file; do
        files+=("$file")
    done < <(find "$directory" -name "$pattern" -type f -print0 2>/dev/null)
    
    if [[ ${#files[@]} -eq 0 ]]; then
        echo -e "${YELLOW}⚠️  Nenhum arquivo encontrado em: $directory${RESET}"
        return 1
    fi
    
    echo -e "${BOLD}${CYAN}$title${RESET}"
    echo -e "${BOLD}${CYAN}$(printf '=%.0s' {1..50})${RESET}"
    echo ""
    
    for i in "${!files[@]}"; do
        local filename=$(basename "${files[$i]}")
        local relative_path=$(realpath --relative-to="$directory" "${files[$i]}")
        local line_count=$(wc -l < "${files[$i]}" 2>/dev/null || echo "0")
        echo -e "${GREEN}$((i+1)))${RESET} $filename (${line_count} linhas)"
        echo -e "    📁 $relative_path"
    done
    
    echo ""
    echo -e "${CYAN}📊 Total: ${#files[@]} arquivo(s)${RESET}"
}

# Função para validar arquivo
validate_file() {
    local file="$1"
    
    if [[ ! -f "$file" ]]; then
        echo -e "${RED}❌ Arquivo não encontrado: $file${RESET}"
        return 1
    fi
    
    if [[ ! -r "$file" ]]; then
        echo -e "${RED}❌ Arquivo não pode ser lido: $file${RESET}"
        return 1
    fi
    
    echo -e "${GREEN}✅ Arquivo válido: $file${RESET}"
    return 0
}

# Função para mostrar ajuda
show_help() {
    echo -e "${BOLD}${CYAN}📖 AJUDA - SELETOR DE ARQUIVOS${RESET}"
    echo -e "${BOLD}${CYAN}==============================${RESET}"
    echo ""
    echo -e "${BOLD}Uso:${RESET}"
    echo -e "  $0 <diretório> [padrão] [título]"
    echo ""
    echo -e "${BOLD}Exemplos:${RESET}"
    echo -e "  $0 ./analogs '*.log' 'Logs para análise'"
    echo -e "  $0 ./tests 'test_*.sh' 'Scripts de teste'"
    echo ""
    echo -e "${BOLD}Funções disponíveis:${RESET}"
    echo -e "  select_files_by_index <dir> [pattern] [title]"
    echo -e "  select_single_file <dir> [pattern] [title]"
    echo -e "  list_available_files <dir> [pattern] [title]"
    echo -e "  validate_file <file>"
    echo ""
}

# Função para navegar por pastas primeiro
navigate_and_select_file() {
    local base_directory="$1"
    local pattern="${2:-*.log}"
    local title="${3:-Navegar e Selecionar Arquivo}"
    
    # Verificar se o diretório base existe
    if [[ ! -d "$base_directory" ]]; then
        echo -e "${RED}❌ Diretório base não encontrado: $base_directory${RESET}" >&2
        return 1
    fi
    
    local current_dir="$base_directory"
    
    while true; do
        # Limpar tela (opcional)
        # clear
        
        echo -e "${BOLD}${CYAN}$title${RESET}"
        echo -e "${BOLD}${CYAN}$(printf '=%.0s' {1..60})${RESET}"
        echo ""
        echo -e "${YELLOW}📁 Diretório atual: $current_dir${RESET}"
        echo ""
        
        # Encontrar subdiretórios
        local subdirs=()
        for item in "$current_dir"/*; do
            if [[ -d "$item" ]]; then
                subdirs+=("$item")
            fi
        done
        
        # Ordenar subdiretórios
        IFS=$'\n' subdirs=($(sort <<<"${subdirs[*]}"))
        unset IFS
        
        # Encontrar arquivos no diretório atual (incluindo .log e .txt)
        local files=()
        for item in "$current_dir"/*; do
            if [[ -f "$item" ]]; then
                local filename=$(basename "$item")
                if [[ "$filename" =~ \.(log|txt)$ ]]; then
                    files+=("$item")
                fi
            fi
        done
        
        # Ordenar arquivos
        IFS=$'\n' files=($(sort <<<"${files[*]}"))
        unset IFS
        
        # Mostrar opções de navegação
        echo -e "${BOLD}${GREEN}📂 PASTAS DISPONÍVEIS:${RESET}"
        if [[ ${#subdirs[@]} -eq 0 ]]; then
            echo -e "${YELLOW}   Nenhuma pasta encontrada${RESET}"
        else
            for i in "${!subdirs[@]}"; do
                local dirname=$(basename "${subdirs[$i]}")
                echo -e "${GREEN}$((i+1)))${RESET} 📁 $dirname"
            done
        fi
        
        echo ""
        echo -e "${BOLD}${BLUE}📄 ARQUIVOS DISPONÍVEIS:${RESET}"
        if [[ ${#files[@]} -eq 0 ]]; then
            echo -e "${YELLOW}   Nenhum arquivo encontrado${RESET}"
        else
            for i in "${!files[@]}"; do
                local filename=$(basename "${files[$i]}")
                local line_count=$(wc -l < "${files[$i]}" 2>/dev/null || echo "0")
                echo -e "${BLUE}$((i+${#subdirs[@]}+1)))${RESET} 📄 $filename (${line_count} linhas)"
            done
        fi
        
        echo ""
        echo -e "${BOLD}${WHITE}🔧 OPÇÕES DE NAVEGAÇÃO:${RESET}"
        echo -e "${WHITE}0)${RESET} Voltar ao diretório anterior"
        echo -e "${WHITE}00)${RESET} Voltar ao diretório raiz"
        echo -e "${WHITE}q)${RESET} Sair"
        echo ""
        
        # Ler escolha do usuário
        read -p "Digite sua escolha: " choice
        
        case $choice in
            q|Q)
                echo -e "${CYAN}👋 Saindo...${RESET}" >&2
                return 1
                ;;
            0)
                # Voltar ao diretório anterior
                if [[ "$current_dir" != "$base_directory" ]]; then
                    current_dir=$(dirname "$current_dir")
                else
                    echo -e "${YELLOW}⚠️  Já está no diretório raiz${RESET}" >&2
                fi
                ;;
            00)
                # Voltar ao diretório raiz
                current_dir="$base_directory"
                ;;
            *)
                # Verificar se é um número válido
                if [[ "$choice" =~ ^[0-9]+$ ]]; then
                    local index=$((choice - 1))
                    
                    # Verificar se é uma pasta
                    if [[ $index -ge 0 && $index -lt ${#subdirs[@]} ]]; then
                        current_dir="${subdirs[$index]}"
                    # Verificar se é um arquivo
                    elif [[ $index -ge ${#subdirs[@]} && $index -lt $((${#subdirs[@]} + ${#files[@]})) ]]; then
                        local file_index=$((index - ${#subdirs[@]}))
                        local selected_file="${files[$file_index]}"
                        
                        echo -e "${GREEN}✅ Arquivo selecionado: $(basename "$selected_file")${RESET}" >&2
                        
                        # Armazenar na variável global
                        SELECTED_FILES=("$selected_file")
                        return 0
                    else
                        echo -e "${RED}❌ Opção inválida: $choice${RESET}" >&2
                    fi
                else
                    echo -e "${RED}❌ Opção inválida: $choice${RESET}" >&2
                fi
                ;;
        esac
        
        echo ""
        echo -e "${YELLOW}Pressione Enter para continuar...${RESET}" >&2
        read -r
    done
}

# Se executado diretamente
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    if [[ $# -eq 0 ]]; then
        show_help
        exit 0
    fi
    
    directory="$1"
    pattern="${2:-*.log}"
    title="${3:-Arquivos disponíveis}"
    
    select_files_by_index "$directory" "$pattern" "$title"
fi 