# 🧠 MELHORIAS DE LÓGICA PARA PONTUAÇÃO - SISTEMA DE ANÁLISE

## 🎯 **PROBLEMAS IDENTIFICADOS**

### **1. Pontuação Simplista Atual**
```
nikto/2.1.6 → ALTO (7pts) automaticamente
sqlmap/1.5 → ALTO (7pts) automaticamente
<script>alert → ALTO (7pts) automaticamente
```

**Problema:** Não considera contexto, frequência, padrão de comportamento

### **2. Falta de Análise Contextual**
- Uma tentativa isolada vs múltiplas tentativas
- Scanner conhecido vs comportamento suspeito
- Padrão de ataque vs tentativa aleatória

### **3. Ausência de Análise Temporal**
- Não analisa sequência de eventos
- Não detecta padrões de comportamento
- Não considera intervalos de tempo

---

## 🚀 **LÓGICAS PARA IMPLEMENTAR**

### **1. ANÁLISE DE FREQUÊNCIA**

#### **Scanner de Vulnerabilidades**
```bash
# Lógica atual: nikto = ALTO (7pts)
# Lógica proposta:
if [[ "$user_agent" =~ "nikto" ]]; then
    # Verificar frequência
    local attempts=$(grep "nikto" "$log_file" | wc -l)
    local time_span=$(calculate_time_span "nikto")
    
    if [[ $attempts -eq 1 ]]; then
        score=4  # MÉDIO - Tentativa isolada
    elif [[ $attempts -le 5 ]]; then
        score=7  # ALTO - Múltiplas tentativas
    else
        score=10 # CRÍTICO - Ataque massivo
    fi
fi
```

#### **SQL Injection**
```bash
# Lógica proposta:
if [[ "$payload" =~ "OR.*1=1" ]]; then
    # Verificar se é parte de um ataque coordenado
    local sql_attempts=$(grep -i "union\|select\|or.*1=1" "$log_file" | wc -l)
    local time_window=$(calculate_time_window "sql_injection")
    
    if [[ $sql_attempts -eq 1 ]]; then
        score=4  # MÉDIO - Tentativa isolada
    elif [[ $sql_attempts -le 10 ]]; then
        score=7  # ALTO - Múltiplas tentativas
    else
        score=10 # CRÍTICO - Ataque massivo
    fi
fi
```

### **2. ANÁLISE TEMPORAL**

#### **Detecção de Picos de Atividade**
```bash
# Analisar eventos por minuto/hora
analyze_temporal_patterns() {
    local log_file="$1"
    
    # Agrupar eventos por intervalo de tempo
    awk '{print $1, $2}' "$log_file" | \
    awk '{print $1" "$2}' | \
    sort | uniq -c | \
    awk '$1 > 10 {print "PICO: "$2" - "$1" eventos"}'
}
```

#### **Detecção de Sequências de Ataque**
```bash
# Detectar padrões como:
# 1. Reconhecimento (nikto)
# 2. Enumeração (dirb)
# 3. Exploit (sqlmap)
detect_attack_sequence() {
    local ip="$1"
    local time_window="$2"
    
    # Verificar sequência de ferramentas
    local tools_sequence=$(grep "$ip" "$log_file" | \
        grep -o "nikto\|sqlmap\|dirb\|gobuster" | \
        tr '\n' ' ')
    
    case "$tools_sequence" in
        *"nikto"*"sqlmap"*) score=$((score + 3)) ;; # Sequência suspeita
        *"nikto"*"dirb"*) score=$((score + 2)) ;;   # Reconhecimento + enumeração
        *) score=$((score + 0)) ;;                   # Sem padrão
    esac
}
```

### **3. ANÁLISE DE COMPORTAMENTO**

#### **Padrões de User-Agent**
```bash
# Classificar User-Agents por nível de ameaça
classify_user_agent() {
    local ua="$1"
    
    case "$ua" in
        *"nikto"*) echo "scanner_vulnerability" ;;
        *"sqlmap"*) echo "exploit_tool" ;;
        *"dirb"*) echo "enumeration_tool" ;;
        *"gobuster"*) echo "enumeration_tool" ;;
        *"curl"*) echo "manual_testing" ;;
        *"wget"*) echo "manual_testing" ;;
        *) echo "normal_browser" ;;
    esac
}
```

#### **Análise de IPs**
```bash
# Verificar se IP é conhecido como malicioso
check_ip_reputation() {
    local ip="$1"
    
    # Verificar em listas de IPs maliciosos
    if grep -q "$ip" "blacklist_ips.txt"; then
        score=$((score + 5))  # IP conhecido como malicioso
    fi
    
    # Verificar se é IP de teste (RFC5737)
    if [[ "$ip" =~ ^(192\.0\.2\.|198\.51\.100\.|203\.0\.113\.) ]]; then
        score=$((score - 2))  # IP de teste, reduz pontuação
    fi
}
```

