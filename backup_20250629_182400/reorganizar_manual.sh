#!/bin/bash

# ===================================================================================
# REORGANIZAÇÃO MANUAL PRECISA - SISTEMA DE ANÁLISE DE LOGS
# ===================================================================================
# Script para reorganização manual mais precisa, removendo arquivos desnecessários
# e organizando melhor a estrutura
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

# Função para verificar e mover arquivos
move_file() {
    local source="$1"
    local dest="$2"
    local description="$3"
    
    if [[ -f "$source" ]]; then
        mkdir -p "$(dirname "$dest")"
        mv "$source" "$dest"
        log "${GREEN}✅ $description movido para $dest${RESET}"
    elif [[ -d "$source" ]]; then
        mkdir -p "$(dirname "$dest")"
        mv "$source" "$dest"
        log "${GREEN}✅ $description movido para $dest${RESET}"
    else
        log "${YELLOW}⚠️  $description não encontrado: $source${RESET}"
    fi
}

# Função para remover arquivos desnecessários
remove_file() {
    local file="$1"
    local description="$2"
    
    if [[ -f "$file" ]]; then
        rm "$file"
        log "${RED}🗑️  $description removido: $file${RESET}"
    elif [[ -d "$file" ]]; then
        rm -rf "$file"
        log "${RED}🗑️  $description removido: $file${RESET}"
    else
        log "${YELLOW}⚠️  $description não encontrado: $file${RESET}"
    fi
}

