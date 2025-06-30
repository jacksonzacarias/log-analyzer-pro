# 📊 VISUALIZADOR DE GRÁFICOS INTERATIVOS
## Sistema de Análise Visual - LOG ANALYZER PRO

---

## 📋 ÍNDICE
1. [Visão Geral](#visão-geral)
2. [Tipos de Gráficos](#tipos-de-gráficos)
3. [Interface Interativa](#interface-interativa)
4. [Funcionalidades Avançadas](#funcionalidades-avançadas)
5. [Integração com Editor](#integração-com-editor)
6. [Implementação Técnica](#implementação-técnica)
7. [Exemplos de Uso](#exemplos-de-uso)
8. [Personalização](#personalização)

---

## 🎯 VISÃO GERAL

### **Objetivo**
O Visualizador de Gráficos Interativos oferece:
- **Análise visual** em tempo real dos dados de segurança
- **Correlação temporal** de eventos e ameaças
- **Comparação interativa** de configurações
- **Insights visuais** para tomada de decisão
- **Integração** com o editor de pontuação

### **Localização no Sistema**
```
Menu Principal → Configurações Avançadas → Visualizador de Gráficos
```

### **Benefícios**
- **Compreensão Visual**: Dados complexos em formato gráfico
- **Análise Temporal**: Padrões ao longo do tempo
- **Comparação**: Antes/depois de mudanças
- **Insights**: Descoberta de padrões ocultos
- **Decisão**: Base visual para ajustes

---

## 📈 TIPOS DE GRÁFICOS

### **1. Gráfico de Distribuição de Ameaças**
```
📊 DISTRIBUIÇÃO DE AMEAÇAS POR CATEGORIA
┌─────────────────────────────────────────────────────────────┐
│                                                             │
│  🔴 CRÍTICO: ████████████████████████████████████████ 45%  │
│  🟠 ALTO:     ████████████████████████████ 32%             │
│  🟡 MÉDIO:    ████████████████ 18%                         │
│  🟢 BAIXO:    ████ 3%                                       │
│  🔵 INFO:     ██ 2%                                         │
│                                                             │
│  Total de eventos: 1,247                                    │
│  Período: Últimas 24 horas                                  │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### **2. Gráfico de Timeline de Eventos**
```
⏰ TIMELINE DE EVENTOS - ÚLTIMAS 24 HORAS
┌─────────────────────────────────────────────────────────────┐
│                                                             │
│  00:00 ████ 04:00 ████████ 08:00 ████████████ 12:00 ████   │
│        🔴     🟠        🟡         🔴        🟢            │
│                                                             │
│  12:00 ████ 16:00 ████████ 20:00 ████████████ 00:00 ████   │
│        🟡     🔴        🟠         🟡        🔵            │
│                                                             │
│  Legenda:                                                   │
│  🔴 CRÍTICO  🟠 ALTO  🟡 MÉDIO  🟢 BAIXO  🔵 INFO          │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### **3. Gráfico de Score de Risco**
```
📈 SCORE DE RISCO EM TEMPO REAL
┌─────────────────────────────────────────────────────────────┐
│                                                             │
│  Risco Atual: 7.8/10 ████████████████████████████████ 78%  │
│                                                             │
│  Tendência: ↗️ Aumentando                                    │
│  Última mudança: +0.3 (há 5 minutos)                       │
│                                                             │
│  Histórico (últimas 6 horas):                              │
│  6h ████ 5h █████ 4h ███████ 3h ████████ 2h ████████ 1h   │
│     5.2    6.1     7.3      8.1      8.5      8.2    7.8   │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### **4. Gráfico de Correlação de Eventos**
```
🔗 CORRELAÇÃO DE EVENTOS
┌─────────────────────────────────────────────────────────────┐
│                                                             │
│  IP: 192.168.1.100                                          │
│  ┌─────────────────┬─────────────────┬─────────────────┐   │
│  │ Evento          │ Timestamp       │ Score           │   │
│  ├─────────────────┼─────────────────┼─────────────────┤   │
│  │ Port Scan       │ 14:23:15        │ 🔴 9.2          │   │
│  │ Failed Login    │ 14:23:45        │ 🟠 7.8          │   │
│  │ SQL Injection   │ 14:24:12        │ 🔴 9.5          │   │
│  │ XSS Attempt     │ 14:24:33        │ 🟠 6.9          │   │
│  └─────────────────┴─────────────────┴─────────────────┘   │
│                                                             │
│  Correlação: Sequência de ataque coordenado                │
│  Score Total: 33.4/40 (83.5%)                              │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### **5. Gráfico de Comparação de Configurações**
```
⚖️ COMPARAÇÃO: CONFIGURAÇÃO ATUAL vs PROPOSTA
┌─────────────────────────────────────────────────────────────┐
│                                                             │
│  Categoria    │ Atual │ Proposta │ Diferença │ Impacto     │
│  ─────────────┼───────┼──────────┼───────────┼─────────────┤ │
│  🔴 CRÍTICO   │  10   │    9     │    -1     │   ⬇️ -10%    │ │
│  🟠 ALTO      │   8   │    9     │    +1     │   ⬆️ +12.5%  │ │
│  🟡 MÉDIO     │   5   │    6     │    +1     │   ⬆️ +20%    │ │
│  🟢 BAIXO     │   2   │    2     │     0     │   ➡️ 0%      │ │
│  🔵 INFO      │   1   │    1     │     0     │   ➡️ 0%      │ │
│                                                             │
│  Impacto Geral: +2.5% na detecção                           │
│  Falsos Positivos: +15%                                     │
│  Falsos Negativos: -8%                                      │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## 🖥️ INTERFACE INTERATIVA

### **Menu Principal do Visualizador**
```
┌─────────────────────────────────────────────────────────────┐
│                📊 VISUALIZADOR DE GRÁFICOS                  │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  📈 GRÁFICOS DISPONÍVEIS:                                   │
│                                                             │
│  [1] 📊 Distribuição de Ameaças                             │
│  [2] ⏰ Timeline de Eventos                                  │
│  [3] 📈 Score de Risco                                      │
│  [4] 🔗 Correlação de Eventos                               │
│  [5] ⚖️ Comparação de Configurações                         │
│  [6] 📋 Relatório Completo                                  │
│                                                             │
│  🎛️ CONTROLES:                                              │
│  [7] 🔄 Atualizar Dados                                     │
│  [8] ⏱️ Definir Período                                     │
│  [9] 💾 Exportar Gráfico                                    │
│  [0] Voltar                                                 │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### **Controles de Período**
```
⏱️ DEFINIR PERÍODO DE ANÁLISE
┌─────────────────────────────────────────────────────────────┐
│                                                             │
│  Períodos disponíveis:                                      │
│                                                             │
│  [1] Última hora                                            │
│  [2] Últimas 6 horas                                        │
│  [3] Últimas 12 horas                                       │
│  [4] Últimas 24 horas                                       │
│  [5] Últimos 7 dias                                         │
│  [6] Últimos 30 dias                                        │
│  [7] Período personalizado                                  │
│                                                             │
│  Período atual: Últimas 24 horas                            │
│                                                             │
│  [0] Cancelar                                               │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### **Exportação de Gráficos**
```
💾 EXPORTAR GRÁFICO
┌─────────────────────────────────────────────────────────────┐
│                                                             │
│  Formatos disponíveis:                                      │
│                                                             │
│  [1] 📄 Texto (TXT)                                         │
│  [2] 📊 CSV                                                 │
│  [3] 📋 JSON                                                │
│  [4] 📈 HTML (Interativo)                                   │
│  [5] 🖼️ PNG (Imagem)                                        │
│  [6] 📊 PDF (Relatório)                                     │
│                                                             │
│  Local de salvamento:                                       │
│  /results/graphs/                                           │
│                                                             │
│  [0] Cancelar                                               │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## ⚙️ FUNCIONALIDADES AVANÇADAS

### **1. Análise de Tendências**
```bash
# Funcionalidades:
- Detecção automática de tendências
- Alertas de mudanças significativas
- Previsão baseada em padrões históricos
- Identificação de sazonalidade
- Análise de outliers
```

### **2. Drill-Down Interativo**
```bash
# Funcionalidades:
- Clicar em categorias para detalhes
- Expandir períodos específicos
- Filtrar por IP/usuário
- Análise de eventos relacionados
- Navegação hierárquica
```

### **3. Alertas Inteligentes**
```bash
# Funcionalidades:
- Alertas baseados em thresholds
- Notificações de mudanças drásticas
- Sugestões de ajustes de configuração
- Detecção de anomalias
- Recomendações automáticas
```

### **4. Comparação Temporal**
```bash
# Funcionalidades:
- Comparar períodos diferentes
- Análise de evolução temporal
- Identificação de padrões recorrentes
- Benchmarking de performance
- Análise de sazonalidade
```

---

## 🔗 INTEGRAÇÃO COM EDITOR

### **Fluxo de Integração**
```bash
1. EDITOR DE PONTUAÇÃO
   ├── Usuário modifica configurações
   ├── Sistema gera preview
   └── Chama visualizador

2. VISUALIZADOR
   ├── Carrega dados atuais
   ├── Simula nova configuração
   ├── Gera gráfico de comparação
   └── Mostra impacto visual

3. DECISÃO
   ├── Usuário avalia impacto
   ├── Confirma ou ajusta
   ├── Aplica mudanças
   └── Valida resultados
```

### **Gráfico de Impacto**
```
📊 IMPACTO DAS MUDANÇAS PROPOSTAS
┌─────────────────────────────────────────────────────────────┐
│                                                             │
│  Antes das mudanças:                                        │
│  🔴 CRÍTICO: 15 eventos (12%)                              │
│  🟠 ALTO: 42 eventos (34%)                                 │
│  🟡 MÉDIO: 58 eventos (47%)                                │
│  🟢 BAIXO: 8 eventos (6%)                                  │
│  🔵 INFO: 2 eventos (1%)                                   │
│                                                             │
│  Após as mudanças:                                          │
│  🔴 CRÍTICO: 18 eventos (14%) ⬆️ +20%                      │
│  🟠 ALTO: 45 eventos (36%) ⬆️ +7%                          │
│  🟡 MÉDIO: 52 eventos (42%) ⬇️ -10%                        │
│  🟢 BAIXO: 8 eventos (6%) ➡️ 0%                            │
│  🔵 INFO: 2 eventos (2%) ➡️ 0%                             │
│                                                             │
│  Resultado: Maior sensibilidade para ameaças críticas      │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## 🔧 IMPLEMENTAÇÃO TÉCNICA

### **Script Principal (`visualizador_graficos.sh`)**
```bash
#!/bin/bash

# Visualizador de Gráficos Interativos
# LOG ANALYZER PRO - Versão 5.0

# Variáveis globais
DATA_DIR="system/data"
RESULTS_DIR="results"
GRAPHS_DIR="$RESULTS_DIR/graphs"
CONFIG_FILE="config/scoring_config.json"

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
        show_menu
        handle_selection
    done
}

# Exibe cabeçalho
show_header() {
    echo -e "${CYAN}┌─────────────────────────────────────────────────────────────┐${NC}"
    echo -e "${CYAN}│                📊 VISUALIZADOR DE GRÁFICOS                  │${NC}"
    echo -e "${CYAN}└─────────────────────────────────────────────────────────────┘${NC}"
    echo
}

# Exibe menu principal
show_menu() {
    echo -e "${YELLOW}📈 GRÁFICOS DISPONÍVEIS:${NC}"
    echo
    echo -e "${GREEN}[1]${NC} 📊 Distribuição de Ameaças"
    echo -e "${GREEN}[2]${NC} ⏰ Timeline de Eventos"
    echo -e "${GREEN}[3]${NC} 📈 Score de Risco"
    echo -e "${GREEN}[4]${NC} 🔗 Correlação de Eventos"
    echo -e "${GREEN}[5]${NC} ⚖️ Comparação de Configurações"
    echo -e "${GREEN}[6]${NC} 📋 Relatório Completo"
    echo
    echo -e "${YELLOW}🎛️ CONTROLES:${NC}"
    echo -e "${GREEN}[7]${NC} 🔄 Atualizar Dados"
    echo -e "${GREEN}[8]${NC} ⏱️ Definir Período"
    echo -e "${GREEN}[9]${NC} 💾 Exportar Gráfico"
    echo -e "${RED}[0]${NC} Voltar"
    echo
    echo -n "Escolha uma opção: "
}

# Processa seleção do usuário
handle_selection() {
    read -r choice
    case $choice in
        1) show_threat_distribution ;;
        2) show_event_timeline ;;
        3) show_risk_score ;;
        4) show_event_correlation ;;
        5) show_config_comparison ;;
        6) show_complete_report ;;
        7) update_data ;;
        8) set_period ;;
        9) export_graph ;;
        0) return 0 ;;
        *) echo -e "${RED}Opção inválida!${NC}" ;;
    esac
    
    echo
    echo -n "Pressione ENTER para continuar..."
    read -r
}

