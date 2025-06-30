# 🧠 ARQUITETURA DO SISTEMA INTELIGENTE DE ANÁLISE DE LOGS
## LOG ANALYZER PRO - Versão 5.0

---

## 📋 ÍNDICE
1. [Visão Geral do Sistema](#visão-geral)
2. [Arquitetura Modular](#arquitetura-modular)
3. [Sistema de Inteligência](#sistema-de-inteligência)
4. [Sistema de Regras Customizáveis](#sistema-de-regras)
5. [Interface Interativa](#interface-interativa)
6. [Fluxo de Execução](#fluxo-de-execução)
7. [Documentação para Desenvolvedores](#documentação-desenvolvedores)
8. [Roadmap e Funcionalidades Futuras](#roadmap)

---

## 🎯 VISÃO GERAL

### **Objetivo do Sistema**
O LOG ANALYZER PRO é um sistema avançado de análise de logs de segurança que combina:
- **Detecção automática** de ameaças usando IA/ML
- **Sistema de aprendizado contínuo** para novos padrões
- **Análise temporal inteligente** para detectar comportamentos suspeitos
- **Interface interativa** para personalização
- **Arquitetura modular** para expansão infinita

### **Princípios de Design**
1. **Kernel Limpo** - Core sempre portável e independente
2. **Modularidade** - Componentes intercambiáveis
3. **Aprendizado Contínuo** - Sistema que evolui com o tempo
4. **Flexibilidade** - Regras customizáveis pelo usuário
5. **Escalabilidade** - Fácil adição de novos recursos

---

## 🏗️ ARQUITETURA MODULAR

### **Estrutura de Diretórios**
```
src/
├── modules/
│   ├── intelligence/           # Sistema de IA/ML
│   │   ├── pattern_learner.sh      # Aprende novos padrões
│   │   ├── temporal_analyzer.sh    # Análise de intervalos
│   │   ├── behavior_classifier.sh  # Classificação comportamental
│   │   └── adaptive_scoring.sh     # Pontuação adaptativa
│   ├── logic/                 # Lógica de negócio
│   │   ├── attack_patterns.sh      # Padrões base de ataques
│   │   ├── custom_rules/           # Regras customizáveis
│   │   │   ├── scan_detection.sh   # Detecção de scans
│   │   │   ├── brute_force.sh      # Força bruta
│   │   │   ├── enumeration.sh      # Enumeração
│   │   │   └── rate_limiting.sh    # Limitação de taxa
│   │   └── rule_engine.sh          # Motor de regras
│   ├── analysis/              # Análises específicas
│   │   ├── temporal.sh             # Análise temporal
│   │   ├── behavioral.sh           # Análise comportamental
│   │   └── payload_analysis.sh     # Análise de payloads
│   └── output/                 # Saídas do sistema
│       ├── report_generator.sh     # Gerador de relatórios
│       ├── html_formatter.sh       # Formatação HTML
│       └── console_display.sh      # Exibição no terminal
├── scripts/
│   ├── core/                  # Scripts principais
│   │   ├── scriptlogs_avancado.sh  # Kernel principal
│   │   └── scriptlogs.sh           # Script básico
│   ├── utils/                 # Utilitários
│   │   ├── file_selector.sh        # Seletor de arquivos
│   │   └── config_loader.sh        # Carregador de configuração
│   └── generators/            # Geradores
│       └── gerador_logs_realistas.sh
└── training/                  # Sistema de treinamento
    ├── format_learner.sh           # Aprende formatos
    ├── pattern_extractor.sh        # Extrai padrões
    └── validation_system.sh        # Valida aprendizado
```

### **Componentes Principais**

#### **1. Kernel Principal (`scriptlogs_avancado.sh`)**
- **Responsabilidade**: Orquestração geral do sistema
- **Características**: 
  - Portável e independente
  - Sem dependências de UI
  - Pode ser copiado para qualquer sistema Linux
  - Funciona como binário standalone

#### **2. Interface Principal (`analisar_logs.sh`)**
- **Responsabilidade**: Interface do usuário
- **Características**:
  - Seletor interativo de arquivos
  - Menu de opções de análise
  - Integração com o kernel
  - Apresentação de resultados

#### **3. Módulos de Inteligência**
- **Responsabilidade**: Lógica avançada de detecção
- **Características**:
  - Aprendizado automático
  - Análise temporal
  - Classificação comportamental
  - Pontuação adaptativa

---

## 🧠 SISTEMA DE INTELIGÊNCIA

### **1. Aprendizado de Padrões (`pattern_learner.sh`)**

```bash
# Funcionalidades:
- Detecta automaticamente novos formatos de log
- Extrai padrões de ataques não conhecidos
- Sugere novos regex para detecção
- Valida padrões com histórico de dados
- Aprende com feedback do usuário
```

### **2. Análise Temporal (`temporal_analyzer.sh`)**

```bash
# Funcionalidades:
- Analisa intervalos entre eventos
- Detecta picos de atividade suspeita
- Identifica padrões de frequência
- Distingue ataques automatizados vs manuais
- Calcula taxas de eventos por tempo
```

### **3. Classificação Comportamental (`behavior_classifier.sh`)**

```bash
# Funcionalidades:
- Analisa comportamento de IPs/usuários
- Detecta mudanças de padrão
- Identifica sequências suspeitas
- Classifica nível de sofisticação do ataque
- Correlaciona eventos relacionados
```

### **4. Pontuação Adaptativa (`adaptive_scoring.sh`)**

```bash
# Funcionalidades:
- Ajusta pontuação baseada no contexto
- Considera histórico de eventos
- Aplica multiplicadores temporais
- Aprende com falsos positivos/negativos
- Personaliza pontuação por ambiente
```

---

## ⚙️ SISTEMA DE REGRAS CUSTOMIZÁVEIS

### **Estrutura de Regras**

```json
{
  "rule_name": "Rapid Port Scan Detection",
  "version": "1.0",
  "author": "system",
  "category": "scan_detection",
  "conditions": {
    "same_ip_requests": "> 5",
    "time_interval": "< 10",
    "target_pattern": "port_scan"
  },
  "scoring": {
    "base_score": 8,
    "category": "ALTO",
    "multiplier": 1.5,
    "max_score": 10
  },
  "description": "Detecta scans rápidos de portas",
  "tags": ["scan", "automated", "network"],
  "enabled": true
}
```

### **Tipos de Regras Disponíveis**

#### **1. Detecção de Scan (`scan_detection.sh`)**
```bash
# Regras:
- Scan Rápido: >5 requests em <10s = ALTO (8pts)
- Scan Lento: >10 requests em >60s = MÉDIO (4pts)
- Scan Manual: >3 requests em >300s = BAIXO (2pts)
```

#### **2. Força Bruta (`brute_force.sh`)**
```bash
# Regras:
- Automatizado: >5 falhas em <30s = ALTO (9pts)
- Manual: >3 falhas em >300s = MÉDIO (6pts)
- Enumeração: >2 usuários em <60s = ALTO (7pts)
```

#### **3. Enumeração (`enumeration.sh`)**
```bash
# Regras:
- Usuários: >3 usuários únicos = MÉDIO (5pts)
- Diretórios: >10 tentativas = ALTO (7pts)
- Arquivos: >5 tentativas = MÉDIO (4pts)
```

#### **4. Limitação de Taxa (`rate_limiting.sh`)**
```bash
# Regras:
- Muitas requisições: >100/min = ALTO (8pts)
- Picos suspeitos: >50 em 10s = CRÍTICO (10pts)
- Padrão irregular: variação >200% = MÉDIO (5pts)
```

---

## 🎮 INTERFACE INTERATIVA

### **Funcionalidades Interativas**

#### **1. Editor de Pontuação**
```bash
# Interface gráfica para modificar:
- Pontuação base de cada categoria
- Multiplicadores temporais
- Limites de detecção
- Pesos de regras customizadas
```

#### **2. Visualizador de Gráficos**
```bash
# Gráficos interativos:
- Distribuição de ameaças por tempo
- Score de risco em tempo real
- Correlação de eventos
- Análise de tendências
```

#### **3. Configurador de Regras**
```bash
# Interface para:
- Criar novas regras
- Modificar regras existentes
- Ativar/desativar regras
- Testar regras com dados reais
```

#### **4. Sistema de Feedback**
```bash
# Funcionalidades:
- Marcar falsos positivos/negativos
- Sugerir novos padrões
- Avaliar qualidade da detecção
- Treinar sistema com feedback
```

### **Menu Interativo Principal**
```
🔧 CONFIGURAÇÕES AVANÇADAS
1) Editor de Pontuação
2) Configurador de Regras
3) Visualizador de Gráficos
4) Sistema de Feedback
5) Treinamento de IA
6) Backup/Restore Configurações
0) Voltar
```

---

## 🔄 FLUXO DE EXECUÇÃO

### **Fluxo Principal**
```bash
1. INICIALIZAÇÃO
   ├── Carrega configurações
   ├── Inicializa módulos
   └── Verifica dependências

2. SELEÇÃO DE ARQUIVO
   ├── Interface interativa
   ├── Detecção automática de formato
   └── Validação do arquivo

3. ANÁLISE INTELIGENTE
   ├── Classificação base
   ├── Análise temporal
   ├── Aplicação de regras customizadas
   └── Classificação comportamental

4. PONTUAÇÃO ADAPTATIVA
   ├── Cálculo de score base
   ├── Aplicação de multiplicadores
   ├── Consideração de contexto
   └── Score final

5. CORRELAÇÃO E RELATÓRIO
   ├── Correlação de eventos
   ├── Geração de relatório
   ├── Interface interativa
   └── Salvamento de dados
```

### **Fluxo de Aprendizado**
```bash
1. DETECÇÃO DE NOVO PADRÃO
   ├── Identifica evento não classificado
   ├── Extrai características
   └── Sugere novo padrão

2. VALIDAÇÃO
   ├── Testa com dados históricos
   ├── Verifica falsos positivos
   └── Aprova ou rejeita

3. INTEGRAÇÃO
   ├── Adiciona ao sistema
   ├── Atualiza documentação
   └── Notifica usuário
```

---

## 📚 DOCUMENTAÇÃO PARA DESENVOLVEDORES

### **Como Criar Nova Regra**

#### **1. Identificar Necessidade**
```bash
# Perguntas a responder:
- Que comportamento quer detectar?
- Quais são os critérios temporais?
- Qual é a pontuação adequada?
- Como distinguir de atividade normal?
```

#### **2. Criar Arquivo de Regra**
```bash
# Localização: src/modules/logic/custom_rules/
# Nome: nome_da_regra.sh
# Formato: JSON com estrutura definida
```

#### **3. Implementar Validação**
```bash
# Função obrigatória:
validate_rule() {
    # Testa regra com dados de exemplo
    # Verifica sintaxe
    # Valida lógica
}
```

#### **4. Registrar no Sistema**
```bash
# Adicionar ao rule_engine.sh:
register_rule "nome_da_regra.sh"
```

#### **5. Documentar**
```bash
# Criar documentação:
- Como funciona
- Quando usar
- Exemplos de uso
- Configurações recomendadas
```

### **Como Criar Novo Módulo**

#### **1. Estrutura do Módulo**
```bash
# Arquivos obrigatórios:
- module_name.sh (lógica principal)
- module_name.conf (configuração)
- module_name.md (documentação)
- module_name_test.sh (testes)
```

#### **2. Interface Padrão**
```bash
# Funções obrigatórias:
init_module()      # Inicialização
process_data()     # Processamento
cleanup_module()   # Limpeza
get_version()      # Versão
```

#### **3. Integração**
```bash
# Registrar no sistema principal:
- Adicionar ao carregador de módulos
- Documentar dependências
- Criar testes de integração
```

---

## 🚀 ROADMAP E FUNCIONALIDADES FUTURAS

### **Versão 5.1 - Interface Gráfica**
- [ ] Editor visual de regras
- [ ] Gráficos interativos em tempo real
- [ ] Dashboard web
- [ ] Notificações push

### **Versão 5.2 - IA Avançada**
- [ ] Machine Learning para detecção
- [ ] Análise preditiva de ameaças
- [ ] Auto-tuning de parâmetros
- [ ] Detecção de anomalias

### **Versão 5.3 - Integração**
- [ ] APIs REST para integração
- [ ] Webhooks para notificações
- [ ] Integração com SIEM
- [ ] Suporte a múltiplos formatos

### **Versão 5.4 - Colaboração**
- [ ] Compartilhamento de regras
- [ ] Comunidade de padrões
- [ ] Sistema de reputação
- [ ] Marketplace de módulos

### **Versão 6.0 - Plataforma**
- [ ] SaaS (Software as a Service)
- [ ] Multi-tenant
- [ ] Análise em nuvem
- [ ] Escalabilidade automática

---

## 📊 MÉTRICAS DE SUCESSO

### **Técnicas**
- **Taxa de Detecção**: >95%
- **Taxa de Falsos Positivos**: <2%
- **Tempo de Processamento**: <30s por 10k linhas
- **Precisão de Classificação**: >90%

### **Usuário**
- **Facilidade de Uso**: Score >8/10
- **Tempo de Configuração**: <5 minutos
- **Satisfação Geral**: >9/10
- **Adoção de Novos Recursos**: >80%

---

## 🔧 MANUTENÇÃO E SUPORTE

### **Atualizações**
- Sistema de atualização automática
- Backup de configurações
- Rollback em caso de problemas
- Logs de mudanças

### **Suporte**
- Documentação completa
- Exemplos práticos
- Comunidade de usuários
- Suporte técnico

---

**Documento criado em**: 29/06/2025  
**Versão**: 1.0  
**Autor**: Jackson Savoldi  
**Projeto**: ACADe-TI - Aula 04 