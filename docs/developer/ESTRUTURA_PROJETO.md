# 📁 ESTRUTURA DO PROJETO - ANÁLISE DE LOGS

## 🎯 Visão Geral

Este documento descreve a estrutura atualizada do projeto de análise de logs de segurança, organizada de forma modular e escalável para facilitar manutenção, desenvolvimento e uso.

**Autor:** Jackson Savoldi  
**Professor:** Erick Martinez  
**Curso:** ACADe-TI - Aula 04 (28/06/2025)

---

## 🏗️ Arquitetura Geral

```
logs/
├── 📁 config/                       # Configurações centralizadas
├── 📁 src/scripts/                  # Código fonte dos scripts
├── 📁 analogs/                      # Logs para análise
├── 📁 payloads/                     # Payloads para desenvolvimento
├── 📁 docs/                         # Documentação
├── 📁 tests/                        # Testes automatizados
├── 📁 scripts/                      # Scripts de automação
├── 📁 system/                       # Sistema de treinamento
├── 📁 results/                      # Resultados de análises
├── 📁 temp/                         # Arquivos temporários
└── 📁 backup_*/                     # Backups manuais
```

---

## 📋 Detalhamento das Pastas

### 🔧 `config/` - Configurações Centralizadas

**Propósito:** Armazenar todas as configurações do projeto de forma centralizada.

```
config/
├── main.conf                        # Configuração principal do sistema
├── paths.conf                       # Caminhos do projeto (dinâmicos)
├── patterns.conf                    # Padrões de detecção padrão
└── attack_patterns_learning.conf    # Padrões de ataque para treinamento
```

**Características:**
- ✅ Configuração centralizada
- ✅ Caminhos dinâmicos
- ✅ Fácil manutenção
- ✅ Portabilidade entre ambientes

### 💻 `src/scripts/` - Código Fonte

**Propósito:** Organizar o código fonte de forma modular e escalável.

```
src/scripts/
├── 📁 core/                         # Scripts principais
│   ├── scriptlogs.sh                # Script básico de análise
│   ├── scriptlogs_avancado.sh       # Script avançado principal
│   └── scriptlogs_sem_jq.sh         # Script sem dependência do jq
├── 📁 generators/                   # Geradores de conteúdo
│   └── gerador_logs_realistas.sh    # Gerador de logs realistas
└── 📁 utils/                        # Utilitários
    ├── config_loader.sh             # Carregador de configuração
    └── csv_to_training_system.sh    # Sistema de treinamento CSV
```

**Características:**
- ✅ Organização modular
- ✅ Separação de responsabilidades
- ✅ Fácil manutenção
- ✅ Reutilização de código

### 📊 `analogs/` - Logs para Análise

**Propósito:** Organizar logs de diferentes tipos e origens para análise.

```
analogs/
├── 📁 attacks/                      # Logs de ataques específicos
│   ├── brute_force.log              # Tentativas de força bruta
│   ├── lfi.log                      # Local File Inclusion
│   ├── sql_injection.log            # Injeção SQL
│   └── xss.log                      # Cross-Site Scripting
├── 📁 custom/                       # Logs customizados
│   └── logs_analise.txt             # Logs para análise geral
├── 📁 examples/                     # Exemplos de logs
│   ├── apache2_access.log           # Exemplo Apache
│   ├── mysql.log                    # Exemplo MySQL
│   ├── nginx_access.log             # Exemplo Nginx
│   ├── nginx_error.log              # Exemplo Nginx Error
│   └── tentivas-sshubuntu-debian-auth.log # Exemplo SSH
├── 📁 logs_realistas/               # Logs realistas para testes
│   ├── apache_access_real.log       # Apache realista
│   ├── fail2ban_real.log            # Fail2ban realista
│   ├── mysql_real.log               # MySQL realista
│   ├── nginx_error_real.log         # Nginx error realista
│   └── ssh_auth_real.log            # SSH auth realista
└── 📁 services/                     # Logs organizados por serviço
    ├── 📁 apache/                   # Logs Apache
    ├── 📁 auth/                     # Logs de autenticação
    ├── 📁 cron/                     # Logs do cron
    ├── 📁 dns/                      # Logs DNS
    ├── 📁 docker/                   # Logs Docker
    ├── 📁 fail2ban/                 # Logs Fail2ban
    ├── 📁 haproxy/                  # Logs HAProxy
    ├── 📁 iptables/                 # Logs iptables
    ├── 📁 letsencrypt/              # Logs Let's Encrypt
    ├── 📁 mail/                     # Logs de email
    ├── 📁 mysql/                    # Logs MySQL
    ├── 📁 nginx/                    # Logs Nginx
    ├── 📁 node_pm2/                 # Logs Node.js PM2
    ├── 📁 openssh/                  # Logs OpenSSH
    ├── 📁 openvpn/                  # Logs OpenVPN
    ├── 📁 php_fpm/                  # Logs PHP-FPM
    ├── 📁 redis/                    # Logs Redis
    ├── 📁 sys/                      # Logs do sistema
    ├── 📁 ufw/                      # Logs UFW
    ├── 📁 varnish/                  # Logs Varnish
    └── 📁 vsftpd/                   # Logs vsftpd
```