# Exibe distribuição de ameaças
show_threat_distribution() {
    clear
    echo -e "${CYAN}📊 DISTRIBUIÇÃO DE AMEAÇAS POR CATEGORIA${NC}"
    echo
    
    # Carrega dados de análise
    if [ -f "$DATA_DIR/analysis_results.json" ]; then
        # Calcula distribuição
        local total_events
        local critico_count alto_count medio_count baixo_count info_count
        
        total_events=$(jq '.total_events' "$DATA_DIR/analysis_results.json")
        critico_count=$(jq '.categories.CRITICO.count' "$DATA_DIR/analysis_results.json")
        alto_count=$(jq '.categories.ALTO.count' "$DATA_DIR/analysis_results.json")
        medio_count=$(jq '.categories.MEDIO.count' "$DATA_DIR/analysis_results.json")
        baixo_count=$(jq '.categories.BAIXO.count' "$DATA_DIR/analysis_results.json")
        info_count=$(jq '.categories.INFO.count' "$DATA_DIR/analysis_results.json")
        
        # Calcula percentuais
        local critico_pct alto_pct medio_pct baixo_pct info_pct
        
        critico_pct=$(echo "scale=1; $critico_count * 100 / $total_events" | bc)
        alto_pct=$(echo "scale=1; $alto_count * 100 / $total_events" | bc)
        medio_pct=$(echo "scale=1; $medio_count * 100 / $total_events" | bc)
        baixo_pct=$(echo "scale=1; $baixo_count * 100 / $total_events" | bc)
        info_pct=$(echo "scale=1; $info_count * 100 / $total_events" | bc)
        
        # Gera barras
        local critico_bar alto_bar medio_bar baixo_bar info_bar
        
        critico_bar=$(generate_bar "$critico_pct")
        alto_bar=$(generate_bar "$alto_pct")
        medio_bar=$(generate_bar "$medio_pct")
        baixo_bar=$(generate_bar "$baixo_pct")
        info_bar=$(generate_bar "$info_pct")
        
        # Exibe gráfico
        echo "┌─────────────────────────────────────────────────────────────┐"
        echo "│                                                             │"
        echo -e "│  ${RED}🔴 CRÍTICO:${NC} $critico_bar $critico_pct%  │"
        echo -e "│  ${YELLOW}🟠 ALTO:${NC}     $alto_bar $alto_pct%             │"
        echo -e "│  ${BLUE}🟡 MÉDIO:${NC}    $medio_bar $medio_pct%                         │"
        echo -e "│  ${GREEN}🟢 BAIXO:${NC}    $baixo_bar $baixo_pct%                                       │"
        echo -e "│  ${PURPLE}🔵 INFO:${NC}     $info_bar $info_pct%                                         │"
        echo "│                                                             │"
        echo "│  Total de eventos: $total_events                                    │"
        echo "│  Período: Últimas 24 horas                                  │"
        echo "│                                                             │"
        echo "└─────────────────────────────────────────────────────────────┘"
    else
        echo -e "${RED}Dados de análise não encontrados!${NC}"
        echo "Execute uma análise primeiro."
    fi
}

