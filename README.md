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

# LOG ANALYZER PRO v5.0

Sistema avançado de análise de logs de segurança com inteligência artificial e aprendizado contínuo.

## 🚀 Sobre o Projeto

O **LOG ANALYZER PRO v5.0** é uma ferramenta completa para análise de logs de segurança, desenvolvida com foco em:

- **Detecção Inteligente**: Sistema de aprendizado contínuo para identificar novos padrões de ataque
- **Análise Temporal**: Correlação de eventos distribuídos no tempo
- **Classificação Comportamental**: Identificação de comportamentos anômalos
- **Pontuação Adaptativa**: Sistema que se adapta ao contexto e ambiente
- **Portabilidade**: Compatível com Windows (WSL), Kali Linux e Ubuntu

## 👨‍💻 Autor

**Jackson A Z Savoldi**
- **LinkedIn**: [linkedin.com/in/jacksonzacarias](https://linkedin.com/in/jacksonzacarias)
- **Instagram**: [@jacksonsavoldi](https://instagram.com/jacksonsavoldi)
- **Formação**: Sistemas de Informação - UNIPAR Paranavaí
- **Especialização**: Segurança da Informação

## 📋 Funcionalidades

### 🔍 Análise Avançada
- Detecção de 86+ padrões de ataque
- Análise temporal de eventos
- Correlação de múltiplos logs
- Classificação por severidade (Crítico, Alto, Médio, Baixo)

### 🧠 Inteligência Artificial
- Aprendizado contínuo de padrões
- Adaptação automática de pontuações
- Detecção de variações de ataques
- Análise comportamental

### 🔧 Sistema Modular
- Arquitetura modular e extensível
- Módulos de inteligência, lógica, análise e saída
- Sistema de regras customizáveis
- Plugins para diferentes tipos de log

### 🌐 Portabilidade
- Compatível com Windows (WSL)
- Suporte completo para Kali Linux
- Detecção automática de ambiente
- Configuração dinâmica de caminhos

## 🛠️ Instalação

### Pré-requisitos
- Bash (WSL no Windows)
- grep, sed, awk, jq, bc
- Git

### Instalação Rápida
```bash
# Clone o repositório
git clone <repository-url>
cd logs

# Execute o script de inicialização
bash iniciar_projeto.sh

# Para preparar ambiente VM
bash preparar_vm.sh
```

## 📖 Uso

### Análise Básica
```bash
# Análise interativa (seletor de arquivos)
bash analisar_logs.sh

# Análise de arquivo específico
bash analisar_logs.sh caminho/para/log.txt
```

### Navegação no Projeto
```bash
# Navegar pela estrutura
bash navegar_projeto.sh

# Verificar estrutura
bash scripts/verificar_estrutura.sh
```

## 📊 Estatísticas Atuais

- **Padrões de Ataque**: 86 padrões carregados
- **Distribuição por Severidade**:
  - Crítico: 17 padrões
  - Alto: 46 padrões
  - Médio: 12 padrões
  - Baixo: 10 padrões

## 🏗️ Arquitetura

```
src/
├── modules/
│   ├── intelligence/          # Módulos de IA
│   ├── logic/                 # Motor de regras
│   ├── analysis/              # Análise avançada
│   └── output/                # Geração de relatórios
├── scripts/
│   ├── core/                  # Scripts principais
│   ├── utils/                 # Utilitários
│   └── generators/            # Geradores de dados
└── tests/                     # Testes automatizados
```

## 🔒 Licenciamento

Este projeto está protegido por direitos autorais. Para uso comercial ou empresarial, entre em contato:

- **LinkedIn**: [linkedin.com/in/jacksonzacarias](https://linkedin.com/in/jacksonzacarias)
- **Instagram**: [@jacksonsavoldi](https://instagram.com/jacksonsavoldi)

### Uso Permitido
- Uso pessoal para fins educacionais
- Uso acadêmico em projetos de pesquisa
- Demonstrações em ambiente controlado

### Uso Proibido
- Comercialização sem autorização
- Redistribuição sem permissão
- Modificação para fins maliciosos
- Remoção de cabeçalhos de autoria

## 🧪 Testes

```bash
# Testes de compatibilidade
bash tests/compatibility/test_environment_detector.sh

# Testes de portabilidade
bash teste_portabilidade.sh

# Validação de configuração
bash src/scripts/utils/config_loader.sh validate
```

## 📈 Roadmap

### v5.1 - Módulos de Inteligência
- [ ] Pattern Learner
- [ ] Temporal Analyzer
- [ ] Behavior Classifier
- [ ] Adaptive Scoring

### v5.2 - Motor de Regras
- [ ] Rule Engine
- [ ] Custom Rules
- [ ] Sistema de Prioridades

### v5.3 - Análise Avançada
- [ ] Análise Temporal
- [ ] Análise Comportamental
- [ ] Análise de Payloads

## 🤝 Contribuição

Para contribuições ou sugestões, entre em contato via LinkedIn ou Instagram.

## 📞 Suporte

- **LinkedIn**: [linkedin.com/in/jacksonzacarias](https://linkedin.com/in/jacksonzacarias)
- **Instagram**: [@jacksonsavoldi](https://instagram.com/jacksonsavoldi)

---

**Desenvolvido com ❤️ por Jackson A Z Savoldi**

*Sistemas de Informação - UNIPAR Paranavaí*
*Especialização em Segurança da Informação* 