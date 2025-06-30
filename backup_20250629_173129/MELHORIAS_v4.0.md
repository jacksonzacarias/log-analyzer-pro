# 🔍 Script Avançado de Análise de Logs - Versão 4.0

## 📋 Resumo das Melhorias

O script foi significativamente aprimorado para suportar **múltiplos formatos de log** automaticamente, mantendo todas as funcionalidades avançadas da versão anterior.

## 🆕 Novas Funcionalidades

### 1. **Detecção Automática de Formato**
- ✅ **Apache Access Log**: `203.0.113.5 - - [29/Jun/2025:11:40:23 +0000] "GET /admin/ HTTP/1.1" 403 489`
- ✅ **SSH Auth Log**: `Jun 29 08:15:22 server1 sshd[24567]: Invalid user admin from 203.0.113.5`
- ✅ **MySQL Log**: `2025-06-29T11:35:12.345678Z 12 Connect Access denied for user 'root'@'203.0.113.5'`
- ✅ **Nginx Error Log**: `2025/06/29 10:05:11 [error] 10245#10245: *3456 open() "/var/www/html/.env" failed`
- ✅ **Nginx Access Log**: Similar ao Apache
- ✅ **Logs Customizados**: Formato original do script

### 2. **Normalização Inteligente**
- 🔄 **Conversão automática** para formato padrão
- 📊 **Extração de campos** (IP, usuário, timestamp, ação)
- 🎯 **Classificação contextual** de ações
- 🧹 **Limpeza automática** de arquivos temporários

### 3. **Padrões de Ameaça Expandidos**

#### Apache/Nginx
- `nikto`, `sqlmap`, `nmap`, `dirb`, `gobuster`, `wpscan` (7pts)
- `/admin/`, `/wp-admin`, `/phpmyadmin` (7pts)
- `/.env`, `/.git`, `/.htaccess` (7pts)
- `/server-status`, `/wp-login.php`, `/api/upload` (7pts)
- `Erro 403`, `Erro 500` (7pts), `Erro 404` (4pts)

#### SSH
- `Invalid user` (7pts)
- `Failed password` (7pts)
- `Accepted password` (4pts)
- `session opened` (4pts)
- `preauth` (4pts)

#### MySQL
- `Access denied` (7pts)
- `SELECT.*FROM.*sensitive` (7pts)
- `DROP.*TABLE` (10pts)
- `DELETE.*FROM`, `UPDATE.*WHERE` (7pts)
- `SHOW.*DATABASES`, `SHOW.*TABLES` (4pts)

#### Nginx
- `Permission denied` (7pts)
- `too large body` (4pts)
- `upstream response` (4pts)
- `fastcgi` (4pts)

## 🧪 Testes Realizados

### ✅ Apache Access Log
```
📋 Detectado formato: APACHE_ACCESS
🔴 CRÍTICO: 1 eventos (acesso a /admin/ com erro 403)
🟣 ALTO: 1 eventos (acesso a /server-status)
🎯 Score de Risco: 17 pontos
```

### ✅ SSH Auth Log
```
📋 Detectado formato: SSH_AUTH
🟡 MÉDIO: 1 eventos (tentativas de login)
🟢 INFO: 5 eventos (conexões normais)
🎯 Score de Risco: 4 pontos
```

### ✅ MySQL Log
```
📋 Detectado formato: MYSQL
🟣 ALTO: 1 eventos (Access denied para root)
🟢 INFO: 2 eventos (conexões normais)
🎯 Score de Risco: 7 pontos
```

### ✅ Nginx Error Log
```
📋 Detectado formato: NGINX_ERROR
🔴 CRÍTICO: 1 eventos (tentativa de acesso a /.env)
🟣 ALTO: 2 eventos (wp-login.php e api/upload)
🎯 Score de Risco: 24 pontos
⚠️  Sistema em risco moderado
```

## 🔧 Como Usar

### Análise Básica
```bash
./scriptlogs_avancado.sh arquivo.log
```

### Análise Completa
```bash
./scriptlogs_avancado.sh -v -t -aR -gT -pedago -pcn -peso -correl arquivo.log
```

### Teste Multi-Formato
```bash
./teste_multi_formato.sh
```

## 📊 Funcionalidades Mantidas

- ✅ **Classificação por peso** de ameaças
- ✅ **Análise temporal** de padrões
- ✅ **Correlação de eventos** por IP/usuário
- ✅ **Geolocalização** de IPs externos
- ✅ **Recomendações** de segurança
- ✅ **Plano de continuidade** de negócios
- ✅ **Cores aprimoradas** e interface visual
- ✅ **Modo pedagógico** com explicações
- ✅ **Detecção de backups suspeitos**

## 🎯 Benefícios

1. **Universalidade**: Funciona com qualquer formato de log comum
2. **Automatização**: Detecção e normalização automáticas
3. **Precisão**: Padrões específicos para cada tipo de log
4. **Flexibilidade**: Mantém compatibilidade com logs customizados
5. **Robustez**: Tratamento de arquivos vazios e formatos desconhecidos

## 🔮 Próximas Melhorias

- [ ] Suporte a logs de firewall (iptables, ufw)
- [ ] Análise de logs de aplicação (PHP, Python, Node.js)
- [ ] Integração com SIEM externos
- [ ] Relatórios em PDF
- [ ] Interface web

## 📝 Notas Técnicas

- **Dependências**: `grep`, `awk`, `sed`, `sort`, `uniq`, `column`, `curl`, `jq`
- **Compatibilidade**: Bash 4.0+
- **Sistemas**: Linux, macOS, WSL
- **Arquivos temporários**: Limpeza automática ao sair

---

**Versão**: 4.0  
**Data**: Junho 2025  
**Status**: ✅ Pronto para produção 