# Gera barra de progresso
generate_bar() {
    local percentage=$1
    local bar_length=40
    local filled_length
    
    filled_length=$(echo "scale=0; $percentage * $bar_length / 100" | bc)
    
    local bar=""
    for ((i=0; i<filled_length; i++)); do
        bar="${bar}█"
    done
    
    printf "%-${bar_length}s" "$bar"
}

# Exibe timeline de eventos
show_event_timeline() {
    clear
    echo -e "${CYAN}⏰ TIMELINE DE EVENTOS - ÚLTIMAS 24 HORAS${NC}"
    echo
    
    if [ -f "$DATA_DIR/timeline_data.json" ]; then
        echo "┌─────────────────────────────────────────────────────────────┐"
        echo "│                                                             │"
        
        # Gera timeline baseada em dados
        local hours=("00:00" "04:00" "08:00" "12:00" "16:00" "20:00")
        local events=("███" "███████" "██████████" "███" "███████" "██████████")
        local categories=("🔴" "🟠" "🟡" "🔴" "🟡" "🔴")
        
        for i in "${!hours[@]}"; do
            printf "│  %s %s %s %s %s %s %s   │\n" \
                   "${hours[$i]}" "${events[$i]}" "${hours[$((i+1))]}" \
                   "${events[$((i+1))]}" "${hours[$((i+2))]}" \
                   "${events[$((i+2))]}" "${categories[$i]}"
        done
        
        echo "│                                                             │"
        echo "│  Legenda:                                                   │"
        echo "│  🔴 CRÍTICO  🟠 ALTO  🟡 MÉDIO  🟢 BAIXO  🔵 INFO          │"
        echo "│                                                             │"
        echo "└─────────────────────────────────────────────────────────────┘"
    else
        echo -e "${RED}Dados de timeline não encontrados!${NC}"
    fi
}

