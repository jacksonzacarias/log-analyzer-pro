#!/bin/bash

# Cores
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
BOLD="\e[1m"
RESET="\e[0m"

# Simula a função calculate_threat_weight
calculate_threat_weight() {
  local line="$1"
  local total_weight=0
  local detected_threats=()
  
  # Padrões de teste
  declare -A THREAT_PATTERNS=(
    ["Erro 403"]=7
    ["/admin/"]=7
    ["/server-status"]=7
  )
  
  for pattern in "${!THREAT_PATTERNS[@]}"; do
    if [[ "$line" =~ ${pattern} ]]; then
      local weight=${THREAT_PATTERNS[$pattern]}
      total_weight=$((total_weight + weight))
      detected_threats+=("$pattern (${weight}pts)")
    fi
  done
  
  local classification="INFO"
  if (( total_weight >= 10 )); then
    classification="CRÍTICO"
  elif (( total_weight >= 7 )); then
    classification="ALTO"
  fi
  
  echo "$classification|$total_weight|${detected_threats[*]}"
}

# Teste com linha que contém Erro 403 e /admin/
test_line="IP: 203.0.113.5 | user: anonymous | timestamp: 2024-01-01 10:00:00 | ação: Consulta: /admin/ HTTP/1.1 (Erro 403)"

echo "Teste da função calculate_threat_weight:"
echo "Linha: $test_line"
echo

threat_info=$(calculate_threat_weight "$test_line")
echo "Resultado: $threat_info"
echo

level=$(echo "$threat_info" | cut -d'|' -f1)
weight=$(echo "$threat_info" | cut -d'|' -f2)
threats=$(echo "$threat_info" | cut -d'|' -f3)

echo "Level: $level"
echo "Weight: $weight"
echo "Threats: '$threats'"
echo "Tamanho threats: ${#threats}"
echo

# Teste da extração
echo "Teste da extração:"
IFS=' ' read -ra threat_array <<< "$threats"
echo "Array size: ${#threat_array[@]}"
for i in "${!threat_array[@]}"; do
  echo "  [$i]: '${threat_array[$i]}'"
done
echo

for t in "${threat_array[@]}"; do
  echo "Processando: '$t'"
  if [[ "$t" =~ ^(.+)\ \(([0-9]+)pts\)$ ]]; then
    padrao="${BASH_REMATCH[1]}"
    pontos="${BASH_REMATCH[2]}"
    echo "  Padrão: '$padrao'"
    echo "  Pontos: '$pontos'"
  else
    echo "  Não matchou o padrão"
  fi
done 