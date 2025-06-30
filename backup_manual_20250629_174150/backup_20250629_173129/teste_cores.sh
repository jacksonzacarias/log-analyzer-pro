#!/bin/bash

# Teste de cores ANSI
echo -e "\e[31m🔴 VERMELHO\e[0m"
echo -e "\e[32m🟢 VERDE\e[0m"
echo -e "\e[33m🟡 AMARELO\e[0m"
echo -e "\e[34m🔵 AZUL\e[0m"
echo -e "\e[35m🟣 MAGENTA\e[0m"
echo -e "\e[36m🔵 CYAN\e[0m"
echo -e "\e[1m\e[31m🔴 NEGRITO VERMELHO\e[0m"
echo -e "\e[5m\e[31m🔴 PISCANTE VERMELHO\e[0m"

# Teste de variáveis de cor
RED="\e[31m"
GREEN="\e[32m"
BOLD="\e[1m"
RESET="\e[0m"

echo -e "${RED}${BOLD}Teste com variáveis${RESET}"
echo -e "${GREEN}Teste verde${RESET}" 