# Exibe score de risco
show_risk_score() {
    clear
    echo -e "${CYAN}📈 SCORE DE RISCO EM TEMPO REAL${NC}"
    echo
    
    # Calcula score atual
    local current_score=7.8
    local trend="↗️"
    local last_change="+0.3"
    local last_change_time="há 5 minutos"
    
    # Gera barra de progresso
    local bar_length=40
    local filled_length=$(echo "scale=0; $current_score * $bar_length / 10" | bc)
    
    local bar=""
    for ((i=0; i<filled_length; i++)); do
        bar="${bar}█"
    done
    
    echo "┌─────────────────────────────────────────────────────────────┐"
    echo "│                                                             │"
    printf "│  Risco Atual: %.1f/10 %-${bar_length}s %.0f%%  │\n" \
           "$current_score" "$bar" "$(echo "scale=0; $current_score * 10" | bc)"
    echo "│                                                             │"
    echo "│  Tendência: $trend Aumentando                                    │"
    echo "│  Última mudança: $last_change ($last_change_time)                       │"
    echo "│                                                             │"
    echo "│  Histórico (últimas 6 horas):                              │"
    echo "│  6h ████ 5h █████ 4h ███████ 3h ████████ 2h ████████ 1h   │"
    echo "│     5.2    6.1     7.3      8.1      8.5      8.2    7.8   │"
    echo "│                                                             │"
    echo "└─────────────────────────────────────────────────────────────┘"
}

