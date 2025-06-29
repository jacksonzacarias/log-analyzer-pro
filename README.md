# 🔍 Script Avançado de Análise de Logs de Segurança

[![ACADe-TI](https://img.shields.io/badge/ACADe--TI-Aula%2004-blue)](https://github.com/jacksonsavoldi)
[![Bash](https://img.shields.io/badge/Bash-Script-green)](https://www.gnu.org/software/bash/)
[![Security](https://img.shields.io/badge/Security-Analysis-red)](https://github.com/jacksonsavoldi)

> **Ferramenta completa para análise de logs de segurança com detecção automática de ameaças, classificação por peso, correlação de eventos e recomendações de continuidade de negócios.**

## 📋 Informações do Projeto

- **Autor:** Jackson Savoldi
- **Professor:** Erick Martinez
- **Curso:** ACADe-TI - Aula 04 (28/06/2025)
- **Versão:** 4.0
- **Licença:** MIT

---

## 🚀 Funcionalidades Principais

### 🔍 Detecção Automática de Ameaças
- **Multi-formato**: Suporte a Apache, SSH, MySQL, Nginx e logs customizados
- **Classificação por peso**: Sistema de pontuação para categorização de ameaças
- **Detecção inteligente**: Padrões avançados para identificar comportamentos suspeitos

### 📊 Análise Avançada
- **Análise linha por linha**: Processamento detalhado de cada entrada
- **Correlação de eventos**: Identificação de padrões de comportamento
- **Análise temporal**: Timeline cronológica de eventos
- **Score de risco**: Cálculo automático do nível de risco do sistema

### 🛡️ Recursos de Segurança
- **Geolocalização**: Identificação de origem de IPs suspeitos
- **Recomendações**: Sugestões automáticas de ações defensivas
- **Plano de continuidade**: Análise de impacto e recomendações de recuperação
- **Modo pedagógico**: Explicações detalhadas para aprendizado

---

## 📦 Instalação

### Pré-requisitos

```bash
# Dependências necessárias
sudo apt-get update
sudo apt-get install -y grep awk sed sort uniq curl jq
```

### Download

```bash
# Clone o repositório
git clone https://github.com/jacksonsavoldi/scriptlogs-avancado.git
cd scriptlogs-avancado

# Torne o script executável
chmod +x scriptlogs_avancado.sh
```

---

## 🎯 Uso Rápido

### Análise Básica
```bash
./scriptlogs_avancado.sh -v logs.log
```

### Análise Completa
```bash
./scriptlogs_avancado.sh -v -t -aR -gT -pedago -pcn -peso -correl -r relatorio.html logs.log
```

### Modo Pedagógico
```bash
./scriptlogs_avancado.sh -v -pedago apache_access.log
```

---

## 📖 Opções Disponíveis

| Opção | Descrição |
|-------|-----------|
| `-v` | Verboso (detalha tudo no terminal) |
| `-t` | Explica IPs TEST-NET e geolocaliza externos |
| `-aR` | Sugestões automáticas de ações defensivas |
| `-gT` | Gera timeline cronológica por IP |
| `-pedago` | Modo pedagógico (explicações extra) |
| `-pcn` | Gera seção Plano de Continuidade de Negócios |
| `-peso` | Análise por peso de ameaça |
| `-correl` | Correlação de eventos por usuário/IP |
| `-r <file>` | Nome do relatório HTML |
| `-h, --help` | Exibe ajuda detalhada |

---

## 🎨 Sistema de Classificação

### 📊 Estrutura de Pontuação

| Nível | Pontos | Descrição |
|-------|--------|-----------|
| 🔴 **CRÍTICO** | 10+ | Ameaças graves que comprometem a segurança |
| 🟣 **ALTO** | 7-9 | Ameaças significativas que requerem atenção |
| 🟡 **MÉDIO** | 4-6 | Ameaças moderadas que devem ser monitoradas |
| 🔵 **BAIXO** | 1-3 | Atividades suspeitas de baixo impacto |
| 🟢 **INFO** | 0 | Atividades normais do sistema |

### 🚨 Padrões Detectados

#### 🔴 CRÍTICO (10 pontos)
- Reverse Shell: `shell.php`, `backdoor`
- Command Injection: `Comando injetado`, `cat /flag`
- Malicious Commands: `ls;.*cat`, `rm -rf`

#### 🟣 ALTO (7 pontos)
- Web Attacks: `SQL Injection`, `XSS`, `LFI`, `RFI`
- Brute Force: `Força bruta`, `Invalid user`
- Sensitive Files: `Download arquivo:.*senha`, `Download arquivo:.*secret`
- Path Traversal: `../../etc/passwd`

#### 🟡 MÉDIO (4 pontos)
- Authentication Issues: `Login falha`, `Erro de permissão`
- Port Scanning: `Port Scan`, `Enumeration`

#### 🔵 BAIXO (1 ponto)
- File Operations: `Upload arquivo`, `Download arquivo`
- Database Queries: `Consulta registro`

---

## 📊 Exemplo de Saída

```
🔍 ANÁLISE AVANÇADA DE LOGS DE SEGURANÇA E CONTINUIDADE DE NEGÓCIOS
================================================================

📋 Análise Linha por Linha - Classificação por Peso
==================================================
Linha  | Timestamp           | IP              | Usuário     | Peso  | Nível   | Ação
--------------------------------------------------------------------------------------------------------
1      | 2025-06-25 09:00:00 | 192.168.1.1     | user1       | 14    | CRÍTICO | SQL Injection detectada
    ➔ Ameaças detectadas: SQL Injection : 7pts Erro 403 : 7pts
--------------------------------------------------------------------------------------------------------

📊 Estatísticas Detalhadas
=====================
📈 Distribuição por Nível de Ameaça:
  🔴 CRÍTICO: 3 eventos
  🟣 ALTO: 7 eventos
  🟡 MÉDIO: 12 eventos
  🔵 BAIXO: 25 eventos
  🟢 INFO: 8 eventos
  📊 TOTAL: 55 eventos

🎯 Score de Risco Geral: 156 pontos
🚨 ALERTA: Sistema em alto risco!
```

---

## 🔧 Dependências

- **grep**: Busca de padrões
- **awk**: Processamento de texto
- **sed**: Edição de texto
- **sort**: Ordenação
- **uniq**: Remoção de duplicatas
- **curl**: Requisições HTTP
- **jq**: Processamento JSON

---

## 📁 Estrutura do Projeto

```
scriptlogs-avancado/
├── scriptlogs_avancado.sh          # Script principal
├── DOCUMENTACAO_SISTEMA_ANALISE.md # Documentação técnica
├── README.md                       # Este arquivo
├── logs/                           # Exemplos de logs
│   ├── apache/
│   ├── nginx/
│   ├── ssh/
│   └── mysql/
└── relatorios/                     # Relatórios gerados
```

---

## 🧪 Testes

### Teste Básico
```bash
# Teste com arquivo de exemplo
./scriptlogs_avancado.sh -v -pedago logs_analise.txt
```

### Teste Completo
```bash
# Teste com todas as funcionalidades
./scriptlogs_avancado.sh -v -t -aR -gT -pedago -pcn -peso -correl -r teste.html logs_analise.txt
```

---

## 📈 Score de Risco

### 🎯 Cálculo
```
SCORE = (CRÍTICO × 10) + (ALTO × 7) + (MÉDIO × 4) + (BAIXO × 1)
```

### 🚨 Classificação
- **Score ≥ 50**: 🚨 **ALERTA - Sistema em alto risco!**
- **Score ≥ 20**: ⚠️ **ATENÇÃO - Sistema em risco moderado**
- **Score < 20**: ✅ **Sistema em risco baixo**

---

## 🚀 Melhorias Futuras

- [ ] Detecção de padrões mais avançados
- [ ] Machine Learning para classificação
- [ ] Integração com SIEM
- [ ] Dashboard web interativo
- [ ] Alertas em tempo real
- [ ] Análise de logs em lote
- [ ] Suporte a mais formatos de log

---

## 🤝 Contribuição

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

---

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---

## 👨‍💻 Autor

**Jackson Savoldi**
- **Professor:** Erick Martinez
- **Curso:** ACADe-TI - Aula 04 (28/06/2025)
- **Email:** [seu-email@exemplo.com]
- **GitHub:** [@jacksonsavoldi](https://github.com/jacksonsavoldi)

---

## 🙏 Agradecimentos

- Professor Erick Martinez pela orientação
- ACADe-TI pelo suporte educacional
- Comunidade open source pelas ferramentas utilizadas

---

## 📞 Suporte

Se você encontrar algum problema ou tiver sugestões, por favor:

1. Verifique a [documentação técnica](DOCUMENTACAO_SISTEMA_ANALISE.md)
2. Abra uma [issue](https://github.com/jacksonsavoldi/scriptlogs-avancado/issues)
3. Entre em contato através do email

---

*Desenvolvido com ❤️ para a comunidade de segurança da informação* 