# Função principal
main() {
    echo -e "${BOLD}${CYAN}🔧 REORGANIZAÇÃO MANUAL PRECISA${RESET}"
    echo -e "${BOLD}${CYAN}================================${RESET}"
    echo -e "${BOLD}Data/Hora: $(date '+%Y-%m-%d %H:%M:%S')${RESET}"
    echo ""
    
    # Backup de segurança
    log "${BOLD}📦 CRIANDO BACKUP DE SEGURANÇA...${RESET}"
    mkdir -p backup_manual_$(date '+%Y%m%d_%H%M%S')
    cp -r * backup_manual_$(date '+%Y%m%d_%H%M%S')/ 2>/dev/null
    log "${GREEN}✅ Backup criado${RESET}"
    echo ""
    
    # 1. CORRIGIR ESTRUTURA DE LOGS
    log "${BOLD}📁 CORRIGINDO ESTRUTURA DE LOGS...${RESET}"
    
    # Mover logs realistas para o local correto
    if [[ -d "logs/realistic/logs_realistas" ]]; then
        move_file "logs/realistic/logs_realistas" "logs/realistic/" "Logs realistas"
        rmdir "logs/realistic/logs_realistas" 2>/dev/null
    fi
    
    # Criar estrutura de logs mais organizada
    mkdir -p "logs/custom"      # Logs personalizados
    mkdir -p "logs/ai"          # Logs de IA/treinamento
    mkdir -p "logs/examples/csv" # Exemplos de CSV
    mkdir -p "logs/examples/templates" # Templates de logs
    
    echo ""
    
    # 2. ORGANIZAR EXEMPLOS
    log "${BOLD}📋 ORGANIZANDO EXEMPLOS...${RESET}"
    
    # Mover exemplo de cadastro para templates
    move_file "examples/exemplo_cadastro_rg.txt" "logs/examples/templates/exemplo_cadastro_rg.txt" "Template de cadastro"
    
    # Criar exemplos de CSV para importação
    cat > "logs/examples/csv/exemplo_importacao.csv" << 'EOF'
# Exemplo de CSV para importação de padrões
# Formato: tipo_ataque,padrao,peso,descricao
sql_injection,UNION SELECT,alto,Injeção SQL UNION SELECT
xss,<script>,medio,Cross-site scripting básico
lfi,../etc/passwd,alto,Local File Inclusion
rfi,http://evil.com,alto,Remote File Inclusion
brute_force,failed password,baixo,Tentativa de força bruta
scanner,nmap,medio,Scanner de rede
EOF

    # Criar exemplo de log Apache
    cat > "logs/examples/templates/exemplo_apache.log" << 'EOF'
# Exemplo de log Apache
192.168.1.100 - - [29/Dec/2024:10:15:30 +0000] "GET / HTTP/1.1" 200 2326
192.168.1.101 - - [29/Dec/2024:10:15:31 +0000] "POST /login.php HTTP/1.1" 302 -
192.168.1.102 - - [29/Dec/2024:10:15:32 +0000] "GET /admin.php?id=1' UNION SELECT 1,2,3-- HTTP/1.1" 500 1234
EOF

    # Criar exemplo de log SSH
    cat > "logs/examples/templates/exemplo_ssh.log" << 'EOF'
# Exemplo de log SSH
Dec 29 10:15:30 server sshd[1234]: Failed password for invalid user admin from 192.168.1.100 port 22 ssh2
Dec 29 10:15:31 server sshd[1235]: Accepted password for user root from 192.168.1.101 port 22 ssh2
Dec 29 10:15:32 server sshd[1236]: Failed password for user admin from 192.168.1.102 port 22 ssh2
EOF

    echo ""
    
    # 3. ORGANIZAR DADOS
    log "${BOLD}📊 ORGANIZANDO DADOS...${RESET}"
    
    # Criar subdivisões de dados
    mkdir -p "data/patterns"    # Padrões de detecção
    mkdir -p "data/training"    # Dados de treinamento
    mkdir -p "data/exports"     # Exportações
    
    # Mover arquivos CSV para locais apropriados
    move_file "data/payloads_patterns.csv" "data/patterns/payloads_patterns.csv" "Padrões de payload"
    move_file "data/exported_patterns_20250629_160044.csv" "data/exports/exported_patterns_20250629_160044.csv" "Padrões exportados"
    
    echo ""
    
    # 4. ORGANIZAR PAYLOADS
    log "${BOLD}⚔️  ORGANIZANDO PAYLOADS...${RESET}"
    
    # Criar subdivisões de payloads
    mkdir -p "payloads/sql_injection"
    mkdir -p "payloads/xss"
    mkdir -p "payloads/lfi_rfi"
    mkdir -p "payloads/brute_force"
    
    # Mover payloads XSS
    move_file "payloads/xsspayloads.txt" "payloads/xss/xsspayloads.txt" "Payloads XSS"
    
    # Mover lista SQL injection
    move_file "sql-injection-payload-list" "payloads/sql_injection/sql-injection-payload-list" "Lista SQL injection"
    
    echo ""
    
    # 5. ORGANIZAR SCRIPTS
    log "${BOLD}🔧 ORGANIZANDO SCRIPTS...${RESET}"
    
    # Criar subdivisões de scripts
    mkdir -p "src/scripts/core"      # Scripts principais
    mkdir -p "src/scripts/utils"     # Utilitários
    mkdir -p "src/scripts/generators" # Geradores
    
    # Mover scripts principais
    move_file "src/scripts/scriptlogs_avancado.sh" "src/scripts/core/scriptlogs_avancado.sh" "Script principal"
    move_file "src/scripts/scriptlogs.sh" "src/scripts/core/scriptlogs.sh" "Script básico"
    move_file "src/scripts/scriptlogs_sem_jq.sh" "src/scripts/core/scriptlogs_sem_jq.sh" "Script sem jq"
    
    # Mover geradores
    move_file "src/scripts/gerador_logs_realistas.sh" "src/scripts/generators/gerador_logs_realistas.sh" "Gerador de logs"
    
    # Mover utilitários
    move_file "src/scripts/csv_to_training_system.sh" "src/scripts/utils/csv_to_training_system.sh" "Conversor CSV"
    
    echo ""
    
    # 6. ORGANIZAR TESTES
    log "${BOLD}🧪 ORGANIZANDO TESTES...${RESET}"
    
    # Criar subdivisões de testes
    mkdir -p "tests/unit"        # Testes unitários
    mkdir -p "tests/integration" # Testes de integração
    mkdir -p "tests/performance" # Testes de performance
    
    # Mover testes de performance
    move_file "tests/teste_performance_completo.sh" "tests/performance/teste_performance_completo.sh" "Teste de performance"
    
    # Mover testes de integração
    move_file "tests/testes_wsl_estruturado.sh" "tests/integration/testes_wsl_estruturado.sh" "Testes WSL estruturado"
    move_file "tests/teste_completo_sistema.sh" "tests/integration/teste_completo_sistema.sh" "Teste completo do sistema"
    
    # Mover testes unitários (testes simples)
    for test_file in tests/teste_*.sh; do
        if [[ -f "$test_file" ]]; then
            move_file "$test_file" "tests/unit/$(basename "$test_file")" "Teste unitário $(basename "$test_file")"
        fi
    done
    
    echo ""
    
    # 7. ORGANIZAR DOCUMENTAÇÃO
    log "${BOLD}📚 ORGANIZANDO DOCUMENTAÇÃO...${RESET}"
    
    # Criar subdivisões de documentação
    mkdir -p "docs/user"         # Documentação do usuário
    mkdir -p "docs/developer"    # Documentação do desenvolvedor
    mkdir -p "docs/api"          # Documentação da API
    
    # Mover documentação do usuário
    move_file "docs/README.md" "docs/user/README.md" "README do usuário"
    move_file "docs/COMANDOS_WSL.md" "docs/user/COMANDOS_WSL.md" "Comandos WSL"
    
    # Mover documentação do desenvolvedor
    move_file "docs/ANALISE_RESULTADOS_TESTE.md" "docs/developer/ANALISE_RESULTADOS_TESTE.md" "Análise de resultados"
    move_file "docs/DOCUMENTACAO_SISTEMA_ANALISE.md" "docs/developer/DOCUMENTACAO_SISTEMA_ANALISE.md" "Documentação do sistema"
    move_file "docs/FLUXO_SISTEMA_TREINAMENTO.md" "docs/developer/FLUXO_SISTEMA_TREINAMENTO.md" "Fluxo de treinamento"
    move_file "docs/MELHORIAS_LOGICAS_PONTUACAO.md" "docs/developer/MELHORIAS_LOGICAS_PONTUACAO.md" "Melhorias de pontuação"
    move_file "docs/MELHORIAS_v4.0.md" "docs/developer/MELHORIAS_v4.0.md" "Melhorias v4.0"
    
    echo ""
    
    # 8. REMOVER ARQUIVOS DESNECESSÁRIOS
    log "${BOLD}🗑️  REMOVENDO ARQUIVOS DESNECESSÁRIOS...${RESET}"
    
    # Arquivos que podem ser removidos (já foram movidos ou são temporários)
    remove_file "train_log_analyzer.sh" "Script antigo de treinamento"
    remove_file "plano_continuidade_ia.sh" "Script de plano de continuidade"
    remove_file "relatorio_avancado.html" "Relatório HTML antigo"
    
    # Remover diretórios vazios
    find . -type d -empty -delete 2>/dev/null
    
    echo ""
    
    # 9. CRIAR ARQUIVOS DE CONFIGURAÇÃO MELHORADOS
    log "${BOLD}⚙️  CRIANDO CONFIGURAÇÕES MELHORADAS...${RESET}"
    
    # Configuração principal
    cat > "config/main.conf" << 'EOF'
# ===================================================================================
# CONFIGURAÇÃO PRINCIPAL - SISTEMA DE ANÁLISE DE LOGS
# ===================================================================================

# Configurações gerais
LOG_LEVEL=INFO
MAX_LOG_SIZE=100MB
BACKUP_RETENTION_DAYS=30

# Configurações de análise
DETECTION_SENSITIVITY=medium
CORRELATION_WINDOW=300
GEO_LOCATION_ENABLED=true

# Configurações de performance
MAX_CONCURRENT_ANALYSIS=4
MEMORY_LIMIT=512MB
TIMEOUT_SECONDS=300

# Configurações de relatório
REPORT_FORMAT=text,html
REPORT_TEMPLATE=default
INCLUDE_STATISTICS=true
EOF

    # Configuração de padrões
    cat > "config/patterns.conf" << 'EOF'
# ===================================================================================
# PADRÕES DE DETECÇÃO - SISTEMA DE ANÁLISE DE LOGS
# ===================================================================================

# SQL Injection
SQL_INJECTION_PATTERNS=UNION SELECT,OR 1=1,OR 1=1--,DROP TABLE,INSERT INTO
SQL_INJECTION_WEIGHT=alto

# XSS (Cross-Site Scripting)
XSS_PATTERNS=<script>,javascript:,onload=,onerror=,alert(
XSS_WEIGHT=medio

# LFI/RFI (Local/Remote File Inclusion)
LFI_PATTERNS=../etc/passwd,../etc/shadow,..\\windows\\system32
RFI_PATTERNS=http://,https://,ftp://,file://
LFI_RFI_WEIGHT=alto

# Brute Force
BRUTE_FORCE_PATTERNS=failed password,invalid user,authentication failure
BRUTE_FORCE_WEIGHT=baixo

# Scanners
SCANNER_PATTERNS=nmap,nikto,sqlmap,dirb,gobuster
SCANNER_WEIGHT=medio
EOF

    echo ""
    
    # 10. CRIAR SCRIPT DE INICIALIZAÇÃO ATUALIZADO
    log "${BOLD}🚀 ATUALIZANDO SCRIPT DE INICIALIZAÇÃO...${RESET}"
    
    # Atualizar caminhos no script de inicialização
    sed -i 's|src/scripts/|src/scripts/core/|g' iniciar_projeto.sh
    sed -i 's|tests/testes_wsl_estruturado.sh|tests/integration/testes_wsl_estruturado.sh|g' iniciar_projeto.sh
    sed -i 's|tests/teste_performance_completo.sh|tests/performance/teste_performance_completo.sh|g' iniciar_projeto.sh
    
    echo ""
    
    # 11. CRIAR README ATUALIZADO
    log "${BOLD}📝 CRIANDO README ATUALIZADO...${RESET}"
    
    cat > "README.md" << 'EOF'
# 🚀 SISTEMA DE ANÁLISE DE LOGS DE SEGURANÇA

## 📋 Visão Geral

Sistema avançado de análise de logs de segurança em Bash com estrutura organizada e profissional.

## 🏗️ Estrutura Organizada

```
projeto/
├── 📁 src/scripts/
│   ├── 📁 core/           # Scripts principais
│   ├── 📁 utils/          # Utilitários
│   └── 📁 generators/     # Geradores
├── 📁 tests/
│   ├── 📁 unit/           # Testes unitários
│   ├── 📁 integration/    # Testes de integração
│   └── 📁 performance/    # Testes de performance
├── 📁 logs/
│   ├── 📁 examples/       # Exemplos e templates
│   ├── 📁 realistic/      # Logs realistas
│   ├── 📁 custom/         # Logs personalizados
│   ├── 📁 ai/             # Logs de IA
│   ├── 📁 attacks/        # Logs de ataques
│   └── 📁 services/       # Logs por serviço
├── 📁 data/
│   ├── 📁 patterns/       # Padrões de detecção
│   ├── 📁 training/       # Dados de treinamento
│   └── 📁 exports/        # Exportações
├── 📁 payloads/
│   ├── 📁 sql_injection/  # Payloads SQL
│   ├── 📁 xss/            # Payloads XSS
│   ├── 📁 lfi_rfi/        # Payloads LFI/RFI
│   └── 📁 brute_force/    # Payloads brute force
├── 📁 docs/
│   ├── 📁 user/           # Documentação do usuário
│   ├── 📁 developer/      # Documentação do desenvolvedor
│   └── 📁 api/            # Documentação da API
└── 📁 config/             # Configurações
```

## 🚀 Início Rápido

```bash
# Menu interativo
bash iniciar_projeto.sh

# Navegar estrutura
bash navegar_projeto.sh

# Executar testes
bash tests/integration/testes_wsl_estruturado.sh
```

## 📋 Funcionalidades

- 🔍 **Análise automática** de logs
- 🎓 **Sistema de aprendizado** contínuo
- 📊 **Relatórios profissionais**
- 🧪 **Testes automatizados**
- ⚙️ **Configuração flexível**

## 🛠️ Como Usar

### Análise de Log
```bash
bash src/scripts/core/scriptlogs_avancado.sh -v -t -aR -gT -pedago -pcn -peso -correl "log_file"
```

### Gerar Logs Realistas
```bash
bash src/scripts/generators/gerador_logs_realistas.sh
```

### Importar Padrões CSV
```bash
bash src/scripts/utils/csv_to_training_system.sh data/patterns/payloads_patterns.csv
```

## 📚 Documentação

- **Usuário**: `docs/user/`
- **Desenvolvedor**: `docs/developer/`
- **API**: `docs/api/`

## 🧪 Testes

- **Unitários**: `tests/unit/`
- **Integração**: `tests/integration/`
- **Performance**: `tests/performance/`

---
**Status**: ✅ Organizado e Pronto para Produção
EOF

    echo ""
    log "${BOLD}${GREEN}🎉 REORGANIZAÇÃO MANUAL CONCLUÍDA!${RESET}"
    echo ""
    log "${BOLD}📁 NOVA ESTRUTURA CRIADA:${RESET}"
    log "  📂 src/scripts/core/     - Scripts principais"
    log "  📂 src/scripts/utils/    - Utilitários"
    log "  📂 src/scripts/generators/ - Geradores"
    log "  📂 tests/unit/           - Testes unitários"
    log "  📂 tests/integration/    - Testes de integração"
    log "  📂 tests/performance/    - Testes de performance"
    log "  📂 logs/examples/csv/    - Exemplos de CSV"
    log "  📂 logs/examples/templates/ - Templates de logs"
    log "  📂 logs/custom/          - Logs personalizados"
    log "  📂 logs/ai/              - Logs de IA"
    log "  📂 data/patterns/        - Padrões de detecção"
    log "  📂 data/training/        - Dados de treinamento"
    log "  📂 data/exports/         - Exportações"
    log "  📂 payloads/sql_injection/ - Payloads SQL"
    log "  📂 payloads/xss/         - Payloads XSS"
    log "  📂 docs/user/            - Documentação do usuário"
    log "  📂 docs/developer/       - Documentação do desenvolvedor"
    log "  📂 config/main.conf      - Configuração principal"
    log "  📂 config/patterns.conf  - Configuração de padrões"
    echo ""
    log "${BOLD}🗑️  ARQUIVOS REMOVIDOS:${RESET}"
    log "  ❌ train_log_analyzer.sh (antigo)"
    log "  ❌ plano_continuidade_ia.sh (desnecessário)"
    log "  ❌ relatorio_avancado.html (antigo)"
    echo ""
    log "${BOLD}💡 PRÓXIMOS PASSOS:${RESET}"
    log "  1. Verificar nova estrutura: bash navegar_projeto.sh"
    log "  2. Testar scripts: bash tests/integration/testes_wsl_estruturado.sh"
    log "  3. Configurar sistema: nano config/main.conf"
    log "  4. Ver exemplos: ls -la logs/examples/"
}

# Executar função principal
main "$@" 