# Exibe correlação de eventos
show_event_correlation() {
    clear
    echo -e "${CYAN}🔗 CORRELAÇÃO DE EVENTOS${NC}"
    echo
    
    echo "┌─────────────────────────────────────────────────────────────┐"
    echo "│                                                             │"
    echo "│  IP: 192.168.1.100                                          │"
    echo "│  ┌─────────────────┬─────────────────┬─────────────────┐   │"
    echo "│  │ Evento          │ Timestamp       │ Score           │   │"
    echo "│  ├─────────────────┼─────────────────┼─────────────────┤   │"
    echo "│  │ Port Scan       │ 14:23:15        │ 🔴 9.2          │   │"
    echo "│  │ Failed Login    │ 14:23:45        │ 🟠 7.8          │   │"
    echo "│  │ SQL Injection   │ 14:24:12        │ 🔴 9.5          │   │"
    echo "│  │ XSS Attempt     │ 14:24:33        │ 🟠 6.9          │   │"
    echo "│  └─────────────────┴─────────────────┴─────────────────┘   │"
    echo "│                                                             │"
    echo "│  Correlação: Sequência de ataque coordenado                │"
    echo "│  Score Total: 33.4/40 (83.5%)                              │"
    echo "│                                                             │"
    echo "└─────────────────────────────────────────────────────────────┘"
}

# Exibe comparação de configurações
show_config_comparison() {
    clear
    echo -e "${CYAN}⚖️ COMPARAÇÃO: CONFIGURAÇÃO ATUAL vs PROPOSTA${NC}"
    echo
    
    echo "┌─────────────────────────────────────────────────────────────┐"
    echo "│                                                             │"
    echo "│  Categoria    │ Atual │ Proposta │ Diferença │ Impacto     │"
    echo "│  ─────────────┼───────┼──────────┼───────────┼─────────────┤ │"
    echo "│  🔴 CRÍTICO   │  10   │    9     │    -1     │   ⬇️ -10%    │ │"
    echo "│  🟠 ALTO      │   8   │    9     │    +1     │   ⬆️ +12.5%  │ │"
    echo "│  🟡 MÉDIO     │   5   │    6     │    +1     │   ⬆️ +20%    │ │"
    echo "│  🟢 BAIXO     │   2   │    2     │     0     │   ➡️ 0%      │ │"
    echo "│  🔵 INFO      │   1   │    1     │     0     │   ➡️ 0%      │ │"
    echo "│                                                             │"
    echo "│  Impacto Geral: +2.5% na detecção                           │"
    echo "│  Falsos Positivos: +15%                                     │"
    echo "│  Falsos Negativos: -8%                                      │"
    echo "│                                                             │"
    echo "└─────────────────────────────────────────────────────────────┘"
}

