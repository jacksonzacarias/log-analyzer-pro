#!/bin/bash

# Teste da lógica de extração
threats="Erro 403 (7pts) /admin/ (7pts)"

echo "String original: '$threats'"
echo

# Abordagem mais simples: extrair cada padrão com sed
ameacas_formatadas=""

# Extrai o primeiro padrão
padrao1=$(echo "$threats" | sed -n 's/^\([^(]*\) ([0-9]*pts).*/\1/p')
pontos1=$(echo "$threats" | sed -n 's/^[^(]* (\([0-9]*\)pts).*/\1/p')

echo "Primeiro: padrão='$padrao1', pontos='$pontos1'"

if [[ -n "$padrao1" && -n "$pontos1" ]]; then
  ameacas_formatadas="${padrao1} : ${pontos1}pts"
fi

# Extrai o segundo padrão (se existir)
resto=$(echo "$threats" | sed 's/^[^(]* ([0-9]*pts) //')
echo "Resto: '$resto'"

if [[ -n "$resto" ]]; then
  padrao2=$(echo "$resto" | sed -n 's/^\([^(]*\) ([0-9]*pts).*/\1/p')
  pontos2=$(echo "$resto" | sed -n 's/^[^(]* (\([0-9]*\)pts).*/\1/p')
  
  echo "Segundo: padrão='$padrao2', pontos='$pontos2'"
  
  if [[ -n "$padrao2" && -n "$pontos2" ]]; then
    ameacas_formatadas="${ameacas_formatadas} ${padrao2} : ${pontos2}pts"
  fi
fi

echo
echo "Resultado final: $ameacas_formatadas" 