# 📁 ESTRUTURA DO PROJETO - SISTEMA DE ANÁLISE DE LOGS

## 🏗️ Organização Hierárquica

```
projeto/
├── 📁 src/                    # Código fonte principal
│   └── 📁 scripts/           # Scripts principais do sistema
│       ├── scriptlogs_avancado.sh
│       ├── gerador_logs_realistas.sh
│       └── csv_to_training_system.sh
│
├── 📁 tests/                  # Testes e validações
│   ├── teste_completo_sistema.sh
│   ├── teste_performance_completo.sh
│   └── testes_wsl.sh
│
├── 📁 config/                 # Configurações e padrões
│   └── attack_patterns_learning.conf
│
├── 📁 logs/                   # Todos os logs organizados
│   ├── 📁 examples/          # Logs de exemplo
│   ├── 📁 realistic/         # Logs realistas gerados
│   ├── 📁 attacks/           # Logs de ataques
│   └── 📁 services/          # Logs por serviço
│       ├── apache/
│       ├── nginx/
│       ├── mysql/
│       ├── openssh/
│       └── ...
│
├── 📁 data/                   # Dados e arquivos CSV
│   ├── payloads_patterns.csv
│   └── exported_patterns_*.csv
│
├── 📁 results/                # Resultados de testes
│   └── resultados_performance_*/
│
├── 📁 docs/                   # Documentação
│   ├── README.md
│   ├── ANALISE_RESULTADOS_TESTE.md
│   ├── COMANDOS_WSL.md
│   └── ...
│
├── 📁 payloads/               # Payloads e padrões de ataque
│   ├── sql-injection-payload-list/
│   └── xsspayloads.txt
│
├── 📁 system/                 # Logs do sistema
│   ├── import_history.log
│   └── training_history.log
│
├── 📁 temp/                   # Arquivos temporários
│
├── 📁 examples/               # Exemplos e templates
│
└── 📁 backup_*/               # Backups automáticos
```

## 🎯 Propósitos de Cada Diretório

### 📁 `src/scripts/`
- **Scripts principais** do sistema de análise
- **Geradores** de logs realistas
- **Conversores** e utilitários

### 📁 `tests/`
- **Scripts de teste** automatizados
- **Validações** de funcionalidade
- **Métricas** de performance

### 📁 `config/`
- **Configurações** do sistema
- **Padrões** de detecção
- **Parâmetros** de análise

### 📁 `logs/`
- **examples/**: Logs de exemplo para desenvolvimento
- **realistic/**: Logs gerados automaticamente para testes
- **attacks/**: Logs específicos de ataques
- **services/**: Logs organizados por tipo de serviço

### 📁 `data/`
- **Arquivos CSV** com padrões
- **Dados** de treinamento
- **Exportações** de resultados

### 📁 `results/`
- **Resultados** de testes
- **Métricas** de performance
- **Relatórios** gerados

### 📁 `docs/`
- **Documentação** completa
- **Guias** de uso
- **Análises** e relatórios

### 📁 `payloads/`
- **Listas** de payloads de ataque
- **Padrões** de detecção
- **Exemplos** de ataques

### 📁 `system/`
- **Logs** do próprio sistema
- **Históricos** de operações
- **Métricas** internas

## 🚀 Como Usar

### Desenvolvimento
```bash
# Trabalhar com scripts principais
cd src/scripts/

# Executar testes
cd tests/
bash testes_wsl.sh

# Ver documentação
cd docs/
cat README.md
```

### Produção
```bash
# Configurar sistema
cd config/
# Editar arquivos de configuração

# Analisar logs
cd logs/
# Colocar logs para análise

# Ver resultados
cd results/
# Analisar relatórios gerados
```

## 📋 Convenções

- **Nomes de arquivos**: snake_case
- **Diretórios**: lowercase
- **Scripts**: .sh
- **Configurações**: .conf
- **Documentação**: .md
- **Dados**: .csv, .json

## 🔧 Manutenção

- **Backups automáticos** criados antes de reorganizar
- **Logs de sistema** em `system/`
- **Arquivos temporários** em `temp/`
- **Resultados** organizados por data/hora

---
**Organizado em:** $(date '+%Y-%m-%d %H:%M:%S')