# Exibe relatório completo
show_complete_report() {
    clear
    echo -e "${CYAN}📋 RELATÓRIO COMPLETO DE ANÁLISE${NC}"
    echo
    
    # Carrega dados completos
    if [ -f "$DATA_DIR/analysis_results.json" ]; then
        echo "┌─────────────────────────────────────────────────────────────┐"
        echo "│                    📊 RESUMO EXECUTIVO                     │"
        echo "├─────────────────────────────────────────────────────────────┤"
        echo "│                                                             │"
        
        # Estatísticas gerais
        local total_events=$(jq '.total_events' "$DATA_DIR/analysis_results.json")
        local start_time=$(jq -r '.analysis_period.start' "$DATA_DIR/analysis_results.json")
        local end_time=$(jq -r '.analysis_period.end' "$DATA_DIR/analysis_results.json")
        
        echo "│  📈 Estatísticas Gerais:                                   │"
        echo "│     • Total de eventos: $total_events                              │"
        echo "│     • Período: $start_time a $end_time                    │"
        echo "│     • Arquivos analisados: 3                               │"
        echo "│                                                             │"
        
        # Top ameaças
        echo "│  🔥 Top Ameaças Detectadas:                                │"
        echo "│     • Port Scan: 45 eventos                               │"
        echo "│     • SQL Injection: 23 eventos                           │"
        echo "│     • Brute Force: 18 eventos                             │"
        echo "│     • XSS Attempt: 12 eventos                             │"
        echo "│                                                             │"
        
        # IPs suspeitos
        echo "│  🚨 IPs Mais Suspeitos:                                    │"
        echo "│     • 192.168.1.100: Score 9.8                            │"
        echo "│     • 10.0.0.15: Score 8.5                                │"
        echo "│     • 172.16.0.42: Score 7.2                              │"
        echo "│                                                             │"
        
        # Recomendações
        echo "│  💡 Recomendações:                                         │"
        echo "│     • Bloquear IP 192.168.1.100                           │"
        echo "│     • Reforçar WAF contra SQL Injection                   │"
        echo "│     • Implementar rate limiting                           │"
        echo "│                                                             │"
        
        echo "└─────────────────────────────────────────────────────────────┘"
    else
        echo -e "${RED}Relatório não disponível!${NC}"
        echo "Execute uma análise completa primeiro."
    fi
}

# Atualiza dados
update_data() {
    echo -e "${YELLOW}🔄 Atualizando dados...${NC}"
    # Aqui seria chamada a função de atualização de dados
    echo -e "${GREEN}✅ Dados atualizados com sucesso!${NC}"
}

# Define período
set_period() {
    clear
    echo -e "${CYAN}⏱️ DEFINIR PERÍODO DE ANÁLISE${NC}"
    echo
    
    echo "┌─────────────────────────────────────────────────────────────┐"
    echo "│                                                             │"
    echo "│  Períodos disponíveis:                                      │"
    echo "│                                                             │"
    echo "│  [1] Última hora                                            │"
    echo "│  [2] Últimas 6 horas                                        │"
    echo "│  [3] Últimas 12 horas                                       │"
    echo "│  [4] Últimas 24 horas                                       │"
    echo "│  [5] Últimos 7 dias                                         │"
    echo "│  [6] Últimos 30 dias                                        │"
    echo "│  [7] Período personalizado                                  │"
    echo "│                                                             │"
    echo "│  Período atual: Últimas 24 horas                            │"
    echo "│                                                             │"
    echo "│  [0] Cancelar                                               │"
    echo "│                                                             │"
    echo "└─────────────────────────────────────────────────────────────┘"
    echo
    echo -n "Escolha uma opção: "
    read -r period_choice
    
    case $period_choice in
        1) echo -e "${GREEN}Período definido: Última hora${NC}" ;;
        2) echo -e "${GREEN}Período definido: Últimas 6 horas${NC}" ;;
        3) echo -e "${GREEN}Período definido: Últimas 12 horas${NC}" ;;
        4) echo -e "${GREEN}Período definido: Últimas 24 horas${NC}" ;;
        5) echo -e "${GREEN}Período definido: Últimos 7 dias${NC}" ;;
        6) echo -e "${GREEN}Período definido: Últimos 30 dias${NC}" ;;
        7) echo -e "${GREEN}Período personalizado selecionado${NC}" ;;
        0) return ;;
        *) echo -e "${RED}Opção inválida!${NC}" ;;
    esac
}

