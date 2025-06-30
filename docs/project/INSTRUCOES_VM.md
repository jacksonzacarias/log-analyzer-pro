# ==============================================================================
# PROJETO: LOG ANALYZER PRO v5.0
# ==============================================================================
# Autor: Jackson A Z Savoldi
# Data: 2024-06-29
# LinkedIn: linkedin.com/in/jacksonzacarias
# Instagram: @jacksonsavoldi
# Formação: Sistemas de Informação - UNIPAR Paranavaí
# Especialização: Segurança da Informação
# ==============================================================================
# Direitos reservados. Proibido uso, cópia ou redistribuição sem autorização.
# ==============================================================================

# INSTRUÇÕES PARA USO NA VM DO KALI LINUX

## Pré-requisitos
- Kali Linux instalado no VirtualBox
- Git instalado: `sudo apt update && sudo apt install git`
- Ferramentas básicas: `sudo apt install curl wget jq`

## Passos para configuração

### 1. Clonar ou copiar o projeto
```bash
# Se usando git:
git clone <URL_DO_REPOSITORIO>
cd logs

# Se copiando arquivos:
# Copie toda a pasta do projeto para a VM
cd /caminho/para/o/projeto
```

### 2. Configurar permissões
```bash
chmod +x *.sh
chmod +x scripts/*.sh
chmod +x src/scripts/**/*.sh
```

### 3. Executar preparação
```bash
./preparar_vm.sh
```

### 4. Testar o sistema
```bash
./iniciar_projeto.sh
```

### 5. Executar análise de logs
```bash
# Análise básica
./src/scripts/core/scriptlogs.sh

# Análise avançada
./src/scripts/core/scriptlogs_avancado.sh

# Análise sem jq (para sistemas sem jq)
./src/scripts/core/scriptlogs_sem_jq.sh
```

## Estrutura do projeto
```
├── analisar_logs.sh            # Script principal de análise (raiz)
├── iniciar_projeto.sh          # Inicialização do projeto (raiz)
├── navegar_projeto.sh          # Navegação interativa (raiz)
├── preparar_vm.sh              # Preparação de ambiente VM (raiz)
├── teste_portabilidade.sh      # Teste de portabilidade (raiz)
├── docs/
│   └── project/                # Documentação do projeto
├── config/                     # Configurações do sistema
├── system/
│   ├── backup_files/           # Backups automáticos e manuais
│   ├── logs/                   # Logs do sistema
│   └── cache/                  # Cache temporário
├── results/                    # Relatórios e resultados de análise
├── src/scripts/core/           # Scripts internos do sistema
├── analogs/                    # Logs para análise
├── payloads/                   # Payloads de ataque
└── tests/                      # Testes automatizados
```

## Troubleshooting
- Se houver problemas de permissão: `chmod +x *.sh`
- Se faltar jq: `sudo apt install jq`
- Se faltar curl: `sudo apt install curl`
- Para ver logs de erro: `tail -f logs/error.log`

## Comandos úteis
```bash
# Verificar estrutura
./scripts/verificar_estrutura.sh

# Criar estrutura ausente
./scripts/criar_estrutura.sh

# Testar portabilidade
./teste_portabilidade.sh

# Navegar no projeto
./navegar_projeto.sh

# Inicializar sistema
./iniciar_projeto.sh

# Análise interativa
./analisar_logs.sh
```