**Características:**
- ✅ Organização por tipo de ataque
- ✅ Logs realistas para testes
- ✅ Exemplos para aprendizado
- ✅ Organização por serviço

### 🎯 `payloads/` - Payloads para Desenvolvimento

**Propósito:** Armazenar payloads para desenvolvimento e teste de padrões.

```
payloads/
├── 📁 sql-injection-payload-list/   # Payloads SQL injection
│   ├── 📁 Intruder/                 # Payloads para Burp Suite Intruder
│   │   ├── 📁 detect/               # Payloads de detecção
│   │   ├── 📁 exploit/              # Payloads de exploração
│   │   └── 📁 payloads-sql-blind/   # Payloads SQL blind
│   └── README.md                    # Documentação dos payloads
└── 📁 xss/                          # Payloads XSS
    └── xsspayloads.txt              # Lista de payloads XSS
```

**Características:**
- ✅ Organização por tipo de ataque
- ✅ Compatibilidade com ferramentas
- ✅ Documentação incluída
- ✅ Fácil atualização

### 📚 `docs/` - Documentação

**Propósito:** Organizar toda a documentação do projeto.

```
docs/
├── 📁 user/                         # Documentação para usuários
│   ├── README.md                    # Guia principal do usuário
│   └── COMANDOS_WSL.md              # Comandos para WSL
└── 📁 developer/                    # Documentação para desenvolvedores
    ├── ANALISE_RESULTADOS_TESTE.md  # Análise de resultados
    ├── DOCUMENTACAO_SISTEMA_ANALISE.md # Documentação técnica
    ├── ESTRUTURA_PROJETO.md         # Este documento
    ├── FLUXO_SISTEMA_TREINAMENTO.md # Fluxo do sistema
    ├── MELHORIAS_LOGICAS_PONTUACAO.md # Melhorias na pontuação
    └── MELHORIAS_v4.0.md            # Melhorias da versão 4.0
```

**Características:**
- ✅ Separação por público-alvo
- ✅ Documentação técnica detalhada
- ✅ Guias práticos
- ✅ Histórico de melhorias

### 🧪 `tests/` - Testes Automatizados

**Propósito:** Organizar todos os testes do sistema.

```
tests/
├── 📁 unit/                         # Testes unitários
│   ├── teste_backup_suspeito.sh     # Teste de backup
│   ├── teste_completo.sh            # Teste completo
│   ├── teste_cores.sh               # Teste de cores
│   ├── teste_debug.sh               # Teste de debug
│   ├── teste_multi_formato.sh       # Teste multi-formato
│   ├── teste_printf_cores.sh        # Teste de cores printf
│   ├── teste_regex.sh               # Teste de regex
│   ├── teste_simples.sh             # Teste simples
│   └── teste_tabela.sh              # Teste de tabela
├── 📁 integration/                  # Testes de integração
│   ├── teste_completo_sistema.sh    # Teste completo do sistema
│   └── testes_wsl_estruturado.sh    # Testes WSL estruturados
├── 📁 performance/                  # Testes de performance
│   └── teste_performance_completo.sh # Teste de performance
└── 📁 results/                      # Resultados dos testes
```