### **4. ANÁLISE DE CONTEXTO**

#### **Análise de Endpoints**
```bash
# Classificar endpoints por sensibilidade
classify_endpoint() {
    local endpoint="$1"
    
    case "$endpoint" in
        */admin*) echo "critical" ;;
        */wp-admin*) echo "high" ;;
        */phpmyadmin*) echo "high" ;;
        */.env*) echo "critical" ;;
        */.git*) echo "high" ;;
        */api*) echo "medium" ;;
        *) echo "normal" ;;
    esac
}
```

#### **Análise de Resposta**
```bash
# Considerar código de resposta HTTP
analyze_response() {
    local status_code="$1"
    local response_size="$2"
    
    case "$status_code" in
        200) 
            if [[ $response_size -gt 1000 ]]; then
                score=$((score + 2))  # Resposta grande, possível sucesso
            fi
            ;;
        403) score=$((score - 1)) ;;  # Bloqueado, reduz pontuação
        404) score=$((score - 1)) ;;  # Não encontrado, reduz pontuação
        500) score=$((score + 1)) ;;  # Erro do servidor, pode indicar sucesso
    esac
}
```

---

## 📊 **SISTEMA DE PONTUAÇÃO PROPOSTO**

### **Fórmula Base**
```
SCORE_FINAL = SCORE_BASE + BONUS_FREQUENCIA + BONUS_TEMPORAL + BONUS_CONTEXTO + BONUS_COMPORTAMENTO
```

### **Exemplo Prático**
```
Evento: nikto scan em /admin/
- SCORE_BASE: 4 (scanner)
- BONUS_FREQUENCIA: +0 (primeira tentativa)
- BONUS_TEMPORAL: +0 (sem padrão)
- BONUS_CONTEXTO: +2 (endpoint crítico)
- BONUS_COMPORTAMENTO: +0 (comportamento normal)
- SCORE_FINAL: 6 (MÉDIO)
```

---

## 🎯 **IMPLEMENTAÇÃO GRADUAL**

### **FASE 1: Análise de Frequência**
- [ ] Contar tentativas por IP
- [ ] Implementar janelas de tempo
- [ ] Ajustar pontuação baseada na frequência

### **FASE 2: Análise Temporal**
- [ ] Detectar picos de atividade
- [ ] Identificar sequências de ataque
- [ ] Análise de padrões temporais

### **FASE 3: Análise de Comportamento**
- [ ] Classificação de User-Agents
- [ ] Verificação de reputação de IPs
- [ ] Análise de padrões de comportamento

### **FASE 4: Análise de Contexto**
- [ ] Classificação de endpoints
- [ ] Análise de respostas HTTP
- [ ] Correlação de eventos

---

## 📋 **TESTES NECESSÁRIOS**

### **1. Teste de Frequência**
```bash
# Criar log com múltiplas tentativas
echo "203.0.113.5 - - [29/Jun/2025:11:40:23 +0000] \"GET /admin/ HTTP/1.1\" 403 489 \"-\" \"nikto/2.1.6\"" > teste_frequencia.log
echo "203.0.113.5 - - [29/Jun/2025:11:40:25 +0000] \"GET /wp-admin/ HTTP/1.1\" 403 489 \"-\" \"nikto/2.1.6\"" >> teste_frequencia.log
echo "203.0.113.5 - - [29/Jun/2025:11:40:27 +0000] \"GET /phpmyadmin/ HTTP/1.1\" 403 489 \"-\" \"nikto/2.1.6\"" >> teste_frequencia.log
```

### **2. Teste de Sequência**
```bash
# Criar log com sequência de ferramentas
echo "203.0.113.5 - - [29/Jun/2025:11:40:23 +0000] \"GET /admin/ HTTP/1.1\" 403 489 \"-\" \"nikto/2.1.6\"" > teste_sequencia.log
echo "203.0.113.5 - - [29/Jun/2025:11:45:23 +0000] \"GET /admin/ HTTP/1.1\" 403 489 \"-\" \"dirb/2.22\"" >> teste_sequencia.log
echo "203.0.113.5 - - [29/Jun/2025:11:50:23 +0000] \"GET /admin/ HTTP/1.1\" 403 489 \"-\" \"sqlmap/1.5\"" >> teste_sequencia.log
```

---

*Documentação criada para implementação futura - Jackson Savoldi - ACADe-TI 2025* 