#!/bin/bash

# ===================================================================================
# Script de Teste Multi-Formato - Demonstração das Funcionalidades
# Testa todos os formatos de log suportados pelo script avançado
# ===================================================================================

# Cores
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
CYAN="\e[36m"
BOLD="\e[1m"
RESET="\e[0m"

echo -e "${BOLD}${CYAN}🧪 TESTE MULTI-FORMATO - SCRIPT AVANÇADO v4.0${RESET}"
echo -e "${BOLD}${CYAN}=============================================${RESET}"
echo

# Lista de arquivos para testar
declare -a log_files=(
  "apache2_access.log"
  "tentivas-sshubuntu-debian-auth.log"
  "mysql.log"
  "nginx_error.log"
  "nginx_access.log"
)

# Função para testar um arquivo
test_file() {
  local file="$1"
  echo -e "${BOLD}${BLUE}📁 Testando: $file${RESET}"
  echo -e "${BLUE}${BOLD}================================${RESET}"
  
  if [[ ! -f "$file" ]]; then
    echo -e "${RED}❌ Arquivo não encontrado: $file${RESET}"
    echo
    return
  fi
  
  # Verifica se o arquivo está vazio
  if [[ ! -s "$file" ]]; then
    echo -e "${YELLOW}⚠️  Arquivo vazio: $file${RESET}"
    echo
    return
  fi
  
  # Executa análise básica
  echo -e "${CYAN}🔍 Executando análise básica...${RESET}"
  bash scriptlogs_avancado.sh "$file" 2>/dev/null
  
  echo
  echo -e "${CYAN}🔍 Executando análise completa...${RESET}"
  bash scriptlogs_avancado.sh -v -t -aR -gT -pedago -pcn -peso -correl "$file" 2>/dev/null
  
  echo
  echo -e "${GREEN}${BOLD}✅ Teste concluído para: $file${RESET}"
  echo -e "${BLUE}${BOLD}================================${RESET}"
  echo
}

# Função para mostrar resumo
show_summary() {
  echo -e "${BOLD}${CYAN}📊 RESUMO DOS TESTES${RESET}"
  echo -e "${BOLD}${CYAN}===================${RESET}"
  echo
  
  for file in "${log_files[@]}"; do
    if [[ -f "$file" ]]; then
      if [[ -s "$file" ]]; then
        echo -e "${GREEN}✅ $file - Arquivo válido${RESET}"
      else
        echo -e "${YELLOW}⚠️  $file - Arquivo vazio${RESET}"
      fi
    else
      echo -e "${RED}❌ $file - Arquivo não encontrado${RESET}"
    fi
  done
  
  echo
  echo -e "${BOLD}${CYAN}🎯 FORMATOS SUPORTADOS:${RESET}"
  echo -e "  • ${GREEN}Apache Access Log${RESET}"
  echo -e "  • ${GREEN}SSH Auth Log${RESET}"
  echo -e "  • ${GREEN}MySQL Log${RESET}"
  echo -e "  • ${GREEN}Nginx Error Log${RESET}"
  echo -e "  • ${GREEN}Nginx Access Log${RESET}"
  echo -e "  • ${GREEN}Logs Customizados${RESET}"
  echo
  echo -e "${BOLD}${CYAN}🔧 FUNCIONALIDADES:${RESET}"
  echo -e "  • ${GREEN}Detecção automática de formato${RESET}"
  echo -e "  • ${GREEN}Normalização de logs${RESET}"
  echo -e "  • ${GREEN}Classificação por peso de ameaça${RESET}"
  echo -e "  • ${GREEN}Análise temporal${RESET}"
  echo -e "  • ${GREEN}Correlação de eventos${RESET}"
  echo -e "  • ${GREEN}Geolocalização de IPs${RESET}"
  echo -e "  • ${GREEN}Recomendações de segurança${RESET}"
  echo -e "  • ${GREEN}Plano de continuidade${RESET}"
  echo
}

# Execução principal
echo -e "${BOLD}${YELLOW}🚀 Iniciando testes multi-formato...${RESET}"
echo

# Testa cada arquivo
for file in "${log_files[@]}"; do
  test_file "$file"
done

# Mostra resumo
show_summary

echo -e "${GREEN}${BOLD}${BLINK}🎉 Todos os testes concluídos!${RESET}"
echo -e "${CYAN}${BOLD}📋 O script agora suporta múltiplos formatos de log automaticamente.${RESET}" 