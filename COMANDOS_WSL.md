# 🚀 COMANDOS PARA TESTAR NO WSL

## 📋 PREPARAÇÃO INICIAL

```bash
# Navegar para o diretório dos scripts
cd /c/Users/jacks/Scripts/logs

# Tornar todos os scripts executáveis
chmod +x *.sh

# Verificar se os scripts estão prontos
ls -la *.sh
```

## 🧪 TESTES RÁPIDOS

### 1. **Teste Completo Automático**
```bash
# Executar todos os testes de uma vez
bash testes_wsl.sh
```

### 2. **Teste de Performance Completo**
```bash
# Executar teste completo com métricas de performance
bash teste_performance_completo.sh
```

## 📊 TESTES INDIVIDUAIS

### 3. **Gerar Logs Realistas**
```bash
# Gerar todos os tipos de logs realistas
bash gerador_logs_realistas.sh
```

### 4. **Testar Apache Access Log**
```bash
# Análise completa do Apache log realista
bash scriptlogs_avancado.sh -v -t -aR -gT -pedago -pcn -peso -correl logs_realistas/apache_access_real.log
```

### 5. **Testar SSH Auth Log**
```bash
# Análise completa do SSH log realista
bash scriptlogs_avancado.sh -v -t -aR -gT -pedago -pcn -peso -correl logs_realistas/ssh_auth_real.log
```

### 6. **Testar Nginx Error Log**
```bash
# Análise completa do Nginx error log realista
bash scriptlogs_avancado.sh -v -t -aR -gT -pedago -pcn -peso -correl logs_realistas/nginx_error_real.log
```

### 7. **Testar MySQL Log**
```bash
# Análise completa do MySQL log realista
bash scriptlogs_avancado.sh -v -t -aR -gT -pedago -pcn -peso -correl logs_realistas/mysql_real.log
```

### 8. **Testar Fail2ban Log**
```bash
# Análise completa do Fail2ban log realista
bash scriptlogs_avancado.sh -v -t -aR -gT -pedago -pcn -peso -correl logs_realistas/fail2ban_real.log
```

## 🔧 TESTES DE SISTEMA

### 9. **Testar Sistema de Treinamento**
```bash
# Importar padrões do CSV
bash csv_to_training_system.sh payloads_patterns.csv

# Testar sistema de treinamento (modo interativo)
bash scriptlogs_avancado.sh --treinar
```

### 10. **Testar Sistema Completo**
```bash
# Testar todos os logs realistas
echo "s" | bash teste_completo_sistema.sh logs_realistas/

# Testar todos os logs existentes
echo "s" | bash teste_completo_sistema.sh .
```

## 📈 TESTES DE PERFORMANCE

### 11. **Medir Tempo de Execução**
```bash
# Medir tempo do Apache log
time bash scriptlogs_avancado.sh -v -t -aR -gT -pedago -pcn -peso -correl logs_realistas/apache_access_real.log

# Medir tempo do SSH log
time bash scriptlogs_avancado.sh -v -t -aR -gT -pedago -pcn -peso -correl logs_realistas/ssh_auth_real.log
```

### 12. **Monitorar Uso de Memória**
```bash
# Executar e monitorar memória
bash scriptlogs_avancado.sh -v -t -aR -gT -pedago -pcn -peso -correl logs_realistas/apache_access_real.log &
watch -n 1 'ps aux | grep scriptlogs'
```

## 🔍 TESTES ESPECÍFICOS

### 13. **Verificar Detecção de Ataques**
```bash
# Contar tentativas de SQL injection
grep -c "sqlmap" logs_realistas/apache_access_real.log

# Contar tentativas de XSS
grep -c "script" logs_realistas/apache_access_real.log

# Contar tentativas de brute force SSH
grep -c "Failed password" logs_realistas/ssh_auth_real.log
```

### 14. **Verificar Conteúdo dos Logs**
```bash
# Ver primeiras linhas do Apache log
head -20 logs_realistas/apache_access_real.log

# Ver primeiras linhas do SSH log
head -20 logs_realistas/ssh_auth_real.log

# Ver estatísticas dos logs
wc -l logs_realistas/*.log
```

## 📋 ANÁLISE DOS RESULTADOS

### 15. **Ver Relatórios Gerados**
```bash
# Ver relatório executivo
cat ANALISE_RESULTADOS_TESTE.md

# Ver resultados de performance (se existir)
ls -la resultados_performance_*/

# Ver relatório executivo de performance
cat resultados_performance_*/resumo_executivo.txt
```

### 16. **Verificar Arquivos Gerados**
```bash
# Listar logs realistas
ls -la logs_realistas/

# Listar resultados de testes
ls -la resultados_*/

# Verificar tamanho dos arquivos
du -h logs_realistas/*.log
```

## 🛠️ TROUBLESHOOTING

### 17. **Verificar Dependências**
```bash
# Verificar comandos necessários
which bash grep awk sed bc ps free df

# Verificar versões
bash --version
grep --version | head -1
```

### 18. **Verificar Permissões**
```bash
# Verificar permissões dos scripts
ls -la *.sh

# Corrigir permissões se necessário
chmod +x *.sh
```

### 19. **Verificar Espaço em Disco**
```bash
# Verificar espaço disponível
df -h .

# Verificar tamanho dos arquivos
du -sh *
```

## 🎯 COMANDOS RÁPIDOS PARA VALIDAÇÃO

### 20. **Validação Rápida do Sistema**
```bash
# Teste rápido com Apache log
bash scriptlogs_avancado.sh -v -peso logs_realistas/apache_access_real.log | grep -E "(Score|CRÍTICO|ALTO)"

# Teste rápido com SSH log
bash scriptlogs_avancado.sh -v -peso logs_realistas/ssh_auth_real.log | grep -E "(Score|CRÍTICO|ALTO)"
```

### 21. **Verificar Funcionamento Básico**
```bash
# Teste simples sem flags
bash scriptlogs_avancado.sh logs_realistas/apache_access_real.log

# Teste com flags básicos
bash scriptlogs_avancado.sh -v logs_realistas/apache_access_real.log
```

## 📊 FLAGS DO SISTEMA

```bash
-v          # Modo verbose (detalhado)
-t          # Análise temporal
-aR         # Análise de risco
-gT         # Geolocalização e tags
-pedago     # Modo pedagógico (explicativo)
-pcn        # Plano de continuidade de negócios
-peso       # Análise por peso de ameaça
-correl     # Correlação de eventos
```

## 🚀 SEQUÊNCIA RECOMENDADA

1. **Preparação:**
   ```bash
   chmod +x *.sh
   ```

2. **Teste Rápido:**
   ```bash
   bash testes_wsl.sh
   ```

3. **Teste Completo:**
   ```bash
   bash teste_performance_completo.sh
   ```

4. **Análise:**
   ```bash
   cat ANALISE_RESULTADOS_TESTE.md
   ls -la resultados_performance_*/
   ```

## 💡 DICAS IMPORTANTES

- Execute os comandos na ordem apresentada
- Monitore o uso de recursos durante os testes
- Verifique os logs de erro se algo falhar
- Use `Ctrl+C` para interromper testes longos
- Os resultados são salvos automaticamente

## 🎉 SUCESSO ESPERADO

Se tudo funcionar corretamente, você verá:
- ✅ Logs realistas gerados
- ✅ Análises completas executadas
- ✅ Métricas de performance coletadas
- ✅ Relatórios detalhados gerados
- ✅ Sistema funcionando perfeitamente

**Status Final:** 🟢 SISTEMA PRONTO PARA PRODUÇÃO 