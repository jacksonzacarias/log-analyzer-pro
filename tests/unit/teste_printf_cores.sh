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

echo "Teste 1: printf simples com cores"
printf "${RED}${BOLD}CRÍTICO${RESET}\n"

echo "Teste 2: printf com formatação de tabela"
printf "%-6s | %-15s | %-8s | %s\n" "Linha" "IP" "Nível" "Ação"
printf "${BLUE}%s${RESET}\n" "----------------------------------------"

echo "Teste 3: printf com cores na tabela"
printf "%-6s | %-15s | " "1" "192.168.1.1"
printf "${RED}${BOLD}${BLINK}%-8s${RESET} | ${BOLD}%s${RESET}\n" "CRÍTICO" "Ataque detectado"

echo "Teste 4: printf com variáveis de cor (PROBLEMA AQUI)"
level_style="${RED}${BOLD}${BLINK}"
printf "%-6s | %-15s | %s%-8s${RESET} | %s\n" "2" "10.0.0.1" "$level_style" "CRÍTICO" "Teste"

echo "Teste 5: printf com escape de cores"
printf "%-6s | %-15s | \e[31m\e[1m\e[5m%-8s\e[0m | %s\n" "3" "172.16.0.1" "CRÍTICO" "Teste direto"

echo "Teste 6: echo com cores vs printf"
echo -e "${RED}${BOLD}${BLINK}CRÍTICO${RESET} (echo)"
printf "${RED}${BOLD}${BLINK}CRÍTICO${RESET}\n"

echo "Teste 7: Solução - usar echo -e dentro do printf"
printf "%-6s | %-15s | " "4" "192.168.1.2"
echo -e "${RED}${BOLD}${BLINK}CRÍTICO${RESET} | Teste com echo" 