**Características:**
- ✅ Testes unitários
- ✅ Testes de integração
- ✅ Testes de performance
- ✅ Resultados organizados

### 🤖 `scripts/` - Scripts de Automação

**Propósito:** Scripts para automação de tarefas do projeto.

```
scripts/
├── criar_estrutura.sh               # Cria estrutura do projeto
└── verificar_estrutura.sh           # Verifica estrutura
```

**Características:**
- ✅ Automação de setup
- ✅ Verificação de integridade
- ✅ Facilita manutenção
- ✅ Reduz erros manuais

### 🧠 `system/` - Sistema de Treinamento

**Propósito:** Sistema de aprendizado e treinamento de padrões.

```
system/
├── 📁 backup/                       # Backups automáticos
├── 📁 data/                         # Dados do sistema
│   ├── 📁 exports/                  # Exportações de padrões
│   │   └── exported_patterns_*.csv  # Padrões exportados
│   ├── 📁 import/                   # Importações
│   │   └── 📁 csv/                  # Importações CSV
│   │       └── 📁 patterns/         # Padrões CSV
│   │           └── payloads_patterns.csv # Padrões de payloads
│   └── 📁 templates/                # Templates
└── 📁 logs/                         # Logs do sistema
```

**Características:**
- ✅ Sistema de backup automático
- ✅ Importação/exportação de dados
- ✅ Histórico de operações
- ✅ Templates reutilizáveis

### 📈 `results/` - Resultados de Análises

**Propósito:** Armazenar resultados de análises realizadas.

```
results/
└── [arquivos de resultado gerados dinamicamente]
```

**Características:**
- ✅ Resultados organizados
- ✅ Histórico de análises
- ✅ Fácil acesso
- ✅ Backup automático

### 🗂️ `temp/` - Arquivos Temporários

**Propósito:** Armazenar arquivos temporários durante execução.

```
temp/
└── [arquivos temporários gerados dinamicamente]
```

**Características:**
- ✅ Limpeza automática
- ✅ Isolamento de arquivos temporários
- ✅ Evita poluição do projeto
- ✅ Performance otimizada

---

## 🔄 Fluxo de Trabalho

### 1. **Configuração Inicial**
```bash
# Verificar estrutura
./scripts/verificar_estrutura.sh

# Criar estrutura se necessário
./scripts/criar_estrutura.sh
```

### 2. **Desenvolvimento**
```bash
# Editar scripts principais
vim src/scripts/core/scriptlogs_avancado.sh

# Testar mudanças
./tests/unit/teste_simples.sh
```

### 3. **Análise de Logs**
```bash
# Analisar logs realistas
./src/scripts/core/scriptlogs_avancado.sh -v analogs/logs_realistas/apache_access_real.log

# Gerar relatório
./src/scripts/core/scriptlogs_avancado.sh -v -r results/relatorio.html analogs/logs_realistas/apache_access_real.log
```

### 4. **Treinamento do Sistema**
```bash
# Importar padrões
./src/scripts/utils/csv_to_training_system.sh system/data/import/csv/patterns/payloads_patterns.csv

# Treinar sistema
./src/scripts/core/scriptlogs_avancado.sh --treinar
```

---

## 🎯 Benefícios da Nova Estrutura

### ✅ **Organização**
- Estrutura clara e lógica
- Separação de responsabilidades
- Fácil navegação

### ✅ **Manutenibilidade**
- Configuração centralizada
- Código modular
- Documentação organizada

### ✅ **Escalabilidade**
- Fácil adição de novos módulos
- Estrutura extensível
- Padrões consistentes

### ✅ **Portabilidade**
- Caminhos dinâmicos
- Configuração flexível
- Funciona em qualquer ambiente

### ✅ **Colaboração**
- Estrutura padronizada
- Documentação clara
- Fácil onboarding

---

## 🚀 Próximos Passos

1. **Testar a estrutura atual** com diferentes cenários
2. **Documentar padrões específicos** do domínio
3. **Criar templates** para novos tipos de log
4. **Implementar CI/CD** para testes automáticos
5. **Criar dashboard** para visualização de resultados

---

*Documentação criada por Jackson Savoldi - ACADe-TI 2025* 