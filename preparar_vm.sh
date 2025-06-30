#!/bin/bash

# ===================================================================================
# PREPARAÇÃO PARA VM - SISTEMA DE ANÁLISE DE LOGS
# ===================================================================================
# Script para preparar o projeto para uso na VM do Kali Linux
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

# Função para limpar tela
clear_screen() {
    clear
}

# Função para mostrar cabeçalho
show_header() {
    clear_screen
    echo -e "${BOLD}${CYAN}🚀 PREPARAÇÃO PARA VM DO KALI LINUX${RESET}"
    echo -e "${BOLD}${CYAN}============================================${RESET}"
    echo -e "${BOLD}📁 Diretório do projeto: $PROJECT_ROOT${RESET}"
    echo ""
}

# Função para configurar permissões
configure_permissions() {
    echo -e "${BOLD}${YELLOW}🔐 Configurando permissões de execução${RESET}"
    echo -e "${BOLD}${YELLOW}=====================================${RESET}"
    
    # Contar scripts antes
    total_scripts=$(find "$PROJECT_ROOT" -name "*.sh" -type f | wc -l)
    echo -e "📊 Total de scripts encontrados: $total_scripts"
    
    # Dar permissões
    find "$PROJECT_ROOT" -name "*.sh" -type f -exec chmod +x {} \;
    
    # Verificar permissões
    executable_scripts=$(find "$PROJECT_ROOT" -name "*.sh" -type f -executable | wc -l)
    
    if [[ $executable_scripts -eq $total_scripts ]]; then
        echo -e "${GREEN}✅ Permissões configuradas com sucesso${RESET}"
        echo -e "${GREEN}✅ $executable_scripts scripts agora são executáveis${RESET}"
    else
        echo -e "${YELLOW}⚠️  $executable_scripts de $total_scripts scripts são executáveis${RESET}"
    fi
    
    echo ""
}

