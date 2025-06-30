# ⚙️ SISTEMA DE REGRAS CUSTOMIZÁVEIS
## Motor de Regras Inteligente - LOG ANALYZER PRO

---

## 📋 ÍNDICE
1. [Visão Geral](#visão-geral)
2. [Estrutura de Regras](#estrutura-de-regras)
3. [Tipos de Regras](#tipos-de-regras)
4. [Motor de Regras](#motor-de-regras)
5. [Interface de Criação](#interface-de-criação)
6. [Validação e Testes](#validação-e-testes)
7. [Exemplos Práticos](#exemplos-práticos)
8. [Implementação Técnica](#implementação-técnica)

---

## 🎯 VISÃO GERAL

### **Objetivo**
O Sistema de Regras Customizáveis permite:
- **Criação de regras personalizadas** para detecção específica
- **Aprendizado contínuo** com novos padrões de ataque
- **Flexibilidade total** para diferentes ambientes
- **Validação automática** de regras antes da aplicação
- **Integração seamless** com o sistema principal

### **Princípios de Design**
1. **Modularidade**: Regras independentes e reutilizáveis
2. **Flexibilidade**: Suporte a múltiplos formatos e lógicas
3. **Validação**: Verificação automática de consistência
4. **Performance**: Execução otimizada de regras
5. **Extensibilidade**: Fácil adição de novos tipos de regra

---

## 📊 ESTRUTURA DE REGRAS

### **Formato JSON Padrão**
```json
{
  "rule_id": "rapid_scan_detection_v1",
  "rule_name": "Rapid Port Scan Detection",
  "version": "1.0",
  "author": "system",
  "created_date": "2025-06-29T18:30:00Z",
  "last_modified": "2025-06-29T18:30:00Z",
  "category": "scan_detection",
  "priority": "high",
  "enabled": true,
  "description": "Detecta scans rápidos de portas com alta frequência",
  "tags": ["scan", "automated", "network", "port"],
  "conditions": {
    "same_ip_requests": {
      "operator": ">",
      "value": 5,
      "description": "Mais de 5 requests do mesmo IP"
    },
    "time_interval": {
      "operator": "<",
      "value": 10,
      "description": "Em menos de 10 segundos"
    },
    "target_pattern": {
      "operator": "matches",
      "value": "port_scan",
      "description": "Padrão de scan de portas"
    },
    "port_range": {
      "operator": "in_range",
      "value": "1-1024",
      "description": "Portas bem conhecidas"
    }
  },
  "scoring": {
    "base_score": 8,
    "category": "ALTO",
    "multiplier": 1.5,
    "max_score": 10,
    "bonus_conditions": {
      "rapid_fire": {
        "condition": "requests_per_second > 2",
        "bonus": 1
      },
      "large_range": {
        "condition": "port_range_size > 100",
        "bonus": 1
      }
    }
  },
  "actions": {
    "immediate": [
      "log_event",
      "increment_counter",
      "flag_ip"
    ],
    "threshold": [
      {
        "condition": "score >= 9",
        "actions": ["block_ip", "send_alert"]
      },
      {
        "condition": "score >= 7",
        "actions": ["rate_limit", "log_detailed"]
      }
    ]
  },
  "metadata": {
    "references": ["CVE-2023-1234", "MITRE ATT&CK T1046"],
    "false_positive_rate": 0.02,
    "detection_rate": 0.95,
    "performance_impact": "low"
  },
  "validation": {
    "required_fields": ["source_ip", "timestamp", "target_port"],
    "data_types": {
      "source_ip": "ipv4",
      "timestamp": "datetime",
      "target_port": "integer"
    },
    "constraints": {
      "port_range": "1-65535",
      "time_window": "1-3600"
    }
  }
}
```

### **Estrutura de Condições**
```json
{
  "conditions": {
    "field_name": {
      "operator": "comparison_operator",
      "value": "comparison_value",
      "description": "Human readable description",
      "optional": {
        "case_sensitive": true,
        "regex": false,
        "aggregation": "count|sum|avg|max|min"
      }
    }
  }
}
```

### **Operadores Suportados**
```bash
# Operadores de Comparação:
- "==" : Igual a
- "!=" : Diferente de
- ">"  : Maior que
- ">=" : Maior ou igual a
- "<"  : Menor que
- "<=" : Menor ou igual a
- "in" : Contido em lista
- "not_in" : Não contido em lista
- "matches" : Corresponde a regex
- "contains" : Contém substring
- "starts_with" : Começa com
- "ends_with" : Termina com
- "exists" : Campo existe
- "not_exists" : Campo não existe

# Operadores Lógicos:
- "AND" : Todas as condições devem ser verdadeiras
- "OR"  : Pelo menos uma condição deve ser verdadeira
- "NOT" : Inverte o resultado da condição
- "XOR" : Exatamente uma condição deve ser verdadeira
```

---

## 🔧 TIPOS DE REGRAS

### **1. Regras de Detecção de Scan**
```json
{
  "rule_id": "scan_detection_v1",
  "category": "scan_detection",
  "conditions": {
    "scan_type": {
      "operator": "in",
      "value": ["port_scan", "service_scan", "vulnerability_scan"]
    },
    "scan_speed": {
      "operator": ">",
      "value": 5,
      "description": "Mais de 5 requests por segundo"
    },
    "scan_range": {
      "operator": ">",
      "value": 10,
      "description": "Mais de 10 alvos diferentes"
    }
  },
  "scoring": {
    "base_score": 7,
    "category": "ALTO",
    "multiplier": 1.2
  }
}
```

### **2. Regras de Força Bruta**
```json
{
  "rule_id": "brute_force_detection_v1",
  "category": "brute_force",
  "conditions": {
    "failed_attempts": {
      "operator": ">=",
      "value": 3,
      "description": "3 ou mais tentativas falhadas"
    },
    "time_window": {
      "operator": "<",
      "value": 300,
      "description": "Em menos de 5 minutos"
    },
    "target_service": {
      "operator": "in",
      "value": ["ssh", "ftp", "http", "mysql"]
    },
    "same_credentials": {
      "operator": "==",
      "value": true,
      "description": "Tentando as mesmas credenciais"
    }
  },
  "scoring": {
    "base_score": 9,
    "category": "CRÍTICO",
    "multiplier": 1.5
  }
}
```

### **3. Regras de Enumeração**
```json
{
  "rule_id": "enumeration_detection_v1",
  "category": "enumeration",
  "conditions": {
    "unique_targets": {
      "operator": ">",
      "value": 5,
      "description": "Mais de 5 alvos únicos"
    },
    "enumeration_type": {
      "operator": "in",
      "value": ["user_enum", "dir_enum", "service_enum"]
    },
    "pattern_consistency": {
      "operator": ">",
      "value": 0.8,
      "description": "80% de consistência no padrão"
    }
  },
  "scoring": {
    "base_score": 6,
    "category": "MÉDIO",
    "multiplier": 1.1
  }
}
```

### **4. Regras de Rate Limiting**
```json
{
  "rule_id": "rate_limiting_v1",
  "category": "rate_limiting",
  "conditions": {
    "requests_per_minute": {
      "operator": ">",
      "value": 100,
      "description": "Mais de 100 requests por minuto"
    },
    "burst_requests": {
      "operator": ">",
      "value": 20,
      "description": "Mais de 20 requests em 10 segundos"
    },
    "request_pattern": {
      "operator": "matches",
      "value": "automated_pattern",
      "description": "Padrão de requisição automatizada"
    }
  },
  "scoring": {
    "base_score": 5,
    "category": "MÉDIO",
    "multiplier": 1.0
  }
}
```

### **5. Regras de Anomalia**
```json
{
  "rule_id": "anomaly_detection_v1",
  "category": "anomaly",
  "conditions": {
    "baseline_deviation": {
      "operator": ">",
      "value": 2.5,
      "description": "Desvio de 2.5x da linha base"
    },
    "time_anomaly": {
      "operator": "==",
      "value": true,
      "description": "Atividade em horário não usual"
    },
    "behavior_change": {
      "operator": ">",
      "value": 0.7,
      "description": "70% de mudança no comportamento"
    }
  },
  "scoring": {
    "base_score": 4,
    "category": "BAIXO",
    "multiplier": 1.3
  }
}
```

---

## ⚙️ MOTOR DE REGRAS

### **Arquitetura do Motor**
```bash
# Componentes do Motor:
1. Rule Parser      - Interpreta regras JSON
2. Condition Engine - Avalia condições
3. Scoring Engine   - Calcula pontuações
4. Action Engine    - Executa ações
5. Validation Engine - Valida dados
6. Performance Monitor - Monitora performance
```

### **Fluxo de Execução**
```bash
1. CARREGAMENTO DE REGRAS
   ├── Lê arquivos de regras
   ├── Valida sintaxe JSON
   ├── Verifica dependências
   └── Compila para execução

2. PROCESSAMENTO DE EVENTOS
   ├── Recebe evento de log
   ├── Extrai campos relevantes
   ├── Aplica regras ativas
   └── Calcula scores

3. AVALIAÇÃO DE CONDIÇÕES
   ├── Verifica cada condição
   ├── Aplica operadores lógicos
   ├── Calcula agregações
   └── Determina match

4. CÁLCULO DE SCORE
   ├── Score base da regra
   ├── Aplica multiplicadores
   ├── Adiciona bônus
   └── Limita ao máximo

5. EXECUÇÃO DE AÇÕES
   ├── Ações imediatas
   ├── Verifica thresholds
   ├── Executa ações condicionais
   └── Registra resultados
```

### **Script do Motor (`rule_engine.sh`)**
```bash
#!/bin/bash

# Motor de Regras Customizáveis
# LOG ANALYZER PRO - Versão 5.0

# Variáveis globais
RULES_DIR="src/modules/logic/custom_rules"
RULES_CONFIG="config/rules_config.json"
CACHE_DIR="system/cache/rules"
LOG_FILE="system/logs/rule_engine.log"

# Cores para interface
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Inicializa motor de regras
init_rule_engine() {
    echo "🔧 Inicializando Motor de Regras..."
    
    # Cria diretórios necessários
    mkdir -p "$RULES_DIR"
    mkdir -p "$CACHE_DIR"
    mkdir -p "$(dirname "$LOG_FILE")"
    
    # Carrega configuração
    if [ ! -f "$RULES_CONFIG" ]; then
        create_default_rules_config
    fi
    
    # Compila regras
    compile_rules
    
    echo -e "${GREEN}✅ Motor de Regras inicializado!${NC}"
}

# Cria configuração padrão de regras
create_default_rules_config() {
    cat > "$RULES_CONFIG" << 'EOF'
{
  "engine_version": "1.0",
  "max_rules_per_category": 50,
  "max_conditions_per_rule": 10,
  "performance_threshold": 100,
  "cache_enabled": true,
  "cache_ttl": 3600,
  "validation_strict": true,
  "default_scoring": {
    "min_score": 1,
    "max_score": 10,
    "default_multiplier": 1.0
  },
  "categories": {
    "scan_detection": {
      "enabled": true,
      "priority": "high",
      "description": "Detecção de scans de rede"
    },
    "brute_force": {
      "enabled": true,
      "priority": "high",
      "description": "Detecção de força bruta"
    },
    "enumeration": {
      "enabled": true,
      "priority": "medium",
      "description": "Detecção de enumeração"
    },
    "rate_limiting": {
      "enabled": true,
      "priority": "medium",
      "description": "Limitação de taxa"
    },
    "anomaly": {
      "enabled": true,
      "priority": "low",
      "description": "Detecção de anomalias"
    }
  }
}
EOF
}

# Compila regras para execução
compile_rules() {
    echo "📦 Compilando regras..."
    
    # Limpa cache
    rm -f "$CACHE_DIR"/*
    
    # Processa cada arquivo de regra
    for rule_file in "$RULES_DIR"/*.json; do
        if [ -f "$rule_file" ]; then
            compile_single_rule "$rule_file"
        fi
    done
    
    echo -e "${GREEN}✅ Compilação concluída!${NC}"
}

# Compila regra individual
compile_single_rule() {
    local rule_file=$1
    local rule_id
    
    # Extrai ID da regra
    rule_id=$(jq -r '.rule_id' "$rule_file" 2>/dev/null)
    
    if [ "$rule_id" != "null" ] && [ -n "$rule_id" ]; then
        # Valida regra
        if validate_rule "$rule_file"; then
            # Compila para formato executável
            compile_to_executable "$rule_file" "$rule_id"
            echo "  ✅ $rule_id"
        else
            echo "  ❌ $rule_id (validação falhou)"
        fi
    fi
}

# Valida regra
validate_rule() {
    local rule_file=$1
    local errors=0
    
    # Verifica sintaxe JSON
    if ! jq empty "$rule_file" 2>/dev/null; then
        echo "    ❌ Sintaxe JSON inválida"
        return 1
    fi
    
    # Verifica campos obrigatórios
    local required_fields=("rule_id" "rule_name" "category" "conditions" "scoring")
    
    for field in "${required_fields[@]}"; do
        if ! jq -e ".$field" "$rule_file" >/dev/null 2>&1; then
            echo "    ❌ Campo obrigatório '$field' ausente"
            ((errors++))
        fi
    done
    
    # Verifica condições
    validate_conditions "$rule_file" || ((errors++))
    
    # Verifica scoring
    validate_scoring "$rule_file" || ((errors++))
    
    return $errors
}

# Valida condições da regra
validate_conditions() {
    local rule_file=$1
    local valid=true
    
    # Verifica se há pelo menos uma condição
    local condition_count
    condition_count=$(jq '.conditions | length' "$rule_file")
    
    if [ "$condition_count" -eq 0 ]; then
        echo "    ❌ Pelo menos uma condição é obrigatória"
        valid=false
    fi
    
    # Verifica operadores válidos
    local valid_operators=("==" "!=" ">" ">=" "<" "<=" "in" "not_in" "matches" "contains")
    
    while IFS= read -r operator; do
        if [[ ! " ${valid_operators[@]} " =~ " ${operator} " ]]; then
            echo "    ❌ Operador inválido: $operator"
            valid=false
        fi
    done < <(jq -r '.conditions | .[] | .operator' "$rule_file" 2>/dev/null)
    
    $valid
}

# Valida scoring da regra
validate_scoring() {
    local rule_file=$1
    local valid=true
    
    # Verifica score base
    local base_score
    base_score=$(jq -r '.scoring.base_score' "$rule_file" 2>/dev/null)
    
    if [ "$base_score" = "null" ] || [ -z "$base_score" ]; then
        echo "    ❌ Score base obrigatório"
        valid=false
    elif ! [[ "$base_score" =~ ^[1-9]$|^10$ ]]; then
        echo "    ❌ Score base deve ser entre 1 e 10"
        valid=false
    fi
    
    # Verifica categoria
    local category
    category=$(jq -r '.scoring.category' "$rule_file" 2>/dev/null)
    local valid_categories=("CRITICO" "ALTO" "MEDIO" "BAIXO" "INFO")
    
    if [[ ! " ${valid_categories[@]} " =~ " ${category} " ]]; then
        echo "    ❌ Categoria inválida: $category"
        valid=false
    fi
    
    $valid
}

# Compila regra para formato executável
compile_to_executable() {
    local rule_file=$1
    local rule_id=$2
    local compiled_file="$CACHE_DIR/${rule_id}.sh"
    
    # Cria script executável
    cat > "$compiled_file" << 'EOF'
#!/bin/bash

# Regra compilada: RULE_ID
# Gerada automaticamente pelo Motor de Regras

RULE_ID="RULE_ID_PLACEHOLDER"
RULE_NAME="RULE_NAME_PLACEHOLDER"
CATEGORY="CATEGORY_PLACEHOLDER"
BASE_SCORE=BASE_SCORE_PLACEHOLDER
MULTIPLIER=MULTIPLIER_PLACEHOLDER

# Função principal de avaliação
evaluate_rule() {
    local event_data="$1"
    local score=0
    
    # Avalia condições
    if evaluate_conditions "$event_data"; then
        score=$BASE_SCORE
        
        # Aplica multiplicadores
        score=$(echo "scale=1; $score * $MULTIPLIER" | bc)
        
        # Limita ao máximo
        if (( $(echo "$score > 10" | bc -l) )); then
            score=10
        fi
        
        echo "$score"
        return 0
    else
        echo "0"
        return 1
    fi
}

# Avalia condições da regra
evaluate_conditions() {
    local event_data="$1"
    
    # CONDIÇÕES_COMPILADAS_PLACEHOLDER
    
    return 0
}

# Retorna metadados da regra
get_rule_metadata() {
    echo "ID: $RULE_ID"
    echo "Nome: $RULE_NAME"
    echo "Categoria: $CATEGORY"
    echo "Score Base: $BASE_SCORE"
    echo "Multiplicador: $MULTIPLIER"
}
EOF
    
    # Substitui placeholders
    local rule_name category base_score multiplier
    rule_name=$(jq -r '.rule_name' "$rule_file")
    category=$(jq -r '.scoring.category' "$rule_file")
    base_score=$(jq -r '.scoring.base_score' "$rule_file")
    multiplier=$(jq -r '.scoring.multiplier // 1.0' "$rule_file")
    
    sed -i "s/RULE_ID_PLACEHOLDER/$rule_id/g" "$compiled_file"
    sed -i "s/RULE_NAME_PLACEHOLDER/$rule_name/g" "$compiled_file"
    sed -i "s/CATEGORY_PLACEHOLDER/$category/g" "$compiled_file"
    sed -i "s/BASE_SCORE_PLACEHOLDER/$base_score/g" "$compiled_file"
    sed -i "s/MULTIPLIER_PLACEHOLDER/$multiplier/g" "$compiled_file"
    
    # Compila condições
    compile_conditions "$rule_file" "$compiled_file"
    
    # Torna executável
    chmod +x "$compiled_file"
}

# Compila condições para código executável
compile_conditions() {
    local rule_file=$1
    local compiled_file=$2
    
    # Gera código para cada condição
    local condition_code=""
    
    while IFS= read -r condition; do
        local field operator value
        field=$(echo "$condition" | jq -r '.field')
        operator=$(echo "$condition" | jq -r '.operator')
        value=$(echo "$condition" | jq -r '.value')
        
        case $operator in
            "==")
                condition_code="${condition_code}    if [[ \"\$$field\" != \"$value\" ]]; then return 1; fi\n"
                ;;
            "!=")
                condition_code="${condition_code}    if [[ \"\$$field\" == \"$value\" ]]; then return 1; fi\n"
                ;;
            ">")
                condition_code="${condition_code}    if (( \$$field <= $value )); then return 1; fi\n"
                ;;
            ">=")
                condition_code="${condition_code}    if (( \$$field < $value )); then return 1; fi\n"
                ;;
            "<")
                condition_code="${condition_code}    if (( \$$field >= $value )); then return 1; fi\n"
                ;;
            "<=")
                condition_code="${condition_code}    if (( \$$field > $value )); then return 1; fi\n"
                ;;
            "matches")
                condition_code="${condition_code}    if ! echo \"\$$field\" | grep -q \"$value\"; then return 1; fi\n"
                ;;
            "contains")
                condition_code="${condition_code}    if ! echo \"\$$field\" | grep -q \"$value\"; then return 1; fi\n"
                ;;
        esac
    done < <(jq -c '.conditions | to_entries[] | {field: .key, operator: .value.operator, value: .value.value}' "$rule_file")
    
    # Substitui placeholder
    sed -i "s/CONDIÇÕES_COMPILADAS_PLACEHOLDER/$condition_code/g" "$compiled_file"
}

# Executa regras em um evento
execute_rules() {
    local event_data="$1"
    local results=()
    
    echo "🔍 Executando regras no evento..."
    
    # Executa cada regra compilada
    for rule_file in "$CACHE_DIR"/*.sh; do
        if [ -f "$rule_file" ]; then
            local rule_id score
            rule_id=$(basename "$rule_file" .sh)
            
            # Executa regra
            score=$("$rule_file" evaluate_rule "$event_data")
            
            if [ "$score" != "0" ]; then
                results+=("$rule_id:$score")
                echo "  ✅ $rule_id: $score"
            fi
        fi
    done
    
    # Retorna resultados
    printf '%s\n' "${results[@]}"
}

# Lista regras disponíveis
list_rules() {
    echo "📋 Regras Disponíveis:"
    echo
    
    for rule_file in "$RULES_DIR"/*.json; do
        if [ -f "$rule_file" ]; then
            local rule_id rule_name category enabled
            rule_id=$(jq -r '.rule_id' "$rule_file")
            rule_name=$(jq -r '.rule_name' "$rule_file")
            category=$(jq -r '.category' "$rule_file")
            enabled=$(jq -r '.enabled // true' "$rule_file")
            
            local status_icon
            if [ "$enabled" = "true" ]; then
                status_icon="✅"
            else
                status_icon="❌"
            fi
            
            echo "  $status_icon $rule_id ($category)"
            echo "     Nome: $rule_name"
            echo
        fi
    done
}

# Função principal
main() {
    case "${1:-help}" in
        "init")
            init_rule_engine
            ;;
        "compile")
            compile_rules
            ;;
        "execute")
            execute_rules "$2"
            ;;
        "list")
            list_rules
            ;;
        "validate")
            validate_rule "$2"
            ;;
        "help"|*)
            echo "Uso: $0 {init|compile|execute|list|validate}"
            echo
            echo "Comandos:"
            echo "  init     - Inicializa motor de regras"
            echo "  compile  - Compila regras"
            echo "  execute  - Executa regras em evento"
            echo "  list     - Lista regras disponíveis"
            echo "  validate - Valida regra específica"
            ;;
    esac
}

# Executa se chamado diretamente
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
```

---

## 🖥️ INTERFACE DE CRIAÇÃO

### **Criador de Regras Interativo**
```bash
#!/bin/bash

# Criador de Regras Interativo
# LOG ANALYZER PRO - Versão 5.0

create_rule_interactive() {
    clear
    echo -e "${CYAN}🎯 CRIADOR DE REGRAS INTERATIVO${NC}"
    echo
    
    # Coleta informações básicas
    echo -n "ID da regra (ex: my_custom_rule_v1): "
    read -r rule_id
    
    echo -n "Nome da regra: "
    read -r rule_name
    
    echo -n "Descrição: "
    read -r description
    
    # Seleciona categoria
    echo "Categorias disponíveis:"
    echo "[1] scan_detection"
    echo "[2] brute_force"
    echo "[3] enumeration"
    echo "[4] rate_limiting"
    echo "[5] anomaly"
    echo "[6] custom"
    echo
    echo -n "Escolha a categoria: "
    read -r category_choice
    
    case $category_choice in
        1) category="scan_detection" ;;
        2) category="brute_force" ;;
        3) category="enumeration" ;;
        4) category="rate_limiting" ;;
        5) category="anomaly" ;;
        6) category="custom" ;;
        *) category="custom" ;;
    esac
    
    # Define condições
    echo
    echo "Definindo condições..."
    local conditions="{}"
    
    while true; do
        echo
        echo -n "Adicionar condição? (s/n): "
        read -r add_condition
        
        if [[ "$add_condition" =~ ^[Nn]$ ]]; then
            break
        fi
        
        conditions=$(add_condition_interactive "$conditions")
    done
    
    # Define scoring
    echo
    echo "Definindo pontuação..."
    echo -n "Score base (1-10): "
    read -r base_score
    
    echo -n "Multiplicador (0.1-5.0): "
    read -r multiplier
    
    # Cria arquivo de regra
    create_rule_file "$rule_id" "$rule_name" "$description" "$category" "$conditions" "$base_score" "$multiplier"
    
    echo -e "${GREEN}✅ Regra criada com sucesso!${NC}"
}

add_condition_interactive() {
    local conditions=$1
    
    echo
    echo "Campos disponíveis:"
    echo "[1] source_ip"
    echo "[2] target_port"
    echo "[3] timestamp"
    echo "[4] user_agent"
    echo "[5] request_method"
    echo "[6] response_code"
    echo "[7] custom_field"
    echo
    echo -n "Escolha o campo: "
    read -r field_choice
    
    case $field_choice in
        1) field="source_ip" ;;
        2) field="target_port" ;;
        3) field="timestamp" ;;
        4) field="user_agent" ;;
        5) field="request_method" ;;
        6) field="response_code" ;;
        7) 
            echo -n "Nome do campo customizado: "
            read -r field
            ;;
        *) field="custom_field" ;;
    esac
    
    echo
    echo "Operadores disponíveis:"
    echo "[1] == (igual a)"
    echo "[2] != (diferente de)"
    echo "[3] > (maior que)"
    echo "[4] >= (maior ou igual)"
    echo "[5] < (menor que)"
    echo "[6] <= (menor ou igual)"
    echo "[7] matches (corresponde a regex)"
    echo "[8] contains (contém)"
    echo
    echo -n "Escolha o operador: "
    read -r operator_choice
    
    case $operator_choice in
        1) operator="==" ;;
        2) operator="!=" ;;
        3) operator=">" ;;
        4) operator=">=" ;;
        5) operator="<" ;;
        6) operator="<=" ;;
        7) operator="matches" ;;
        8) operator="contains" ;;
        *) operator="==" ;;
    esac
    
    echo -n "Valor para comparação: "
    read -r value
    
    echo -n "Descrição da condição: "
    read -r condition_description
    
    # Adiciona condição ao JSON
    local new_condition
    new_condition=$(jq --arg field "$field" \
                      --arg operator "$operator" \
                      --arg value "$value" \
                      --arg desc "$condition_description" \
                      '. + {($field): {"operator": $operator, "value": $value, "description": $desc}}' \
                      <<< "$conditions")
    
    echo "$new_condition"
}

create_rule_file() {
    local rule_id=$1
    local rule_name=$2
    local description=$3
    local category=$4
    local conditions=$5
    local base_score=$6
    local multiplier=$7
    
    local rule_file="$RULES_DIR/${rule_id}.json"
    
    # Cria JSON da regra
    jq --arg id "$rule_id" \
       --arg name "$rule_name" \
       --arg desc "$description" \
       --arg cat "$category" \
       --argjson cond "$conditions" \
       --argjson score "$base_score" \
       --argjson mult "$multiplier" \
       --arg now "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
       '{
           rule_id: $id,
           rule_name: $name,
           version: "1.0",
           author: "user",
           created_date: $now,
           last_modified: $now,
           category: $cat,
           priority: "medium",
           enabled: true,
           description: $desc,
           tags: ["custom", "user_created"],
           conditions: $cond,
           scoring: {
               base_score: $score,
               category: "MEDIO",
               multiplier: $mult,
               max_score: 10
           },
           actions: {
               immediate: ["log_event", "increment_counter"],
               threshold: []
           },
           metadata: {
               references: [],
               false_positive_rate: 0.05,
               detection_rate: 0.85,
               performance_impact: "low"
           }
       }' > "$rule_file"
    
    echo "Regra salva em: $rule_file"
}
```

---

## ✅ VALIDAÇÃO E TESTES

### **Sistema de Validação**
```bash
# Validações Implementadas:
1. Sintaxe JSON
2. Campos obrigatórios
3. Tipos de dados
4. Operadores válidos
5. Valores dentro dos limites
6. Dependências entre campos
7. Performance estimada
8. Conflitos com regras existentes
```

### **Testes Automatizados**
```bash
# Tipos de Testes:
1. Teste de Sintaxe
   - Validação JSON
   - Campos obrigatórios
   - Tipos corretos

2. Teste de Lógica
   - Condições válidas
   - Operadores suportados
   - Valores realistas

3. Teste de Performance
   - Tempo de execução
   - Uso de memória
   - Impacto no sistema

4. Teste de Integração
   - Compatibilidade com motor
   - Interação com outras regras
   - Produção de resultados corretos
```

### **Script de Testes (`test_rules.sh`)**
```bash
#!/bin/bash

# Testador de Regras
# LOG ANALYZER PRO - Versão 5.0

test_rule() {
    local rule_file=$1
    local test_data_file=$2
    
    echo "🧪 Testando regra: $(basename "$rule_file")"
    
    # Valida regra
    if ! validate_rule "$rule_file"; then
        echo "❌ Validação falhou"
        return 1
    fi
    
    # Testa com dados de exemplo
    if [ -f "$test_data_file" ]; then
        while IFS= read -r test_event; do
            local result
            result=$(execute_rule_on_event "$rule_file" "$test_event")
            echo "  Evento: $test_event -> Score: $result"
        done < "$test_data_file"
    fi
    
    echo "✅ Teste concluído"
}

execute_rule_on_event() {
    local rule_file=$1
    local event_data=$2
    
    # Simula execução da regra
    local score=0
    
    # Extrai condições
    while IFS= read -r condition; do
        local field operator value
        field=$(echo "$condition" | jq -r '.field')
        operator=$(echo "$condition" | jq -r '.operator')
        value=$(echo "$condition" | jq -r '.value')
        
        # Simula avaliação
        if evaluate_test_condition "$event_data" "$field" "$operator" "$value"; then
            score=$(jq -r '.scoring.base_score' "$rule_file")
        fi
    done < <(jq -c '.conditions | to_entries[] | {field: .key, operator: .value.operator, value: .value.value}' "$rule_file")
    
    echo "$score"
}

evaluate_test_condition() {
    local event_data=$1
    local field=$2
    local operator=$3
    local value=$4
    
    # Simula extração do campo do evento
    local field_value
    field_value=$(echo "$event_data" | jq -r ".$field // empty")
    
    case $operator in
        "==")
            [[ "$field_value" == "$value" ]]
            ;;
        "!=")
            [[ "$field_value" != "$value" ]]
            ;;
        ">")
            (( field_value > value ))
            ;;
        ">=")
            (( field_value >= value ))
            ;;
        "<")
            (( field_value < value ))
            ;;
        "<=")
            (( field_value <= value ))
            ;;
        "matches")
            echo "$field_value" | grep -q "$value"
            ;;
        "contains")
            echo "$field_value" | grep -q "$value"
            ;;
        *)
            return 1
            ;;
    esac
}
```

---

## 📝 EXEMPLOS PRÁTICOS

### **Exemplo 1: Detecção de Scan Rápido**
```json
{
  "rule_id": "rapid_scan_v1",
  "rule_name": "Rapid Port Scan Detection",
  "category": "scan_detection",
  "conditions": {
    "requests_per_second": {
      "operator": ">",
      "value": 5,
      "description": "Mais de 5 requests por segundo"
    },
    "unique_ports": {
      "operator": ">",
      "value": 10,
      "description": "Mais de 10 portas únicas"
    },
    "time_window": {
      "operator": "<",
      "value": 60,
      "description": "Em menos de 1 minuto"
    }
  },
  "scoring": {
    "base_score": 8,
    "category": "ALTO",
    "multiplier": 1.5
  }
}
```

### **Exemplo 2: Detecção de Força Bruta SSH**
```json
{
  "rule_id": "ssh_brute_force_v1",
  "rule_name": "SSH Brute Force Detection",
  "category": "brute_force",
  "conditions": {
    "service": {
      "operator": "==",
      "value": "ssh",
      "description": "Serviço SSH"
    },
    "failed_attempts": {
      "operator": ">=",
      "value": 3,
      "description": "3 ou mais tentativas falhadas"
    },
    "time_window": {
      "operator": "<",
      "value": 300,
      "description": "Em menos de 5 minutos"
    },
    "same_username": {
      "operator": "==",
      "value": true,
      "description": "Mesmo usuário"
    }
  },
  "scoring": {
    "base_score": 9,
    "category": "CRÍTICO",
    "multiplier": 1.8
  }
}
```

### **Exemplo 3: Detecção de Enumeração de Usuários**
```json
{
  "rule_id": "user_enumeration_v1",
  "rule_name": "User Enumeration Detection",
  "category": "enumeration",
  "conditions": {
    "unique_usernames": {
      "operator": ">",
      "value": 5,
      "description": "Mais de 5 usuários únicos"
    },
    "pattern_consistency": {
      "operator": ">",
      "value": 0.8,
      "description": "80% de consistência no padrão"
    },
    "time_interval": {
      "operator": "<",
      "value": 600,
      "description": "Em menos de 10 minutos"
    }
  },
  "scoring": {
    "base_score": 6,
    "category": "MÉDIO",
    "multiplier": 1.2
  }
}
```

---

**Documento criado em**: 29/06/2025  
**Versão**: 1.0  
**Autor**: Jackson Savoldi  
**Projeto**: ACADe-TI - Aula 04 