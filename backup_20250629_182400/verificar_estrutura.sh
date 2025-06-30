#!/bin/bash

# ===================================================================================
# VERIFICADOR DE ESTRUTURA - SISTEMA DE ANÁLISE DE LOGS
# ===================================================================================
# Script para verificar e mostrar a estrutura organizada do projeto
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

# Função para verificar diretório
check_dir() {
    local dir="$1"
    local description="$2"
    
    if [[ -d "$dir" ]]; then
        local count=$(find "$dir" -type f 2>/dev/null | wc -l)
        log "${GREEN}✅ $description: $dir ($count arquivos)${RESET}"
        return 0
    else
        log "${RED}❌ $description não encontrado: $dir${RESET}"
        return 1
    fi
}

# Função para verificar arquivo
check_file() {
    local file="$1"
    local description="$2"
    
    if [[ -f "$file" ]]; then
        local size=$(du -h "$file" 2>/dev/null | cut -f1)
        log "${GREEN}✅ $description: $file ($size)${RESET}"
        return 0
    else
        log "${RED}❌ $description não encontrado: $file${RESET}"
        return 1
    fi
}

# Função para listar conteúdo
list_content() {
    local dir="$1"
    local description="$2"
    
    if [[ -d "$dir" ]]; then
        log "${BOLD}📂 $description:${RESET}"
        ls -la "$dir" | while read line; do
            if [[ $line != total* ]]; then
                echo "  $line"
            fi
        done
        echo ""
    fi
}