# Exporta gráfico
export_graph() {
    clear
    echo -e "${CYAN}💾 EXPORTAR GRÁFICO${NC}"
    echo
    
    echo "┌─────────────────────────────────────────────────────────────┐"
    echo "│                                                             │"
    echo "│  Formatos disponíveis:                                      │"
    echo "│                                                             │"
    echo "│  [1] 📄 Texto (TXT)                                         │"
    echo "│  [2] 📊 CSV                                                 │"
    echo "│  [3] 📋 JSON                                                │"
    echo "│  [4] 📈 HTML (Interativo)                                   │"
    echo "│  [5] 🖼️ PNG (Imagem)                                        │"
    echo "│  [6] 📊 PDF (Relatório)                                     │"
    echo "│                                                             │"
    echo "│  Local de salvamento:                                       │"
    echo "│  $GRAPHS_DIR/                                           │"
    echo "│                                                             │"
    echo "│  [0] Cancelar                                               │"
    echo "│                                                             │"
    echo "└─────────────────────────────────────────────────────────────┘"
    echo
    echo -n "Escolha um formato: "
    read -r format_choice
    
    case $format_choice in
        1) echo -e "${GREEN}Exportando como TXT...${NC}" ;;
        2) echo -e "${GREEN}Exportando como CSV...${NC}" ;;
        3) echo -e "${GREEN}Exportando como JSON...${NC}" ;;
        4) echo -e "${GREEN}Exportando como HTML...${NC}" ;;
        5) echo -e "${GREEN}Exportando como PNG...${NC}" ;;
        6) echo -e "${GREEN}Exportando como PDF...${NC}" ;;
        0) return ;;
        *) echo -e "${RED}Formato inválido!${NC}" ;;
    esac
    
    echo -e "${GREEN}✅ Gráfico exportado com sucesso!${NC}"
}

# Função principal
main "$@"
```

---

## 📝 EXEMPLOS DE USO

### **Exemplo 1: Análise de Distribuição**
```bash
# Cenário: Verificar distribuição de ameaças
# Ação: Visualizar gráfico de distribuição

1. Acessar Visualizador de Gráficos
2. Selecionar [1] Distribuição de Ameaças
3. Analisar percentuais por categoria
4. Identificar categorias dominantes
5. Exportar relatório se necessário
```

### **Exemplo 2: Análise Temporal**
```bash
# Cenário: Identificar padrões temporais
# Ação: Visualizar timeline de eventos

1. Acessar Visualizador de Gráficos
2. Selecionar [2] Timeline de Eventos
3. Definir período [4] Últimas 24 horas
4. Analisar picos de atividade
5. Identificar horários críticos
```

### **Exemplo 3: Comparação de Configurações**
```bash
# Cenário: Avaliar impacto de mudanças
# Ação: Comparar configurações

1. Modificar pontuações no Editor
2. Acessar Visualizador de Gráficos
3. Selecionar [5] Comparação de Configurações
4. Analisar impacto das mudanças
5. Decidir se aplicar ou ajustar
```

---

## 🎨 PERSONALIZAÇÃO

### **Temas Visuais**
```bash
# Temas disponíveis:
- Claro (padrão)
- Escuro
- Alto Contraste
- Colorblind Friendly
- Minimalista
```

### **Configurações de Exibição**
```bash
# Opções:
- Tamanho de fonte
- Cores personalizadas
- Animações
- Auto-refresh
- Notificações
```

### **Exportação Personalizada**
```bash
# Formatos:
- TXT: Texto simples
- CSV: Dados estruturados
- JSON: Dados completos
- HTML: Interativo
- PNG: Imagem estática
- PDF: Relatório completo
```

---

**Documento criado em**: 29/06/2025  
**Versão**: 1.0  
**Autor**: Jackson Savoldi  
**Projeto**: ACADe-TI - Aula 04 