# Função para verificar dependências
check_dependencies() {
    echo -e "${BOLD}${YELLOW}🔍 Verificando dependências${RESET}"
    echo -e "${BOLD}${YELLOW}========================${RESET}"
    
    local missing_deps=()
    
    # Verificar dependências essenciais
    if ! command -v bash &> /dev/null; then
        missing_deps+=("bash")
    else
        echo -e "${GREEN}✅ bash${RESET}"
    fi
    
    if ! command -v grep &> /dev/null; then
        missing_deps+=("grep")
    else
        echo -e "${GREEN}✅ grep${RESET}"
    fi
    
    if ! command -v awk &> /dev/null; then
        missing_deps+=("awk")
    else
        echo -e "${GREEN}✅ awk${RESET}"
    fi
    
    if ! command -v sed &> /dev/null; then
        missing_deps+=("sed")
    else
        echo -e "${GREEN}✅ sed${RESET}"
    fi
    
    if ! command -v sort &> /dev/null; then
        missing_deps+=("sort")
    else
        echo -e "${GREEN}✅ sort${RESET}"
    fi
    
    if ! command -v uniq &> /dev/null; then
        missing_deps+=("uniq")
    else
        echo -e "${GREEN}✅ uniq${RESET}"
    fi
    
    # Verificar dependências opcionais
    if ! command -v curl &> /dev/null; then
        echo -e "${YELLOW}⚠️  curl (opcional)${RESET}"
    else
        echo -e "${GREEN}✅ curl${RESET}"
    fi
    
    if ! command -v jq &> /dev/null; then
        echo -e "${YELLOW}⚠️  jq (opcional)${RESET}"
    else
        echo -e "${GREEN}✅ jq${RESET}"
    fi
    
    if ! command -v wget &> /dev/null; then
        echo -e "${YELLOW}⚠️  wget (opcional)${RESET}"
    else
        echo -e "${GREEN}✅ wget${RESET}"
    fi
    
    if [[ ${#missing_deps[@]} -gt 0 ]]; then
        echo -e "\n${RED}❌ Dependências faltando: ${missing_deps[*]}${RESET}"
        echo -e "${YELLOW}💡 Execute: sudo apt update && sudo apt install ${missing_deps[*]}${RESET}"
        return 1
    else
        echo -e "\n${GREEN}✅ Todas as dependências essenciais estão presentes${RESET}"
        return 0
    fi
    
    echo ""
}

# Função para recriar configuração
recreate_config() {
    echo -e "${BOLD}${YELLOW}🔧 Recriando configuração dinâmica${RESET}"
    echo -e "${BOLD}${YELLOW}==================================${RESET}"
    
    if [[ -f "$PROJECT_ROOT/src/scripts/utils/create_config.sh" ]]; then
        bash "$PROJECT_ROOT/src/scripts/utils/create_config.sh"
        if [[ $? -eq 0 ]]; then
            echo -e "${GREEN}✅ Configuração recriada com sucesso${RESET}"
        else
            echo -e "${RED}❌ Falha ao recriar configuração${RESET}"
            return 1
        fi
    else
        echo -e "${RED}❌ Script create_config.sh não encontrado${RESET}"
        return 1
    fi
    
    echo ""
}

# Função para criar estrutura
create_structure() {
    echo -e "${BOLD}${YELLOW}📂 Criando estrutura de diretórios${RESET}"
    echo -e "${BOLD}${YELLOW}================================${RESET}"
    
    if [[ -f "$PROJECT_ROOT/scripts/criar_estrutura.sh" ]]; then
        bash "$PROJECT_ROOT/scripts/criar_estrutura.sh"
        if [[ $? -eq 0 ]]; then
            echo -e "${GREEN}✅ Estrutura de diretórios criada${RESET}"
        else
            echo -e "${RED}❌ Falha ao criar estrutura${RESET}"
            return 1
        fi
    else
        echo -e "${YELLOW}⚠️  Script criar_estrutura.sh não encontrado${RESET}"
        return 1
    fi
    
    echo ""
}

# Função para verificar estrutura
verify_structure() {
    echo -e "${BOLD}${YELLOW}🔍 Verificando estrutura do projeto${RESET}"
    echo -e "${BOLD}${YELLOW}================================${RESET}"
    
    if [[ -f "$PROJECT_ROOT/scripts/verificar_estrutura.sh" ]]; then
        bash "$PROJECT_ROOT/scripts/verificar_estrutura.sh"
    else
        echo -e "${YELLOW}⚠️  Script verificar_estrutura.sh não encontrado${RESET}"
    fi
    
    echo ""
}

# Função para testar portabilidade
test_portability() {
    echo -e "${BOLD}${YELLOW}🌍 Testando portabilidade${RESET}"
    echo -e "${BOLD}${YELLOW}========================${RESET}"
    
    if [[ -f "$PROJECT_ROOT/teste_portabilidade.sh" ]]; then
        bash "$PROJECT_ROOT/teste_portabilidade.sh"
    else
        echo -e "${YELLOW}⚠️  Script teste_portabilidade.sh não encontrado${RESET}"
    fi
    
    echo ""
}

# Função para criar instruções
create_instructions() {
    echo -e "${BOLD}${YELLOW}📝 Criando instruções para VM${RESET}"
    echo -e "${BOLD}${YELLOW}============================${RESET}"
    
    INSTRUCTIONS_FILE="$PROJECT_ROOT/INSTRUCOES_VM.md"
    
    cat > "$INSTRUCTIONS_FILE" << 'EOF'
# INSTRUÇÕES PARA USO NA VM DO KALI LINUX

## Pré-requisitos
- Kali Linux instalado no VirtualBox
- Git instalado: `sudo apt update && sudo apt install git`
- Ferramentas básicas: `sudo apt install curl wget jq`

## Passos para configuração

### 1. Clonar ou copiar o projeto
```bash
# Se usando git:
git clone https://github.com/jacksonzacarias/log-analyzer-pro.git
cd log-analyzer-pro

# Se copiando arquivos:
# Copie toda a pasta do projeto para a VM
cd /caminho/para/o/projeto
```

### 2. Executar preparação automática
```bash
./preparar_vm.sh
```

### 3. Testar o sistema
```bash
./iniciar_projeto.sh
```

### 4. Executar análise de logs
```bash
# Análise básica
./src/scripts/core/scriptlogs.sh

# Análise avançada
./src/scripts/core/scriptlogs_avancado.sh

# Análise sem jq (para sistemas sem jq)
./src/scripts/core/scriptlogs_sem_jq.sh
```

## Estrutura do projeto
- `analogs/` - Logs para análise
- `config/` - Arquivos de configuração
- `src/scripts/core/` - Scripts principais
- `results/` - Resultados das análises
- `docs/` - Documentação

## Troubleshooting
- Se houver problemas de permissão: `chmod +x *.sh`
- Se faltar jq: `sudo apt install jq`
- Se faltar curl: `sudo apt install curl`
- Para ver logs de erro: `tail -f logs/error.log`

## Comandos úteis
```bash
# Verificar estrutura
./scripts/verificar_estrutura.sh

# Criar estrutura ausente
./scripts/criar_estrutura.sh

# Testar portabilidade
./teste_portabilidade.sh

# Navegar no projeto
./navegar_projeto.sh
```
EOF

    echo -e "${GREEN}✅ Instruções criadas: $INSTRUCTIONS_FILE${RESET}"
    echo ""
}

# Função para preparação automática completa
auto_preparation() {
    echo -e "${BOLD}${CYAN}🤖 PREPARAÇÃO AUTOMÁTICA COMPLETA${RESET}"
    echo -e "${BOLD}${CYAN}================================${RESET}"
    echo ""
    
    # Executar todos os passos
    configure_permissions
    check_dependencies
    recreate_config
    create_structure
    verify_structure
    test_portability
    create_instructions
    
    echo -e "${BOLD}${GREEN}🎉 PREPARAÇÃO AUTOMÁTICA CONCLUÍDA!${RESET}"
    echo ""
}

# Menu principal
main_menu() {
    while true; do
        show_header
        echo -e "${BOLD}${CYAN}MENU DE PREPARAÇÃO${RESET}"
        echo -e "${BOLD}${CYAN}=================${RESET}"
        echo ""
        
        echo -e "${GREEN}1)${RESET} 🔐 Configurar permissões (chmod +x)"
        echo -e "${GREEN}2)${RESET} 🔍 Verificar dependências"
        echo -e "${GREEN}3)${RESET} 🔧 Recriar configuração"
        echo -e "${GREEN}4)${RESET} 📂 Criar estrutura"
        echo -e "${GREEN}5)${RESET} 🔍 Verificar estrutura"
        echo -e "${GREEN}6)${RESET} 🌍 Testar portabilidade"
        echo -e "${GREEN}7)${RESET} 📝 Criar instruções"
        echo -e "${GREEN}8)${RESET} 🤖 TUDO AUTOMÁTICO"
        echo ""
        echo -e "${GREEN}0)${RESET} 🚪 Sair"
        echo ""
        
        read -p "Escolha uma opção (0-8): " choice
        
        case $choice in
            1) configure_permissions ;;
            2) check_dependencies ;;
            3) recreate_config ;;
            4) create_structure ;;
            5) verify_structure ;;
            6) test_portability ;;
            7) create_instructions ;;
            8) auto_preparation ;;
            0) 
                echo -e "${GREEN}👋 Saindo...${RESET}"
                exit 0
                ;;
            *) 
                echo -e "${RED}❌ Opção inválida${RESET}"
                sleep 2
                ;;
        esac
        
        if [[ $choice -ne 0 ]]; then
            echo ""
            read -p "Pressione ENTER para continuar..."
        fi
    done
}

