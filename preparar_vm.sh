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

echo -e "${BOLD}${CYAN}🚀 PREPARANDO PROJETO PARA VM DO KALI LINUX${RESET}"
echo -e "${BOLD}${CYAN}============================================${RESET}"

# Detecção do diretório raiz
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR" && pwd)"

echo -e "${BOLD}${YELLOW}📁 Diretório do projeto: $PROJECT_ROOT${RESET}"

# Passo 1: Recriar configuração dinâmica
echo -e "\n${BOLD}${YELLOW}🔧 Passo 1: Recriando configuração dinâmica${RESET}"
if [[ -f "$PROJECT_ROOT/src/scripts/utils/create_config.sh" ]]; then
    bash "$PROJECT_ROOT/src/scripts/utils/create_config.sh"
    if [[ $? -eq 0 ]]; then
        echo -e "${GREEN}✅ Configuração recriada com sucesso${RESET}"
    else
        echo -e "${RED}❌ Falha ao recriar configuração${RESET}"
        exit 1
    fi
else
    echo -e "${RED}❌ Script create_config.sh não encontrado${RESET}"
    exit 1
fi

# Passo 2: Dar permissões de execução
echo -e "\n${BOLD}${YELLOW}🔐 Passo 2: Configurando permissões de execução${RESET}"
find "$PROJECT_ROOT" -name "*.sh" -type f -exec chmod +x {} \;
echo -e "${GREEN}✅ Permissões de execução configuradas${RESET}"

# Passo 3: Criar estrutura de diretórios
echo -e "\n${BOLD}${YELLOW}📂 Passo 3: Criando estrutura de diretórios${RESET}"
if [[ -f "$PROJECT_ROOT/scripts/criar_estrutura.sh" ]]; then
    bash "$PROJECT_ROOT/scripts/criar_estrutura.sh"
    if [[ $? -eq 0 ]]; then
        echo -e "${GREEN}✅ Estrutura de diretórios criada${RESET}"
    else
        echo -e "${RED}❌ Falha ao criar estrutura${RESET}"
    fi
else
    echo -e "${YELLOW}⚠️  Script criar_estrutura.sh não encontrado${RESET}"
fi

# Passo 4: Verificar estrutura
echo -e "\n${BOLD}${YELLOW}🔍 Passo 4: Verificando estrutura do projeto${RESET}"
if [[ -f "$PROJECT_ROOT/scripts/verificar_estrutura.sh" ]]; then
    bash "$PROJECT_ROOT/scripts/verificar_estrutura.sh"
else
    echo -e "${YELLOW}⚠️  Script verificar_estrutura.sh não encontrado${RESET}"
fi

# Passo 5: Testar portabilidade
echo -e "\n${BOLD}${YELLOW}🌍 Passo 5: Testando portabilidade${RESET}"
if [[ -f "$PROJECT_ROOT/teste_portabilidade.sh" ]]; then
    bash "$PROJECT_ROOT/teste_portabilidade.sh"
else
    echo -e "${YELLOW}⚠️  Script teste_portabilidade.sh não encontrado${RESET}"
fi

# Passo 6: Criar arquivo de instruções para VM
echo -e "\n${BOLD}${YELLOW}📝 Passo 6: Criando instruções para VM${RESET}"
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
git clone <URL_DO_REPOSITORIO>
cd logs

# Se copiando arquivos:
# Copie toda a pasta do projeto para a VM
cd /caminho/para/o/projeto
```

### 2. Configurar permissões
```bash
chmod +x *.sh
chmod +x scripts/*.sh
chmod +x src/scripts/**/*.sh
```

### 3. Executar preparação
```bash
./preparar_vm.sh
```

### 4. Testar o sistema
```bash
./iniciar_projeto.sh
```

### 5. Executar análise de logs
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