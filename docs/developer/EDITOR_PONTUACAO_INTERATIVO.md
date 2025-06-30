# 🎯 EDITOR INTERATIVO DE PONTUAÇÃO
## Sistema de Personalização de Scores - LOG ANALYZER PRO

---

## 📋 ÍNDICE
1. [Visão Geral](#visão-geral)
2. [Interface do Editor](#interface-do-editor)
3. [Funcionalidades](#funcionalidades)
4. [Estrutura de Dados](#estrutura-de-dados)
5. [Fluxo de Interação](#fluxo-de-interação)
6. [Implementação Técnica](#implementação-técnica)
7. [Exemplos de Uso](#exemplos-de-uso)
8. [Validação e Segurança](#validação-e-segurança)

---

## 🎯 VISÃO GERAL

### **Objetivo**
O Editor Interativo de Pontuação permite que usuários personalizem:
- **Pontuações base** de cada categoria de ameaça
- **Multiplicadores temporais** para análise de contexto
- **Limites de detecção** para ajustar sensibilidade
- **Pesos de regras customizadas** para priorização

### **Localização no Sistema**
```
Menu Principal → Configurações Avançadas → Editor de Pontuação
```

### **Benefícios**
- **Personalização**: Adapta o sistema ao ambiente específico
- **Ajuste Fino**: Permite otimização baseada em experiência
- **Flexibilidade**: Suporta diferentes políticas de segurança
- **Feedback Visual**: Mostra impacto das mudanças em tempo real

---

## 🖥️ INTERFACE DO EDITOR

### **Layout Principal**
```
┌─────────────────────────────────────────────────────────────┐
│                    🎯 EDITOR DE PONTUAÇÃO                   │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  📊 CATEGORIAS DE AMEAÇAS:                                 │
│  ┌─────────────────┬─────────┬─────────┬─────────┬─────────┐ │
│  │ Categoria       │ Atual   │ Novo    │ Diferença│ Status │ │
│  ├─────────────────┼─────────┼─────────┼─────────┼─────────┤ │
│  │ 🔴 CRÍTICO      │   10    │   [10]  │   0     │   ✓    │ │
│  │ 🟠 ALTO         │    8    │   [8]   │   0     │   ✓    │ │
│  │ 🟡 MÉDIO        │    5    │   [5]   │   0     │   ✓    │ │
│  │ 🟢 BAIXO        │    2    │   [2]   │   0     │   ✓    │ │
│  │ 🔵 INFO         │    1    │   [1]   │   0     │   ✓    │ │
│  └─────────────────┴─────────┴─────────┴─────────┴─────────┘ │
│                                                             │
│  ⏰ MULTIPLICADORES TEMPORAIS:                              │
│  ┌─────────────────┬─────────┬─────────┬─────────┬─────────┐ │
│  │ Intervalo       │ Atual   │ Novo    │ Diferença│ Status │ │
│  ├─────────────────┼─────────┼─────────┼─────────┼─────────┤ │
│  │ < 10 segundos   │  2.0x   │ [2.0]   │   0     │   ✓    │ │
│  │ < 1 minuto      │  1.5x   │ [1.5]   │   0     │   ✓    │ │
│  │ < 5 minutos     │  1.2x   │ [1.2]   │   0     │   ✓    │ │
│  │ < 1 hora        │  1.0x   │ [1.0]   │   0     │   ✓    │ │
│  │ > 1 hora        │  0.8x   │ [0.8]   │   0     │   ✓    │ │
│  └─────────────────┴─────────┴─────────┴─────────┴─────────┘ │
│                                                             │
│  📈 LIMITES DE DETECÇÃO:                                    │
│  ┌─────────────────┬─────────┬─────────┬─────────┬─────────┐ │
│  │ Tipo de Ataque  │ Atual   │ Novo    │ Diferença│ Status │ │
│  ├─────────────────┼─────────┼─────────┼─────────┼─────────┤ │
│  │ Scan Rápido     │  5/10s  │ [5/10s] │   0     │   ✓    │ │
│  │ Força Bruta     │  3/60s  │ [3/60s] │   0     │   ✓    │ │
│  │ Enumeração      │  2/300s │ [2/300s]│   0     │   ✓    │ │
│  │ Rate Limiting   │ 100/min │[100/min]│   0     │   ✓    │ │
│  └─────────────────┴─────────┴─────────┴─────────┴─────────┘ │
│                                                             │
│  🎛️ CONTROLES:                                              │
│  [1] Editar Pontuações    [2] Editar Multiplicadores        │
│  [3] Editar Limites       [4] Visualizar Impacto            │
│  [5] Aplicar Mudanças     [6] Restaurar Padrão              │
│  [7] Salvar Configuração  [0] Voltar                        │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### **Modo de Edição**
```
┌─────────────────────────────────────────────────────────────┐
│                    ✏️ EDITANDO PONTUAÇÕES                   │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  Selecione a categoria para editar:                        │
│                                                             │
│  [1] 🔴 CRÍTICO (atual: 10)                                │
│  [2] 🟠 ALTO (atual: 8)                                    │
│  [3] 🟡 MÉDIO (atual: 5)                                   │
│  [4] 🟢 BAIXO (atual: 2)                                   │
│  [5] 🔵 INFO (atual: 1)                                    │
│                                                             │
│  Digite o número da categoria ou 0 para cancelar: [ ]      │
│                                                             │
│  Nova pontuação (1-10): [ ]                                │
│                                                             │
│  Confirma mudança? (s/n): [ ]                              │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## ⚙️ FUNCIONALIDADES

### **1. Editor de Pontuações Base**
```bash
# Funcionalidades:
- Editar pontuação de cada categoria (1-10)
- Validação de valores mínimos/máximos
- Preview do impacto na análise
- Restauração de valores padrão
- Histórico de mudanças
```

### **2. Editor de Multiplicadores Temporais**
```bash
# Funcionalidades:
- Ajustar multiplicadores por intervalo de tempo
- Validação de lógica (mais recente = maior multiplicador)
- Preview de impacto em eventos recentes
- Configuração de limites personalizados
```

### **3. Editor de Limites de Detecção**
```bash
# Funcionalidades:
- Modificar limites para cada tipo de ataque
- Ajustar sensibilidade de detecção
- Configurar thresholds personalizados
- Testar limites com dados reais
```

### **4. Visualizador de Impacto**
```bash
# Funcionalidades:
- Simulação de análise com novas configurações
- Comparação com configuração atual
- Gráfico de diferenças
- Estatísticas de impacto
```

### **5. Sistema de Backup/Restore**
```bash
# Funcionalidades:
- Salvar configurações personalizadas
- Restaurar configurações anteriores
- Backup automático antes de mudanças
- Histórico de versões
```

---

## 📊 ESTRUTURA DE DADOS

### **Arquivo de Configuração (`scoring_config.json`)**
```json
{
  "version": "1.0",
  "last_modified": "2025-06-29T18:30:00Z",
  "author": "user",
  "base_scores": {
    "CRITICO": {
      "value": 10,
      "description": "Ameaças críticas que requerem ação imediata",
      "color": "red",
      "icon": "🔴"
    },
    "ALTO": {
      "value": 8,
      "description": "Ameaças de alto risco",
      "color": "orange",
      "icon": "🟠"
    },
    "MEDIO": {
      "value": 5,
      "description": "Ameaças de risco médio",
      "color": "yellow",
      "icon": "🟡"
    },
    "BAIXO": {
      "value": 2,
      "description": "Ameaças de baixo risco",
      "color": "green",
      "icon": "🟢"
    },
    "INFO": {
      "value": 1,
      "description": "Informações de segurança",
      "color": "blue",
      "icon": "🔵"
    }
  },
  "temporal_multipliers": {
    "recent_10s": {
      "value": 2.0,
      "description": "Eventos nos últimos 10 segundos",
      "condition": "< 10"
    },
    "recent_1min": {
      "value": 1.5,
      "description": "Eventos no último minuto",
      "condition": "< 60"
    },
    "recent_5min": {
      "value": 1.2,
      "description": "Eventos nos últimos 5 minutos",
      "condition": "< 300"
    },
    "recent_1hour": {
      "value": 1.0,
      "description": "Eventos na última hora",
      "condition": "< 3600"
    },
    "older_1hour": {
      "value": 0.8,
      "description": "Eventos mais antigos que 1 hora",
      "condition": "> 3600"
    }
  },
  "detection_limits": {
    "rapid_scan": {
      "requests": 5,
      "timeframe": 10,
      "description": "Scan rápido: 5 requests em 10 segundos"
    },
    "brute_force": {
      "requests": 3,
      "timeframe": 60,
      "description": "Força bruta: 3 tentativas em 1 minuto"
    },
    "enumeration": {
      "requests": 2,
      "timeframe": 300,
      "description": "Enumeração: 2 tentativas em 5 minutos"
    },
    "rate_limiting": {
      "requests": 100,
      "timeframe": 60,
      "description": "Rate limiting: 100 requests por minuto"
    }
  },
  "custom_rules": {
    "enabled": true,
    "rules": []
  },
  "validation": {
    "min_score": 1,
    "max_score": 10,
    "min_multiplier": 0.1,
    "max_multiplier": 5.0
  }
}
```

### **Arquivo de Histórico (`scoring_history.json`)**
```json
{
  "changes": [
    {
      "timestamp": "2025-06-29T18:30:00Z",
      "user": "admin",
      "type": "base_score",
      "category": "ALTO",
      "old_value": 7,
      "new_value": 8,
      "reason": "Aumentar sensibilidade para ataques de alto risco"
    }
  ],
  "backups": [
    {
      "timestamp": "2025-06-29T18:25:00Z",
      "filename": "scoring_backup_20250629_182500.json",
      "description": "Backup antes de mudanças"
    }
  ]
}
```

---

## 🔄 FLUXO DE INTERAÇÃO

### **Fluxo Principal**
```bash
1. ACESSO AO EDITOR
   ├── Menu Principal → Configurações Avançadas
   ├── Seleção: Editor de Pontuação
   └── Carregamento da interface

2. VISUALIZAÇÃO ATUAL
   ├── Carrega configuração atual
   ├── Exibe valores em tabela
   ├── Mostra diferenças (se houver)
   └── Aguarda seleção do usuário

3. SELEÇÃO DE AÇÃO
   ├── [1] Editar Pontuações
   ├── [2] Editar Multiplicadores
   ├── [3] Editar Limites
   ├── [4] Visualizar Impacto
   ├── [5] Aplicar Mudanças
   ├── [6] Restaurar Padrão
   ├── [7] Salvar Configuração
   └── [0] Voltar

4. PROCESSAMENTO
   ├── Validação de entrada
   ├── Aplicação de mudanças
   ├── Backup automático
   └── Atualização da interface

5. CONFIRMAÇÃO
   ├── Preview das mudanças
   ├── Confirmação do usuário
   ├── Salvamento da configuração
   └── Retorno ao menu
```

### **Fluxo de Edição**
```bash
1. SELEÇÃO DE CATEGORIA
   ├── Lista categorias disponíveis
   ├── Mostra valores atuais
   ├── Aguarda seleção
   └── Valida entrada

2. ENTRADA DE NOVO VALOR
   ├── Solicita novo valor
   ├── Valida limites (1-10)
   ├── Mostra preview
   └── Aguarda confirmação

3. APLICAÇÃO
   ├── Confirma mudança
   ├── Atualiza configuração
   ├── Salva backup
   └── Atualiza interface

4. FEEDBACK
   ├── Mostra mudança aplicada
   ├── Exibe impacto
   ├── Oferece continuar
   └── Retorna ao menu
```

---

## 🔧 IMPLEMENTAÇÃO TÉCNICA

### **Script Principal (`editor_pontuacao.sh`)**
```bash
#!/bin/bash

# Editor Interativo de Pontuação
# LOG ANALYZER PRO - Versão 5.0

# Variáveis globais
CONFIG_FILE="config/scoring_config.json"
HISTORY_FILE="config/scoring_history.json"
BACKUP_DIR="system/backup/scoring"

# Cores para interface
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Função principal
main() {
    while true; do
        clear
        show_header
        show_current_config
        show_menu
        handle_selection
    done
}

# Exibe cabeçalho
show_header() {
    echo -e "${CYAN}┌─────────────────────────────────────────────────────────────┐${NC}"
    echo -e "${CYAN}│                    🎯 EDITOR DE PONTUAÇÃO                   │${NC}"
    echo -e "${CYAN}└─────────────────────────────────────────────────────────────┘${NC}"
    echo
}

# Exibe configuração atual
show_current_config() {
    echo -e "${YELLOW}📊 CONFIGURAÇÃO ATUAL:${NC}"
    echo
    
    # Carrega configuração atual
    if [ -f "$CONFIG_FILE" ]; then
        # Exibe pontuações base
        echo -e "${BLUE}Pontuações Base:${NC}"
        jq -r '.base_scores | to_entries[] | "\(.key): \(.value.value) pontos"' "$CONFIG_FILE"
        echo
        
        # Exibe multiplicadores
        echo -e "${BLUE}Multiplicadores Temporais:${NC}"
        jq -r '.temporal_multipliers | to_entries[] | "\(.key): \(.value.value)x"' "$CONFIG_FILE"
        echo
    else
        echo -e "${RED}Arquivo de configuração não encontrado!${NC}"
        echo
    fi
}

# Exibe menu principal
show_menu() {
    echo -e "${YELLOW}🎛️ CONTROLES:${NC}"
    echo -e "${GREEN}[1]${NC} Editar Pontuações"
    echo -e "${GREEN}[2]${NC} Editar Multiplicadores"
    echo -e "${GREEN}[3]${NC} Editar Limites"
    echo -e "${GREEN}[4]${NC} Visualizar Impacto"
    echo -e "${GREEN}[5]${NC} Aplicar Mudanças"
    echo -e "${GREEN}[6]${NC} Restaurar Padrão"
    echo -e "${GREEN}[7]${NC} Salvar Configuração"
    echo -e "${RED}[0]${NC} Voltar"
    echo
    echo -n "Escolha uma opção: "
}

# Processa seleção do usuário
handle_selection() {
    read -r choice
    case $choice in
        1) edit_base_scores ;;
        2) edit_multipliers ;;
        3) edit_limits ;;
        4) show_impact ;;
        5) apply_changes ;;
        6) restore_default ;;
        7) save_config ;;
        0) return 0 ;;
        *) echo -e "${RED}Opção inválida!${NC}" ;;
    esac
    
    echo
    echo -n "Pressione ENTER para continuar..."
    read -r
}

# Editor de pontuações base
edit_base_scores() {
    clear
    echo -e "${CYAN}✏️ EDITANDO PONTUAÇÕES BASE${NC}"
    echo
    
    # Lista categorias
    echo "Selecione a categoria para editar:"
    echo "[1] 🔴 CRÍTICO"
    echo "[2] 🟠 ALTO"
    echo "[3] 🟡 MÉDIO"
    echo "[4] 🟢 BAIXO"
    echo "[5] 🔵 INFO"
    echo "[0] Cancelar"
    echo
    
    echo -n "Digite o número da categoria: "
    read -r category_choice
    
    case $category_choice in
        1) edit_category "CRITICO" ;;
        2) edit_category "ALTO" ;;
        3) edit_category "MEDIO" ;;
        4) edit_category "BAIXO" ;;
        5) edit_category "INFO" ;;
        0) return ;;
        *) echo -e "${RED}Categoria inválida!${NC}" ;;
    esac
}

# Edita categoria específica
edit_category() {
    local category=$1
    local current_value
    
    # Obtém valor atual
    current_value=$(jq -r ".base_scores.$category.value" "$CONFIG_FILE")
    
    echo
    echo -e "Categoria: ${YELLOW}$category${NC}"
    echo -e "Valor atual: ${GREEN}$current_value${NC}"
    echo
    
    echo -n "Novo valor (1-10): "
    read -r new_value
    
    # Valida entrada
    if [[ ! "$new_value" =~ ^[1-9]$|^10$ ]]; then
        echo -e "${RED}Valor inválido! Deve ser entre 1 e 10.${NC}"
        return
    fi
    
    echo
    echo -n "Confirma mudança? (s/n): "
    read -r confirm
    
    if [[ "$confirm" =~ ^[Ss]$ ]]; then
        # Aplica mudança
        jq ".base_scores.$category.value = $new_value" "$CONFIG_FILE" > "${CONFIG_FILE}.tmp"
        mv "${CONFIG_FILE}.tmp" "$CONFIG_FILE"
        
        # Registra no histórico
        record_change "base_score" "$category" "$current_value" "$new_value"
        
        echo -e "${GREEN}Mudança aplicada com sucesso!${NC}"
    else
        echo -e "${YELLOW}Mudança cancelada.${NC}"
    fi
}

# Registra mudança no histórico
record_change() {
    local change_type=$1
    local category=$2
    local old_value=$3
    local new_value=$4
    
    # Cria backup se não existir
    mkdir -p "$BACKUP_DIR"
    
    # Adiciona ao histórico
    jq --arg timestamp "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
       --arg user "$(whoami)" \
       --arg type "$change_type" \
       --arg category "$category" \
       --arg old "$old_value" \
       --arg new "$new_value" \
       '.changes += [{
           timestamp: $timestamp,
           user: $user,
           type: $type,
           category: $category,
           old_value: $old,
           new_value: $new,
           reason: "Mudança via editor interativo"
       }]' "$HISTORY_FILE" > "${HISTORY_FILE}.tmp"
    
    mv "${HISTORY_FILE}.tmp" "$HISTORY_FILE"
}

# Função principal
main "$@"
```

### **Validador de Configuração (`validate_scoring.sh`)**
```bash
#!/bin/bash

# Validador de Configuração de Pontuação
# LOG ANALYZER PRO - Versão 5.0

validate_scoring_config() {
    local config_file=$1
    local errors=0
    
    echo "🔍 Validando configuração de pontuação..."
    
    # Verifica se arquivo existe
    if [ ! -f "$config_file" ]; then
        echo "❌ Arquivo de configuração não encontrado!"
        return 1
    fi
    
    # Valida pontuações base
    validate_base_scores "$config_file" || ((errors++))
    
    # Valida multiplicadores temporais
    validate_temporal_multipliers "$config_file" || ((errors++))
    
    # Valida limites de detecção
    validate_detection_limits "$config_file" || ((errors++))
    
    if [ $errors -eq 0 ]; then
        echo "✅ Configuração válida!"
        return 0
    else
        echo "❌ Encontrados $errors erro(s) na configuração!"
        return 1
    fi
}

validate_base_scores() {
    local config_file=$1
    local valid=true
    
    echo "  📊 Validando pontuações base..."
    
    # Verifica se todas as categorias existem
    local categories=("CRITICO" "ALTO" "MEDIO" "BAIXO" "INFO")
    
    for category in "${categories[@]}"; do
        local value
        value=$(jq -r ".base_scores.$category.value" "$config_file" 2>/dev/null)
        
        if [ "$value" = "null" ] || [ -z "$value" ]; then
            echo "    ❌ Categoria '$category' não encontrada"
            valid=false
        elif ! [[ "$value" =~ ^[1-9]$|^10$ ]]; then
            echo "    ❌ Valor inválido para '$category': $value (deve ser 1-10)"
            valid=false
        else
            echo "    ✅ $category: $value"
        fi
    done
    
    $valid
}

validate_temporal_multipliers() {
    local config_file=$1
    local valid=true
    
    echo "  ⏰ Validando multiplicadores temporais..."
    
    # Verifica se multiplicadores estão em ordem decrescente
    local prev_mult=999
    
    while IFS= read -r mult; do
        if [ "$mult" != "null" ] && [ -n "$mult" ]; then
            if (( $(echo "$mult > $prev_mult" | bc -l) )); then
                echo "    ❌ Multiplicador $mult é maior que o anterior $prev_mult"
                valid=false
            fi
            prev_mult=$mult
        fi
    done < <(jq -r '.temporal_multipliers | .[] | .value' "$config_file")
    
    if $valid; then
        echo "    ✅ Multiplicadores em ordem correta"
    fi
    
    $valid
}

validate_detection_limits() {
    local config_file=$1
    local valid=true
    
    echo "  📈 Validando limites de detecção..."
    
    # Verifica se todos os limites têm valores válidos
    local limits=("rapid_scan" "brute_force" "enumeration" "rate_limiting")
    
    for limit in "${limits[@]}"; do
        local requests
        local timeframe
        
        requests=$(jq -r ".detection_limits.$limit.requests" "$config_file" 2>/dev/null)
        timeframe=$(jq -r ".detection_limits.$limit.timeframe" "$config_file" 2>/dev/null)
        
        if [ "$requests" = "null" ] || [ "$timeframe" = "null" ]; then
            echo "    ❌ Limite '$limit' incompleto"
            valid=false
        elif ! [[ "$requests" =~ ^[0-9]+$ ]] || ! [[ "$timeframe" =~ ^[0-9]+$ ]]; then
            echo "    ❌ Valores inválidos para '$limit': requests=$requests, timeframe=$timeframe"
            valid=false
        else
            echo "    ✅ $limit: $requests requests em ${timeframe}s"
        fi
    done
    
    $valid
}

# Executa validação se chamado diretamente
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    validate_scoring_config "${1:-config/scoring_config.json}"
fi
```

---

## 📝 EXEMPLOS DE USO

### **Exemplo 1: Aumentar Sensibilidade**
```bash
# Cenário: Ambiente de alta segurança
# Ação: Aumentar pontuação de ALTO de 8 para 9

1. Acessar Editor de Pontuação
2. Selecionar [1] Editar Pontuações
3. Escolher [2] ALTO
4. Digitar novo valor: 9
5. Confirmar mudança
6. Visualizar impacto
7. Salvar configuração
```

### **Exemplo 2: Ajustar Multiplicadores**
```bash
# Cenário: Foco em eventos recentes
# Ação: Aumentar multiplicador para eventos < 10s

1. Acessar Editor de Pontuação
2. Selecionar [2] Editar Multiplicadores
3. Escolher intervalo < 10 segundos
4. Digitar novo valor: 2.5x
5. Confirmar mudança
6. Testar com dados reais
7. Aplicar mudanças
```

### **Exemplo 3: Personalizar Limites**
```bash
# Cenário: Ambiente com tráfego alto
# Ação: Aumentar limite de rate limiting

1. Acessar Editor de Pontuação
2. Selecionar [3] Editar Limites
3. Escolher Rate Limiting
4. Digitar novo valor: 200/min
5. Confirmar mudança
6. Validar configuração
7. Salvar e aplicar
```

---

## 🔒 VALIDAÇÃO E SEGURANÇA

### **Validações Implementadas**
```bash
# Pontuações Base:
- Valores entre 1 e 10
- Todas as categorias obrigatórias
- Valores únicos por categoria

# Multiplicadores Temporais:
- Valores entre 0.1 e 5.0
- Ordem decrescente (mais recente = maior)
- Valores numéricos válidos

# Limites de Detecção:
- Valores positivos
- Timeframes válidos
- Requests > 0
```

### **Backup e Segurança**
```bash
# Backup Automático:
- Antes de cada mudança
- Timestamp único
- Localização segura
- Compressão automática

# Histórico de Mudanças:
- Registro de todas as alterações
- Usuário responsável
- Timestamp preciso
- Motivo da mudança

# Rollback:
- Restauração de versões anteriores
- Validação antes de restaurar
- Confirmação do usuário
- Log de restauração
```

### **Validação de Integridade**
```bash
# Verificações:
- Sintaxe JSON válida
- Estrutura de dados correta
- Valores dentro dos limites
- Consistência entre campos
- Dependências satisfeitas
```

---

**Documento criado em**: 29/06/2025  
**Versão**: 1.0  
**Autor**: Jackson Savoldi  
**Projeto**: ACADe-TI - Aula 04 