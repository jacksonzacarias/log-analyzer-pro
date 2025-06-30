#!/bin/bash

# ==============================================================================
# SCRIPT: Adicionar Autoria aos Arquivos
# ==============================================================================
# Autor: Jackson A Z Savoldi
# Data: 2024-06-29
# LinkedIn: linkedin.com/in/jacksonzacarias
# Instagram: @jacksonsavoldi
# Formação: Sistemas de Informação - UNIPAR Paranavaí
# Especialização: Segurança da Informação
# ==============================================================================
# Direitos reservados. Proibido uso, cópia ou redistribuição sem autorização.
# ==============================================================================

# Cores para output
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
CYAN="\e[36m"
WHITE="\e[37m"
BOLD="\e[1m"
RESET="\e[0m"

# Cabeçalho de autoria para scripts Bash
BASH_HEADER='#!/bin/bash

# ==============================================================================
# PROJETO: LOG ANALYZER PRO v5.0
# ==============================================================================
# Autor: Jackson A Z Savoldi
# Data: 2024-06-29
# LinkedIn: linkedin.com/in/jacksonzacarias
# Instagram: @jacksonsavoldi
# Formação: Sistemas de Informação - UNIPAR Paranavaí
# Especialização: Segurança da Informação
# ==============================================================================
# Direitos reservados. Proibido uso, cópia ou redistribuição sem autorização.
# ==============================================================================

'

# Cabeçalho para arquivos Markdown
MD_HEADER='# ==============================================================================
# PROJETO: LOG ANALYZER PRO v5.0
# ==============================================================================
# Autor: Jackson A Z Savoldi
# Data: 2024-06-29
# LinkedIn: linkedin.com/in/jacksonzacarias
# Instagram: @jacksonsavoldi
# Formação: Sistemas de Informação - UNIPAR Paranavaí
# Especialização: Segurança da Informação
# ==============================================================================
# Direitos reservados. Proibido uso, cópia ou redistribuição sem autorização.
# ==============================================================================

'

# Função para adicionar cabeçalho a um arquivo
add_header_to_file() {
    local file="$1"
    local header="$2"
    
    if [[ ! -f "$file" ]]; then
        echo -e "${YELLOW}⚠️ Arquivo não encontrado: $file${RESET}"
        return 1
    fi
    
    # Verifica se já tem cabeçalho
    if grep -q "Jackson A Z Savoldi" "$file"; then
        echo -e "${BLUE}ℹ️ Arquivo já possui cabeçalho: $file${RESET}"
        return 0
    fi
    
    # Cria backup
    cp "$file" "$file.backup"
    
    # Adiciona cabeçalho
    echo -e "$header$(cat "$file")" > "$file"
    
    echo -e "${GREEN}✅ Cabeçalho adicionado: $file${RESET}"
    return 0
}

# Lista de arquivos principais para adicionar cabeçalho
main_files=(
    "analisar_logs.sh"
    "src/scripts/core/scriptlogs_avancado.sh"
    "src/scripts/core/scriptlogs.sh"
    "src/scripts/utils/config_loader.sh"
    "src/scripts/utils/environment_detector.sh"
    "src/scripts/utils/system_init.sh"
    "src/scripts/utils/file_selector.sh"
    "src/scripts/generators/gerador_logs_realistas.sh"
    "iniciar_projeto.sh"
    "navegar_projeto.sh"
    "preparar_vm.sh"
    "teste_portabilidade.sh"
)

# Lista de arquivos Markdown
md_files=(
    "README.md"
    "ESTRUTURA_IMPLEMENTACAO.md"
    "PLANO_MELHORIAS.md"
    "INSTRUCOES_VM.md"
    "CORRECOES_PORTABILIDADE.md"
)

echo -e "${CYAN}${BOLD}🔧 ADICIONANDO CABEÇALHOS DE AUTORIA${RESET}"
echo -e "${CYAN}${BOLD}=====================================${RESET}"

# Adiciona cabeçalhos aos scripts principais
echo -e "${BLUE}📝 Processando scripts Bash...${RESET}"
for file in "${main_files[@]}"; do
    add_header_to_file "$file" "$BASH_HEADER"
done

# Adiciona cabeçalhos aos arquivos Markdown
echo -e "${BLUE}📝 Processando arquivos Markdown...${RESET}"
for file in "${md_files[@]}"; do
    add_header_to_file "$file" "$MD_HEADER"
done

echo -e "${GREEN}${BOLD}✅ Processo concluído!${RESET}"
echo -e "${CYAN}ℹ️ Backups criados com extensão .backup${RESET}" 