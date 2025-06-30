# 🚀 SISTEMA DE ANÁLISE DE LOGS DE SEGURANÇA - ESTRUTURA ORGANIZADA

## 📋 Visão Geral

Este projeto implementa um sistema avançado de análise de logs de segurança em Bash, com funcionalidades como detecção automática de tipos de log, classificação por peso de ameaça, análise temporal, correlação de eventos, geolocalização e geração de relatórios profissionais.

## 🏗️ Estrutura Organizada

O projeto foi reorganizado em uma estrutura hierárquica profissional para facilitar o desenvolvimento, manutenção e uso:

```
projeto/
├── 📁 src/                    # Código fonte principal
│   └── 📁 scripts/           # Scripts principais do sistema
│       ├── scriptlogs_avancado.sh      # Script principal de análise
│       ├── gerador_logs_realistas.sh   # Gerador de logs para testes
│       ├── csv_to_training_system.sh   # Conversor CSV para treinamento
│       ├── scriptlogs_sem_jq.sh        # Versão sem dependência jq
│       └── scriptlogs.sh               # Versão básica
│
├── 📁 tests/                  # Testes e validações
│   ├── testes_wsl_estruturado.sh       # Testes completos estruturados
│   ├── teste_performance_completo.sh   # Testes de performance
│   ├── teste_completo_sistema.sh       # Teste completo do sistema
│   └── [outros scripts de teste]
│
├── 📁 config/                 # Configurações e padrões
│   └── attack_patterns_learning.conf   # Padrões de detecção
│
├── 📁 logs/                   # Todos os logs organizados
│   ├── 📁 examples/          # Logs de exemplo para desenvolvimento
│   ├── 📁 realistic/         # Logs realistas gerados automaticamente
│   ├── 📁 attacks/           # Logs específicos de ataques
│   └── 📁 services/          # Logs organizados por tipo de serviço
│       ├── apache/
│       ├── nginx/
│       ├── mysql/
│       ├── openssh/
│       ├── fail2ban/
│       └── [outros serviços]
│
├── 📁 data/                   # Dados e arquivos CSV
│   ├── payloads_patterns.csv            # Padrões de payload
│   └── exported_patterns_*.csv          # Padrões exportados
│
├── 📁 results/                # Resultados de testes
│   └── resultados_performance_*/        # Resultados organizados por data
│
├── 📁 docs/                   # Documentação completa
│   ├── README.md
│   ├── ANALISE_RESULTADOS_TESTE.md
│   ├── COMANDOS_WSL.md
│   ├── DOCUMENTACAO_SISTEMA_ANALISE.md
│   └── [outros documentos]
│
├── 📁 payloads/               # Payloads e padrões de ataque
│   ├── sql-injection-payload-list/     # Lista de payloads SQL
│   └── xsspayloads.txt                 # Payloads XSS
│
├── 📁 system/                 # Logs do sistema
│   ├── import_history.log              # Histórico de importação
│   ├── training_history.log            # Histórico de treinamento
│   └── logs_analise.txt                # Logs de análise
│
├── 📁 temp/                   # Arquivos temporários
├── 📁 examples/               # Exemplos e templates
└── 📁 backup_*/               # Backups automáticos
```

## 🚀 Início Rápido

### 1. Inicializar o Sistema
```bash
# Executar o iniciador interativo
bash iniciar_projeto.sh
```

### 2. Navegar pela Estrutura
```bash
# Ver estrutura e comandos úteis
bash navegar_projeto.sh
```

### 3. Executar Testes Completos
```bash
# Testes estruturados (recomendado)
bash tests/testes_wsl_estruturado.sh

# Ou usar o menu interativo
bash iniciar_projeto.sh
# Escolher opção 1
```

## 📋 Funcionalidades Principais

### 🔍 Análise de Logs
- **Detecção automática** de tipos de log (Apache, Nginx, SSH, MySQL, etc.)
- **Classificação por peso** de ameaça (baixo, médio, alto, crítico)
- **Análise temporal** com correlação de eventos
- **Geolocalização** de IPs suspeitos
- **Detecção de padrões** de ataque (SQL Injection, XSS, LFI/RFI, brute force)

### 🎓 Sistema de Aprendizado
- **Treinamento contínuo** via CSV
- **Importação de padrões** de ataque
- **Melhoria automática** da detecção
- **Histórico de treinamento**

### 📊 Relatórios Profissionais
- **Relatórios detalhados** em texto e HTML
- **Métricas de performance**
- **Análise estatística**
- **Recomendações de segurança**

### 🧪 Testes Automatizados
- **Geração de logs realistas** para testes
- **Validação de funcionalidades**
- **Métricas de performance**
- **Relatórios de teste**

## 🛠️ Como Usar

### Desenvolvimento
```bash
# Trabalhar com scripts principais
cd src/scripts/

# Executar testes
cd tests/
bash testes_wsl_estruturado.sh

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

### Análise de Log Específico
```bash
# Usar o menu interativo
bash iniciar_projeto.sh
# Escolher opção 4

# Ou diretamente
bash src/scripts/scriptlogs_avancado.sh -v -t -aR -gT -pedago -pcn -peso -correl "caminho/para/log"
```

## 📁 Organização por Diretórios

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

## 🔧 Manutenção

### Backup Automático
```bash
# Backup é criado automaticamente antes de reorganizar
ls -la backup_*/
```

### Limpeza de Arquivos Temporários
```bash
# Usar menu de manutenção
bash iniciar_projeto.sh
# Escolher opção 9 -> 1
```

### Verificação de Integridade
```bash
# Usar menu de manutenção
bash iniciar_projeto.sh
# Escolher opção 9 -> 5
```

## 📋 Convenções

- **Nomes de arquivos**: snake_case
- **Diretórios**: lowercase
- **Scripts**: .sh
- **Configurações**: .conf
- **Documentação**: .md
- **Dados**: .csv, .json

## 🚀 Comandos Rápidos

```bash
# Iniciar sistema
bash iniciar_projeto.sh

# Navegar estrutura
bash navegar_projeto.sh

# Executar testes
bash tests/testes_wsl_estruturado.sh

# Gerar logs realistas
bash src/scripts/gerador_logs_realistas.sh

# Analisar log específico
bash src/scripts/scriptlogs_avancado.sh -v -t -aR -gT -pedago -pcn -peso -correl "log_file"

# Ver documentação
cat docs/README.md
```

## 🎯 Próximos Passos

1. **Executar testes completos** para validar a estrutura
2. **Configurar padrões** de detecção em `config/`
3. **Importar dados CSV** para treinamento
4. **Analisar logs reais** do seu ambiente
5. **Personalizar relatórios** conforme necessário

## 📞 Suporte

Para dúvidas ou problemas:
1. Verificar a documentação em `docs/`
2. Executar testes para identificar problemas
3. Verificar logs do sistema em `system/`
4. Consultar resultados de testes em `results/`

---

**Organizado em:** $(date '+%Y-%m-%d %H:%M:%S')
**Estrutura:** Profissional e Hierárquica
**Status:** Pronto para Produção 