#!/bin/bash

# ===================================================================================
# ORGANIZADOR DE ESTRUTURA DO PROJETO - SISTEMA DE ANÁLISE DE LOGS
# ===================================================================================
# Cria estrutura hierárquica profissional para o projeto
# Autor: Jackson Savoldi | ACADe-TI - Aula 04
# ===================================================================================

# Cores
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
CYAN="\e[36m"
WHITE="\e[37m"
BOLD="\e[1m"
RESET="\e[0m"

# Função para log
log() {
    echo -e "$1"
}

# Função para criar diretório e mover arquivos
create_and_move() {
    local dir="$1"
    local pattern="$2"
    local description="$3"
    
    if [[ -n "$pattern" ]]; then
        # Verificar se existem arquivos para mover
        if ls $pattern 2>/dev/null | grep -q .; then
            mkdir -p "$dir"
            mv $pattern "$dir/" 2>/dev/null
            log "${GREEN}✅ $description movidos para $dir/${RESET}"
        else
            log "${YELLOW}⚠️  Nenhum arquivo $description encontrado${RESET}"
        fi
    else
        mkdir -p "$dir"
        log "${GREEN}✅ Diretório $dir criado${RESET}"
    fi
}

# Função principal
main() {
    echo -e "${BOLD}${CYAN}🏗️  ORGANIZANDO ESTRUTURA DO PROJETO${RESET}"
    echo -e "${BOLD}${CYAN}========================================${RESET}"
    echo -e "${BOLD}Data/Hora: $(date '+%Y-%m-%d %H:%M:%S')${RESET}"
    echo ""
    
    # Backup dos arquivos importantes
    log "${BOLD}📦 CRIANDO BACKUP DE SEGURANÇA...${RESET}"
    mkdir -p backup_$(date '+%Y%m%d_%H%M%S')
    cp -r *.sh *.md *.csv *.log backup_$(date '+%Y%m%d_%H%M%S')/ 2>/dev/null
    log "${GREEN}✅ Backup criado${RESET}"
    echo ""
    
    # Estrutura principal
    log "${BOLD}📁 CRIANDO ESTRUTURA PRINCIPAL...${RESET}"
    
    # 1. Scripts principais
    create_and_move "src/scripts" "scriptlogs*.sh" "Scripts principais"
    create_and_move "src/scripts" "gerador_logs_realistas.sh" "Gerador de logs"
    create_and_move "src/scripts" "csv_to_training_system.sh" "Conversor CSV"
    
    # 2. Scripts de teste
    create_and_move "tests" "teste*.sh" "Scripts de teste"
    create_and_move "tests" "testes_wsl.sh" "Testes WSL"
    
    # 3. Configurações
    create_and_move "config" "*.conf" "Arquivos de configuração"
    create_and_move "config" "attack_patterns_learning.conf" "Padrões de ataque"
    
    # 4. Logs de exemplo e teste
    create_and_move "logs/examples" "*.log" "Logs de exemplo"
    create_and_move "logs/examples" "apache2_access.log" "Log Apache"
    create_and_move "logs/examples" "nginx_*.log" "Logs Nginx"
    create_and_move "logs/examples" "mysql.log" "Log MySQL"
    create_and_move "logs/examples" "tentivas-sshubuntu-debian-auth.log" "Log SSH"
    
    # 5. Logs realistas gerados
    create_and_move "logs/realistic" "logs_realistas" "Logs realistas"
    
    # 6. Logs de ataques
    create_and_move "logs/attacks" "logs/attacks" "Logs de ataques"
    
    # 7. Logs de diferentes serviços
    create_and_move "logs/services" "logs/apache" "Logs Apache"
    create_and_move "logs/services" "logs/nginx" "Logs Nginx"
    create_and_move "logs/services" "logs/mysql" "Logs MySQL"
    create_and_move "logs/services" "logs/openssh" "Logs SSH"
    create_and_move "logs/services" "logs/fail2ban" "Logs Fail2ban"
    create_and_move "logs/services" "logs/auth" "Logs de autenticação"
    create_and_move "logs/services" "logs/cron" "Logs Cron"
    create_and_move "logs/services" "logs/dns" "Logs DNS"
    create_and_move "logs/services" "logs/docker" "Logs Docker"
    create_and_move "logs/services" "logs/haproxy" "Logs HAProxy"
    create_and_move "logs/services" "logs/iptables" "Logs iptables"
    create_and_move "logs/services" "logs/letsencrypt" "Logs Let's Encrypt"
    create_and_move "logs/services" "logs/mail" "Logs de email"
    create_and_move "logs/services" "logs/node_pm2" "Logs Node.js"
    create_and_move "logs/services" "logs/openvpn" "Logs OpenVPN"
    create_and_move "logs/services" "logs/php_fpm" "Logs PHP-FPM"
    create_and_move "logs/services" "logs/redis" "Logs Redis"
    create_and_move "logs/services" "logs/sys" "Logs do sistema"
    create_and_move "logs/services" "logs/ufw" "Logs UFW"
    create_and_move "logs/services" "logs/varnish" "Logs Varnish"
    create_and_move "logs/services" "logs/vsftpd" "Logs vsftpd"
    
    # 8. Dados e CSV
    create_and_move "data" "*.csv" "Arquivos CSV"
    create_and_move "data" "payloads_patterns.csv" "Padrões de payload"
    create_and_move "data" "exported_patterns_*.csv" "Padrões exportados"
    
    # 9. Resultados de testes
    create_and_move "results" "resultados_*" "Resultados de testes"
    create_and_move "results" "resultados_performance_*" "Resultados de performance"
    
    # 10. Documentação
    create_and_move "docs" "*.md" "Documentação"
    create_and_move "docs" "README.md" "README"
    create_and_move "docs" "ANALISE_RESULTADOS_TESTE.md" "Análise de resultados"
    create_and_move "docs" "COMANDOS_WSL.md" "Comandos WSL"
    create_and_move "docs" "DOCUMENTACAO_SISTEMA_ANALISE.md" "Documentação do sistema"
    create_and_move "docs" "FLUXO_SISTEMA_TREINAMENTO.md" "Fluxo de treinamento"
    create_and_move "docs" "MELHORIAS_LOGICAS_PONTUACAO.md" "Melhorias de pontuação"
    create_and_move "docs" "MELHORIAS_v4.0.md" "Melhorias v4.0"
    
    # 11. Payloads e padrões
    create_and_move "payloads" "sql-injection-payload-list" "Lista de payloads SQL"
    create_and_move "payloads" "xsspayloads.txt" "Payloads XSS"
    
    # 12. Históricos e logs de sistema
    create_and_move "system" "import_history.log" "Histórico de importação"
    create_and_move "system" "training_history.log" "Histórico de treinamento"
    create_and_move "system" "logs_analise.txt" "Logs de análise"
    
    # 13. Arquivos temporários e de teste
    create_and_move "temp" "teste_*.txt" "Arquivos de teste temporários"
    create_and_move "temp" "teste_*.sh" "Scripts de teste temporários"
    
    # 14. Exemplos e templates
    create_and_move "examples" "exemplo_*.txt" "Arquivos de exemplo"
    create_and_move "examples" "xss_padrao_cadastro_lot.md" "Exemplo de cadastro"
    
    echo ""
    log "${BOLD}📋 CRIANDO ARQUIVOS DE CONFIGURAÇÃO...${RESET}"
    
    # Criar .gitignore
    cat > .gitignore << 'EOF'
# Arquivos temporários
temp/
*.tmp
*.temp

# Logs de sistema
system/*.log
*.log.bak

# Resultados de testes
results/
resultados_*/

# Backup
backup_*/

# Logs realistas (podem ser regenerados)
logs/realistic/

# Arquivos de configuração sensíveis
config/secrets.conf
config/api_keys.conf

# Arquivos de desenvolvimento
*.swp
*.swo
*~

# Arquivos do sistema
.DS_Store
Thumbs.db
EOF

    # Criar README da estrutura
    cat > ESTRUTURA_PROJETO.md << 'EOF'
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
EOF

    # Criar script de navegação rápida
    cat > navegar_projeto.sh << 'EOF'
#!/bin/bash

# ===================================================================================
# NAVEGADOR RÁPIDO DO PROJETO
# ===================================================================================

# Cores
GREEN="\e[32m"
CYAN="\e[36m"
BOLD="\e[1m"
RESET="\e[0m"

echo -e "${BOLD}${CYAN}🗂️  NAVEGADOR RÁPIDO DO PROJETO${RESET}"
echo -e "${BOLD}${CYAN}================================${RESET}"
echo ""

echo -e "${BOLD}📁 DIRETÓRIOS PRINCIPAIS:${RESET}"
echo -e "${GREEN}src/scripts/${RESET}     - Scripts principais do sistema"
echo -e "${GREEN}tests/${RESET}           - Scripts de teste"
echo -e "${GREEN}config/${RESET}          - Configurações"
echo -e "${GREEN}logs/${RESET}            - Todos os logs organizados"
echo -e "${GREEN}data/${RESET}            - Dados e CSV"
echo -e "${GREEN}results/${RESET}         - Resultados de testes"
echo -e "${GREEN}docs/${RESET}            - Documentação"
echo -e "${GREEN}payloads/${RESET}        - Payloads de ataque"
echo -e "${GREEN}system/${RESET}          - Logs do sistema"
echo ""

echo -e "${BOLD}🚀 COMANDOS RÁPIDOS:${RESET}"
echo -e "${GREEN}cd src/scripts/${RESET}  - Ir para scripts principais"
echo -e "${GREEN}cd tests/${RESET}        - Ir para testes"
echo -e "${GREEN}cd logs/realistic/${RESET} - Ver logs realistas"
echo -e "${GREEN}cd results/${RESET}      - Ver resultados"
echo -e "${GREEN}cd docs/${RESET}         - Ver documentação"
echo ""

echo -e "${BOLD}📋 COMANDOS ÚTEIS:${RESET}"
echo -e "${GREEN}ls -la src/scripts/${RESET}     - Listar scripts principais"
echo -e "${GREEN}ls -la logs/realistic/${RESET}  - Listar logs realistas"
echo -e "${GREEN}ls -la results/${RESET}         - Listar resultados"
echo -e "${GREEN}cat docs/README.md${RESET}      - Ver README"
echo ""
EOF

    chmod +x navegar_projeto.sh
    
    echo ""
    log "${BOLD}${GREEN}🎉 ESTRUTURA ORGANIZADA COM SUCESSO!${RESET}"
    echo ""
    log "${BOLD}📁 ESTRUTURA CRIADA:${RESET}"
    log "  📂 src/scripts/     - Scripts principais"
    log "  📂 tests/           - Scripts de teste"
    log "  📂 config/          - Configurações"
    log "  📂 logs/            - Logs organizados"
    log "  📂 data/            - Dados e CSV"
    log "  📂 results/         - Resultados"
    log "  📂 docs/            - Documentação"
    log "  📂 payloads/        - Payloads"
    log "  📂 system/          - Logs do sistema"
    log "  📂 temp/            - Arquivos temporários"
    log "  📂 examples/        - Exemplos"
    echo ""
    log "${BOLD}📋 ARQUIVOS CRIADOS:${RESET}"
    log "  📄 .gitignore       - Ignorar arquivos desnecessários"
    log "  📄 ESTRUTURA_PROJETO.md - Documentação da estrutura"
    log "  📄 navegar_projeto.sh   - Navegador rápido"
    echo ""
    log "${BOLD}💡 PRÓXIMOS PASSOS:${RESET}"
    log "  1. Verificar a estrutura: bash navegar_projeto.sh"
    log "  2. Testar scripts: cd tests/ && bash testes_wsl.sh"
    log "  3. Ver documentação: cd docs/ && cat README.md"
    log "  4. Configurar sistema: cd config/"
    echo ""
    log "${BOLD}🔧 COMANDOS ÚTEIS:${RESET}"
    log "  tree .               # Ver estrutura completa"
    log "  find . -name '*.sh'  # Encontrar todos os scripts"
    log "  du -sh */           # Ver tamanho dos diretórios"
}

# Executar função principal
main "$@" 