# Verificar se foi chamado com argumentos
if [[ $# -eq 0 ]]; then
    # Modo interativo
    main_menu
else
    # Modo automático (compatibilidade)
    show_header
    echo -e "${BOLD}${YELLOW}📁 Diretório do projeto: $PROJECT_ROOT${RESET}"
    auto_preparation
    
    # Resumo final
    echo -e "\n${BOLD}${CYAN}📊 RESUMO DA PREPARAÇÃO${RESET}"
    echo -e "${BOLD}${CYAN}========================${RESET}"
    echo -e "${GREEN}✅ Projeto preparado para VM do Kali Linux${RESET}"
    echo -e "${GREEN}✅ Configuração dinâmica criada${RESET}"
    echo -e "${GREEN}✅ Permissões configuradas${RESET}"
    echo -e "${GREEN}✅ Estrutura verificada${RESET}"
    echo -e "${GREEN}✅ Instruções criadas${RESET}"

    echo -e "\n${BOLD}${BLUE}🚀 PRÓXIMOS PASSOS:${RESET}"
    echo -e "1. Copie toda a pasta do projeto para a VM do Kali Linux"
    echo -e "2. Na VM, execute: cd /caminho/para/o/projeto"
    echo -e "3. Execute: ./preparar_vm.sh"
    echo -e "4. Execute: ./iniciar_projeto.sh"
    echo -e "5. Teste os scripts de análise"

    echo -e "\n${BOLD}${GREEN}🎉 PROJETO PRONTO PARA USO NA VM!${RESET}"
fi 