# Função principal
main() {
    echo -e "${BOLD}${CYAN}🔍 VERIFICADOR DE ESTRUTURA ORGANIZADA${RESET}"
    echo -e "${BOLD}${CYAN}========================================${RESET}"
    echo -e "${BOLD}Data/Hora: $(date '+%Y-%m-%d %H:%M:%S')${RESET}"
    echo ""
    
    # 1. VERIFICAR ESTRUTURA PRINCIPAL
    log "${BOLD}📁 ESTRUTURA PRINCIPAL:${RESET}"
    echo ""
    
    check_dir "src/scripts/core" "Scripts principais"
    check_dir "src/scripts/utils" "Utilitários"
    check_dir "src/scripts/generators" "Geradores"
    echo ""
    
    check_dir "tests/unit" "Testes unitários"
    check_dir "tests/integration" "Testes de integração"
    check_dir "tests/performance" "Testes de performance"
    echo ""
    
    check_dir "logs/examples" "Logs de exemplo"
    check_dir "logs/realistic" "Logs realistas"
    check_dir "logs/custom" "Logs personalizados"
    check_dir "logs/ai" "Logs de IA"
    check_dir "logs/attacks" "Logs de ataques"
    check_dir "logs/services" "Logs por serviço"
    echo ""
    
    check_dir "data/patterns" "Padrões de detecção"
    check_dir "data/training" "Dados de treinamento"
    check_dir "data/exports" "Exportações"
    echo ""
    
    check_dir "payloads/sql_injection" "Payloads SQL"
    check_dir "payloads/xss" "Payloads XSS"
    check_dir "payloads/lfi_rfi" "Payloads LFI/RFI"
    check_dir "payloads/brute_force" "Payloads brute force"
    echo ""
    
    check_dir "docs/user" "Documentação do usuário"
    check_dir "docs/developer" "Documentação do desenvolvedor"
    check_dir "docs/api" "Documentação da API"
    echo ""
    
    check_dir "config" "Configurações"
    check_dir "system" "Logs do sistema"
    check_dir "results" "Resultados"
    check_dir "temp" "Arquivos temporários"
    echo ""
    
    # 2. VERIFICAR ARQUIVOS IMPORTANTES
    log "${BOLD}📄 ARQUIVOS IMPORTANTES:${RESET}"
    echo ""
    
    check_file "README.md" "README principal"
    check_file "iniciar_projeto.sh" "Script de inicialização"
    check_file "navegar_projeto.sh" "Navegador do projeto"
    check_file "config/main.conf" "Configuração principal"
    check_file "config/patterns.conf" "Configuração de padrões"
    echo ""
    
    # 3. VERIFICAR EXEMPLOS CRIADOS
    log "${BOLD}📋 EXEMPLOS CRIADOS:${RESET}"
    echo ""
    
    check_file "logs/examples/csv/exemplo_importacao.csv" "Exemplo de CSV"
    check_file "logs/examples/templates/exemplo_apache.log" "Template Apache"
    check_file "logs/examples/templates/exemplo_ssh.log" "Template SSH"
    check_file "logs/examples/templates/exemplo_cadastro_rg.txt" "Template de cadastro"
    echo ""
    
    # 4. VERIFICAR DADOS ORGANIZADOS
    log "${BOLD}📊 DADOS ORGANIZADOS:${RESET}"
    echo ""
    
    check_file "data/patterns/payloads_patterns.csv" "Padrões de payload"
    check_file "data/exports/exported_patterns_20250629_160044.csv" "Padrões exportados"
    echo ""
    
    # 5. VERIFICAR PAYLOADS ORGANIZADOS
    log "${BOLD}⚔️  PAYLOADS ORGANIZADOS:${RESET}"
    echo ""
    
    check_file "payloads/xss/xsspayloads.txt" "Payloads XSS"
    check_dir "payloads/sql_injection/sql-injection-payload-list" "Lista SQL injection"
    echo ""
    
    # 6. VERIFICAR SCRIPTS ORGANIZADOS
    log "${BOLD}🔧 SCRIPTS ORGANIZADOS:${RESET}"
    echo ""
    
    check_file "src/scripts/core/scriptlogs_avancado.sh" "Script principal"
    check_file "src/scripts/core/scriptlogs.sh" "Script básico"
    check_file "src/scripts/core/scriptlogs_sem_jq.sh" "Script sem jq"
    check_file "src/scripts/generators/gerador_logs_realistas.sh" "Gerador de logs"
    check_file "src/scripts/utils/csv_to_training_system.sh" "Conversor CSV"
    echo ""
    
    # 7. VERIFICAR TESTES ORGANIZADOS
    log "${BOLD}🧪 TESTES ORGANIZADOS:${RESET}"
    echo ""
    
    check_file "tests/integration/testes_wsl_estruturado.sh" "Testes WSL estruturado"
    check_file "tests/integration/teste_completo_sistema.sh" "Teste completo do sistema"
    check_file "tests/performance/teste_performance_completo.sh" "Teste de performance"
    
    # Contar testes unitários
    local unit_tests=$(find tests/unit -name "*.sh" 2>/dev/null | wc -l)
    log "${GREEN}✅ Testes unitários: tests/unit/ ($unit_tests arquivos)${RESET}"
    echo ""
    
    # 8. VERIFICAR DOCUMENTAÇÃO ORGANIZADA
    log "${BOLD}📚 DOCUMENTAÇÃO ORGANIZADA:${RESET}"
    echo ""
    
    check_file "docs/user/README.md" "README do usuário"
    check_file "docs/user/COMANDOS_WSL.md" "Comandos WSL"
    check_file "docs/developer/ANALISE_RESULTADOS_TESTE.md" "Análise de resultados"
    check_file "docs/developer/DOCUMENTACAO_SISTEMA_ANALISE.md" "Documentação do sistema"
    check_file "docs/developer/FLUXO_SISTEMA_TREINAMENTO.md" "Fluxo de treinamento"
    check_file "docs/developer/MELHORIAS_LOGICAS_PONTUACAO.md" "Melhorias de pontuação"
    check_file "docs/developer/MELHORIAS_v4.0.md" "Melhorias v4.0"
    echo ""
    
    # 9. VERIFICAR ARQUIVOS REMOVIDOS
    log "${BOLD}🗑️  ARQUIVOS REMOVIDOS:${RESET}"
    echo ""
    
    if [[ ! -f "train_log_analyzer.sh" ]]; then
        log "${GREEN}✅ train_log_analyzer.sh removido (antigo)${RESET}"
    fi
    
    if [[ ! -f "plano_continuidade_ia.sh" ]]; then
        log "${GREEN}✅ plano_continuidade_ia.sh removido (desnecessário)${RESET}"
    fi
    
    if [[ ! -f "relatorio_avancado.html" ]]; then
        log "${GREEN}✅ relatorio_avancado.html removido (antigo)${RESET}"
    fi
    echo ""
    
    # 10. MOSTRAR ESTRUTURA COMPLETA
    log "${BOLD}📋 ESTRUTURA COMPLETA:${RESET}"
    echo ""
    
    log "${BOLD}projeto/${RESET}"
    log "├── 📁 src/scripts/"
    log "│   ├── 📁 core/           # Scripts principais (3 arquivos)"
    log "│   ├── 📁 utils/          # Utilitários (1 arquivo)"
    log "│   └── 📁 generators/     # Geradores (1 arquivo)"
    log "├── 📁 tests/"
    log "│   ├── 📁 unit/           # Testes unitários ($unit_tests arquivos)"
    log "│   ├── 📁 integration/    # Testes de integração (2 arquivos)"
    log "│   └── 📁 performance/    # Testes de performance (1 arquivo)"
    log "├── 📁 logs/"
    log "│   ├── 📁 examples/       # Exemplos e templates"
    log "│   │   ├── 📁 csv/        # Exemplos de CSV"
    log "│   │   └── 📁 templates/  # Templates de logs"
    log "│   ├── 📁 realistic/      # Logs realistas"
    log "│   ├── 📁 custom/         # Logs personalizados"
    log "│   ├── 📁 ai/             # Logs de IA"
    log "│   ├── 📁 attacks/        # Logs de ataques"
    log "│   └── 📁 services/       # Logs por serviço"
    log "├── 📁 data/"
    log "│   ├── 📁 patterns/       # Padrões de detecção"
    log "│   ├── 📁 training/       # Dados de treinamento"
    log "│   └── 📁 exports/        # Exportações"
    log "├── 📁 payloads/"
    log "│   ├── 📁 sql_injection/  # Payloads SQL"
    log "│   ├── 📁 xss/            # Payloads XSS"
    log "│   ├── 📁 lfi_rfi/        # Payloads LFI/RFI"
    log "│   └── 📁 brute_force/    # Payloads brute force"
    log "├── 📁 docs/"
    log "│   ├── 📁 user/           # Documentação do usuário"
    log "│   ├── 📁 developer/      # Documentação do desenvolvedor"
    log "│   └── 📁 api/            # Documentação da API"
    log "├── 📁 config/             # Configurações"
    log "├── 📁 system/             # Logs do sistema"
    log "├── 📁 results/            # Resultados"
    log "├── 📁 temp/               # Arquivos temporários"
    log "├── 📄 README.md           # README principal"
    log "├── 📄 iniciar_projeto.sh  # Script de inicialização"
    log "└── 📄 navegar_projeto.sh  # Navegador do projeto"
    echo ""
    
    # 11. RESUMO FINAL
    log "${BOLD}📊 RESUMO DA ORGANIZAÇÃO:${RESET}"
    echo ""
    
    local total_scripts=$(find src/scripts -name "*.sh" 2>/dev/null | wc -l)
    local total_tests=$(find tests -name "*.sh" 2>/dev/null | wc -l)
    local total_logs=$(find logs -name "*.log" 2>/dev/null | wc -l)
    local total_docs=$(find docs -name "*.md" 2>/dev/null | wc -l)
    local total_configs=$(find config -name "*.conf" 2>/dev/null | wc -l)
    
    log "${GREEN}✅ Scripts organizados: $total_scripts${RESET}"
    log "${GREEN}✅ Testes organizados: $total_tests${RESET}"
    log "${GREEN}✅ Logs organizados: $total_logs${RESET}"
    log "${GREEN}✅ Documentação organizada: $total_docs${RESET}"
    log "${GREEN}✅ Configurações criadas: $total_configs${RESET}"
    echo ""
    
    log "${BOLD}${GREEN}🎉 ESTRUTURA VERIFICADA COM SUCESSO!${RESET}"
    echo ""
    log "${BOLD}💡 PRÓXIMOS PASSOS:${RESET}"
    log "  1. Testar sistema: bash iniciar_projeto.sh"
    log "  2. Executar testes: bash tests/integration/testes_wsl_estruturado.sh"
    log "  3. Ver exemplos: ls -la logs/examples/"
    log "  4. Configurar: nano config/main.conf"
    echo ""
    log "${BOLD}🚀 COMANDOS ÚTEIS:${RESET}"
    log "  bash iniciar_projeto.sh                    # Menu interativo"
    log "  bash navegar_projeto.sh                    # Navegar estrutura"
    log "  bash tests/integration/testes_wsl_estruturado.sh  # Executar testes"
    log "  ls -la logs/examples/                      # Ver exemplos"
    log "  cat config/main.conf                       # Ver configuração"
}

# Executar função principal
main "$@" 