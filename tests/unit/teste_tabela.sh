#!/bin/bash

# Cores
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
BOLD="\e[1m"
BLINK="\e[5m"
RESET="\e[0m"

echo -e "${CYAN}${BOLD}Teste de Tabela com Cores${RESET}"
echo -e "${CYAN}===========================${RESET}"

# Cabeçalho
printf "${BOLD}${CYAN}%-6s | %-15s | %-8s | %s${RESET}\n" "Linha" "IP" "Nível" "Ação"
printf "${BLUE}%s${RESET}\n" "----------------------------------------"

# Linhas de teste
printf "${BOLD}%-6s${RESET} | ${BOLD}%-15s${RESET} | " "1" "192.168.1.1"
printf "${RED}${BOLD}${BLINK}%-8s${RESET} | ${BOLD}%s${RESET}\n" "CRÍTICO" "Ataque detectado"

printf "${BOLD}%-6s${RESET} | ${BOLD}%-15s${RESET} | " "2" "10.0.0.1"
printf "${MAGENTA}${BOLD}%-8s${RESET} | ${BOLD}%s${RESET}\n" "ALTO" "Tentativa de login"

printf "${BOLD}%-6s${RESET} | ${BOLD}%-15s${RESET} | " "3" "172.16.0.1"
printf "${YELLOW}${BOLD}%-8s${RESET} | ${BOLD}%s${RESET}\n" "MÉDIO" "Porta escaneada"

printf "${BOLD}%-6s${RESET} | ${BOLD}%-15s${RESET} | " "4" "8.8.8.8"
printf "${GREEN}${BOLD}%-8s${RESET} | ${BOLD}%s${RESET}\n" "INFO" "Conexão normal" 