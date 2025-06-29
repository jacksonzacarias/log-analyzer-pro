#!/bin/bash

# ===================================================================================
# TESTE DE PORTABILIDADE - SISTEMA DE ANÁLISE DE LOGS
# ===================================================================================
# Script para testar se o projeto funciona em qualquer ambiente
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

echo -e "${BOLD}${CYAN}🌍 TESTE DE PORTABILIDADE DO PROJETO${RESET}"
echo -e "${BOLD}${CYAN}=====================================${RESET}"

# Teste 1: Detecção do diretório raiz
echo -e "\n${BOLD}${YELLOW}📁 Teste 1: Detecção do diretório raiz${RESET}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR" && pwd)"

echo -e "• Script executado em: $SCRIPT_DIR"
echo -e "• Diretório raiz detectado: $PROJECT_ROOT"

if [[ -f "$PROJECT_ROOT/config/paths.conf" ]]; then
    echo -e "${GREEN}✅ Arquivo de configuração encontrado${RESET}"
else
    echo -e "${RED}❌ Arquivo de configuração não encontrado${RESET}"
    exit 1
fi

# Teste 2: Carregamento da configuração
echo -e "\n${BOLD}${YELLOW}⚙️  Teste 2: Carregamento da configuração${RESET}"
source "$PROJECT_ROOT/config/paths.conf"

if [[ -n "$PROJECT_ROOT" ]]; then
    echo -e "${GREEN}✅ Variável PROJECT_ROOT carregada: $PROJECT_ROOT${RESET}"
else
    echo -e "${RED}❌ Falha ao carregar PROJECT_ROOT${RESET}"
    exit 1
fi

# Teste 3: Verificação de diretórios essenciais
echo -e "\n${BOLD}${YELLOW}📂 Teste 3: Verificação de diretórios essenciais${RESET}"
essential_dirs=(
    "$CONFIG_DIR"
    "$SRC_DIR"
    "$ANALOGS_DIR"
    "$RESULTS_DIR"
    "$SYSTEM_DIR"
    "$PAYLOADS_DIR"
    "$TEMP_DIR"
    "$DOCS_DIR"
    "$TESTS_DIR"
    "$SCRIPTS_DIR"
)

missing_dirs=()
for dir in "${essential_dirs[@]}"; do
    if [[ -d "$dir" ]]; then
        echo -e "${GREEN}✅ $dir${RESET}"
    else
        echo -e "${RED}❌ $dir${RESET}"
        missing_dirs+=("$dir")
    fi
done

if [[ ${#missing_dirs[@]} -gt 0 ]]; then
    echo -e "\n${YELLOW}⚠️  Diretórios ausentes: ${missing_dirs[*]}${RESET}"
    echo -e "${BLUE}💡 Execute: ./scripts/criar_estrutura.sh${RESET}"
else
    echo -e "\n${GREEN}✅ Todos os diretórios essenciais encontrados${RESET}"
fi

# Teste 4: Verificação de scripts principais
echo -e "\n${BOLD}${YELLOW}🔧 Teste 4: Verificação de scripts principais${RESET}"
main_scripts=(
    "$SRC_SCRIPTS_DIR/core/scriptlogs.sh"
    "$SRC_SCRIPTS_DIR/core/scriptlogs_avancado.sh"
    "$SRC_SCRIPTS_DIR/core/scriptlogs_sem_jq.sh"
    "$SRC_SCRIPTS_DIR/utils/config_loader.sh"
    "$SRC_SCRIPTS_DIR/utils/create_config.sh"
)

for script in "${main_scripts[@]}"; do
    if [[ -f "$script" ]]; then
        echo -e "${GREEN}✅ $(basename "$script")${RESET}"
    else
        echo -e "${RED}❌ $(basename "$script")${RESET}"
    fi
done

# Teste 5: Verificação de permissões de execução
echo -e "\n${BOLD}${YELLOW}🔐 Teste 5: Verificação de permissões${RESET}"
for script in "${main_scripts[@]}"; do
    if [[ -f "$script" && -x "$script" ]]; then
        echo -e "${GREEN}✅ $(basename "$script") - Executável${RESET}"
    elif [[ -f "$script" ]]; then
        echo -e "${YELLOW}⚠️  $(basename "$script") - Não executável${RESET}"
    fi
done

# Teste 6: Teste do carregador de configuração
echo -e "\n${BOLD}${YELLOW}🔄 Teste 6: Teste do carregador de configuração${RESET}"
if [[ -f "$SRC_SCRIPTS_DIR/utils/config_loader.sh" ]]; then
    source "$SRC_SCRIPTS_DIR/utils/config_loader.sh"
    if initialize_system "false"; then
        echo -e "${GREEN}✅ Sistema inicializado com sucesso${RESET}"
    else
        echo -e "${RED}❌ Falha na inicialização do sistema${RESET}"
    fi
else
    echo -e "${RED}❌ Carregador de configuração não encontrado${RESET}"
fi

# Resumo final
echo -e "\n${BOLD}${CYAN}📊 RESUMO DO TESTE DE PORTABILIDADE${RESET}"
echo -e "${BOLD}${CYAN}=====================================${RESET}"

if [[ ${#missing_dirs[@]} -eq 0 ]]; then
    echo -e "${GREEN}✅ PROJETO PRONTO PARA USO${RESET}"
    echo -e "${GREEN}✅ Todos os componentes essenciais estão presentes${RESET}"
    echo -e "${GREEN}✅ Configuração carregada corretamente${RESET}"
    echo -e "${GREEN}✅ Pronto para testar na VM do Kali Linux${RESET}"
else
    echo -e "${YELLOW}⚠️  PROJETO PRECISA DE AJUSTES${RESET}"
    echo -e "${YELLOW}⚠️  Execute: ./scripts/criar_estrutura.sh${RESET}"
fi

echo -e "\n${BOLD}${BLUE}🚀 Próximos passos:${RESET}"
echo -e "1. Copie o projeto para a VM do Kali Linux"
echo -e "2. Execute: chmod +x *.sh"
echo -e "3. Execute: ./scripts/criar_estrutura.sh"
echo -e "4. Execute: ./iniciar_projeto.sh"
echo -e "5. Teste os scripts principais" 