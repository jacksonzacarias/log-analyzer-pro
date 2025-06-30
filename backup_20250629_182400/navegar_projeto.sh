#!/bin/bash

# ===================================================================================
# NAVEGADOR RÁPIDO DO PROJETO
# ===================================================================================

# Cores
GREEN="\e[32m"
CYAN="\e[36m"
BOLD="\e[1m"
RESET="\e[0m"

echo -e "${BOLD}${CYAN}🗂️  NAVEGADOR RÁPIDO DO PROJETO${RESET}"
echo -e "${BOLD}${CYAN}================================${RESET}"
echo ""

echo -e "${BOLD}📁 DIRETÓRIOS PRINCIPAIS:${RESET}"
echo -e "${GREEN}src/scripts/${RESET}     - Scripts principais do sistema"
echo -e "${GREEN}tests/${RESET}           - Scripts de teste"
echo -e "${GREEN}config/${RESET}          - Configurações"
echo -e "${GREEN}logs/${RESET}            - Todos os logs organizados"
echo -e "${GREEN}data/${RESET}            - Dados e CSV"
echo -e "${GREEN}results/${RESET}         - Resultados de testes"
echo -e "${GREEN}docs/${RESET}            - Documentação"
echo -e "${GREEN}payloads/${RESET}        - Payloads de ataque"
echo -e "${GREEN}system/${RESET}          - Logs do sistema"
echo ""

echo -e "${BOLD}🚀 COMANDOS RÁPIDOS:${RESET}"
echo -e "${GREEN}cd src/scripts/${RESET}  - Ir para scripts principais"
echo -e "${GREEN}cd tests/${RESET}        - Ir para testes"
echo -e "${GREEN}cd logs/realistic/${RESET} - Ver logs realistas"
echo -e "${GREEN}cd results/${RESET}      - Ver resultados"
echo -e "${GREEN}cd docs/${RESET}         - Ver documentação"
echo ""

echo -e "${BOLD}📋 COMANDOS ÚTEIS:${RESET}"
echo -e "${GREEN}ls -la src/scripts/${RESET}     - Listar scripts principais"
echo -e "${GREEN}ls -la logs/realistic/${RESET}  - Listar logs realistas"
echo -e "${GREEN}ls -la results/${RESET}         - Listar resultados"
echo -e "${GREEN}cat docs/README.md${RESET}      - Ver README"
echo ""
