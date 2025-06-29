#!/bin/bash

# ===================================================================================
# SISTEMA DE TREINAMENTO INTELIGENTE PARA ANÁLISE DE LOGS
# ===================================================================================
# Reconhece automaticamente tipos de logs e aprende padrões específicos
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

# Arquivos de configuração
LOG_TYPES_CONFIG="log_types_learning.conf"
PATTERNS_CONFIG="attack_patterns_learning.conf"
TRAINING_HISTORY="training_history.log"

# Função para detectar tipo de log automaticamente
detect_log_type() {
    local file="$1"
    local filename=$(basename "$file")
    local sample_lines=$(head -10 "$file" 2>/dev/null)
    
    # Primeiro, tenta detectar pelo nome do arquivo
    case "$filename" in
        *vsftpd*) echo "VSFTPD" ;;
        *cron*) echo "CRON" ;;
        *mysql*) echo "MYSQL" ;;
        *nginx*) echo "NGINX" ;;
        *apache*) echo "APACHE" ;;
        *fail2ban*) echo "FAIL2BAN" ;;
        *iptables*) echo "IPTABLES" ;;
        *docker*) echo "DOCKER" ;;
        *redis*) echo "REDIS" ;;
        *mail*) echo "MAIL" ;;
        *dns*) echo "DNS" ;;
        *haproxy*) echo "HAPROXY" ;;
        *letsencrypt*) echo "LETSENCRYPT" ;;
        *openvpn*) echo "OPENVPN" ;;
        *php*) echo "PHP" ;;
        *node*) echo "NODE" ;;
        *varnish*) echo "VARNISH" ;;
        *ufw*) echo "UFW" ;;
        *auth*) echo "AUTH" ;;
        *access*) echo "ACCESS" ;;
        *error*) echo "ERROR" ;;
        *brute*) echo "BRUTE_FORCE" ;;
        *sql*) echo "SQL_INJECTION" ;;
        *xss*) echo "XSS" ;;
        *lfi*) echo "LFI" ;;
        *attack*) echo "ATTACK" ;;
        *security*) echo "SECURITY" ;;
        *firewall*) echo "FIREWALL" ;;
        *proxy*) echo "PROXY" ;;
        *load*) echo "LOAD_BALANCER" ;;
        *ssl*) echo "SSL" ;;
        *cert*) echo "CERTIFICATE" ;;
        *backup*) echo "BACKUP" ;;
        *monitor*) echo "MONITORING" ;;
        *syslog*) echo "SYSLOG" ;;
        *kern*) echo "KERNEL" ;;
        *daemon*) echo "DAEMON" ;;
        *user*) echo "USER" ;;
        *local*) echo "LOCAL" ;;
        *emerg*) echo "EMERGENCY" ;;
        *alert*) echo "ALERT" ;;
        *crit*) echo "CRITICAL" ;;
        *warn*) echo "WARNING" ;;
        *notice*) echo "NOTICE" ;;
        *info*) echo "INFO" ;;
        *debug*) echo "DEBUG" ;;
    esac
    
    # Se não detectou pelo nome, tenta pelo conteúdo
    if echo "$sample_lines" | grep -q "\[.*\] \"[A-Z]\+ .* HTTP/"; then
        echo "APACHE_ACCESS"
    elif echo "$sample_lines" | grep -q "sshd.*Accepted\|sshd.*Failed\|sshd.*Invalid"; then
        echo "SSH_AUTH"
    elif echo "$sample_lines" | grep -q "mysql.*Access denied\|mysql.*Query\|mysql.*Connect\|MariaDB"; then
        echo "MYSQL"
    elif echo "$sample_lines" | grep -q "nginx.*error\|nginx.*access"; then
        echo "NGINX"
    elif echo "$sample_lines" | grep -q "fail2ban.*Ban\|fail2ban.*Unban"; then
        echo "FAIL2BAN"
    elif echo "$sample_lines" | grep -q "iptables.*DROP\|iptables.*ACCEPT\|iptables.*REJECT"; then
        echo "IPTABLES"
    elif echo "$sample_lines" | grep -q "cron.*CMD\|cron.*session\|CRON.*root"; then
        echo "CRON"
    elif echo "$sample_lines" | grep -q "docker.*container\|docker.*image\|docker.*daemon"; then
        echo "DOCKER"
    elif echo "$sample_lines" | grep -q "redis.*connection\|redis.*command\|Redis"; then
        echo "REDIS"
    elif echo "$sample_lines" | grep -q "mail.*from\|mail.*to\|postfix\|sendmail"; then
        echo "MAIL"
    elif echo "$sample_lines" | grep -q "vsftpd.*FTP\|vsftpd.*connection\|vsftpd.*login"; then
        echo "VSFTPD"
    elif echo "$sample_lines" | grep -q "dns.*query\|dns.*response\|bind"; then
        echo "DNS"
    elif echo "$sample_lines" | grep -q "haproxy.*proxy\|haproxy.*backend\|haproxy.*frontend"; then
        echo "HAPROXY"
    elif echo "$sample_lines" | grep -q "letsencrypt.*certificate\|letsencrypt.*renewal"; then
        echo "LETSENCRYPT"
    elif echo "$sample_lines" | grep -q "openvpn.*connection\|openvpn.*client"; then
        echo "OPENVPN"
    elif echo "$sample_lines" | grep -q "php.*fpm\|php.*error\|PHP.*Fatal"; then
        echo "PHP_FPM"
    elif echo "$sample_lines" | grep -q "node.*app\|pm2.*process"; then
        echo "NODE_PM2"
    elif echo "$sample_lines" | grep -q "varnish.*cache\|varnish.*hit\|varnish.*miss"; then
        echo "VARNISH"
    elif echo "$sample_lines" | grep -q "ufw.*block\|ufw.*allow\|ufw.*deny"; then
        echo "UFW"
    elif echo "$sample_lines" | grep -q "auth.*log\|authentication\|login"; then
        echo "AUTH"
    elif echo "$sample_lines" | grep -q "error.*log\|Error\|ERROR"; then
        echo "ERROR"
    elif echo "$sample_lines" | grep -q "brute.*force\|bruteforce\|password.*attempt"; then
        echo "BRUTE_FORCE"
    elif echo "$sample_lines" | grep -q "sql.*injection\|SQL.*injection\|union.*select"; then
        echo "SQL_INJECTION"
    elif echo "$sample_lines" | grep -q "xss\|XSS\|cross.*site.*scripting"; then
        echo "XSS"
    elif echo "$sample_lines" | grep -q "lfi\|LFI\|local.*file.*inclusion"; then
        echo "LFI"
    elif echo "$sample_lines" | grep -q "attack\|Attack\|ATTACK"; then
        echo "ATTACK"
    elif echo "$sample_lines" | grep -q "security.*log\|Security\|SECURITY"; then
        echo "SECURITY"
    elif echo "$sample_lines" | grep -q "firewall.*log\|Firewall\|FIREWALL"; then
        echo "FIREWALL"
    elif echo "$sample_lines" | grep -q "proxy.*log\|Proxy\|PROXY"; then
        echo "PROXY"
    elif echo "$sample_lines" | grep -q "load.*balancer\|LoadBalancer\|LOAD_BALANCER"; then
        echo "LOAD_BALANCER"
    elif echo "$sample_lines" | grep -q "ssl.*log\|SSL.*error\|TLS"; then
        echo "SSL"
    elif echo "$sample_lines" | grep -q "certificate.*log\|Certificate\|CERTIFICATE"; then
        echo "CERTIFICATE"
    elif echo "$sample_lines" | grep -q "backup.*log\|Backup\|BACKUP"; then
        echo "BACKUP"
    elif echo "$sample_lines" | grep -q "monitor.*log\|Monitoring\|MONITORING"; then
        echo "MONITORING"
    elif echo "$sample_lines" | grep -q "syslog\|Syslog\|SYSLOG"; then
        echo "SYSLOG"
    elif echo "$sample_lines" | grep -q "kernel.*log\|Kernel\|KERNEL"; then
        echo "KERNEL"
    elif echo "$sample_lines" | grep -q "daemon.*log\|Daemon\|DAEMON"; then
        echo "DAEMON"
    elif echo "$sample_lines" | grep -q "user.*log\|User.*log\|USER"; then
        echo "USER"
    elif echo "$sample_lines" | grep -q "local.*log\|Local.*log\|LOCAL"; then
        echo "LOCAL"
    elif echo "$sample_lines" | grep -q "emergency.*log\|Emergency\|EMERGENCY"; then
        echo "EMERGENCY"
    elif echo "$sample_lines" | grep -q "alert.*log\|Alert\|ALERT"; then
        echo "ALERT"
    elif echo "$sample_lines" | grep -q "critical.*log\|Critical\|CRITICAL"; then
        echo "CRITICAL"
    elif echo "$sample_lines" | grep -q "warning.*log\|Warning\|WARNING"; then
        echo "WARNING"
    elif echo "$sample_lines" | grep -q "notice.*log\|Notice\|NOTICE"; then
        echo "NOTICE"
    elif echo "$sample_lines" | grep -q "info.*log\|Info\|INFO"; then
        echo "INFO"
    elif echo "$sample_lines" | grep -q "debug.*log\|Debug\|DEBUG"; then
        echo "DEBUG"
    else
        echo "CUSTOM"
    fi
}

# Função para extrair campos específicos do tipo de log
extract_log_fields() {
    local file="$1"
    local log_type="$2"
    local sample_line=$(head -1 "$file")
    
    case "$log_type" in
        APACHE_ACCESS)
            echo "IP: $(echo "$sample_line" | awk '{print $1}')"
            echo "Timestamp: $(echo "$sample_line" | sed -n 's/.*\[\([^]]*\)\].*/\1/p')"
            echo "Method: $(echo "$sample_line" | sed -n 's/.*"\([A-Z]\+\)[^"]*".*/\1/p')"
            echo "URL: $(echo "$sample_line" | sed -n 's/.*"[A-Z]\+ \([^"]*\)[^"]*".*/\1/p')"
            echo "Status: $(echo "$sample_line" | awk '{print $9}')"
            echo "User-Agent: $(echo "$sample_line" | sed -n 's/.*"\([^"]*\)"$/\1/p')"
            ;;
        SSH_AUTH)
            echo "Timestamp: $(echo "$sample_line" | awk '{print $1" "$2" "$3}')"
            echo "Host: $(echo "$sample_line" | awk '{print $4}')"
            echo "Service: $(echo "$sample_line" | awk '{print $5}')"
            echo "Event: $(echo "$sample_line" | awk '{for(i=6;i<=NF;i++) printf $i" "; print ""}')"
            ;;
        MYSQL)
            echo "Timestamp: $(echo "$sample_line" | awk '{print $1" "$2}')"
            echo "Level: $(echo "$sample_line" | awk '{print $3}')"
            echo "Message: $(echo "$sample_line" | awk '{for(i=4;i<=NF;i++) printf $i" "; print ""}')"
            ;;
        NGINX)
            echo "Timestamp: $(echo "$sample_line" | sed -n 's/.*\[\([^]]*\)\].*/\1/p')"
            echo "Level: $(echo "$sample_line" | awk '{print $5}')"
            echo "Message: $(echo "$sample_line" | awk '{for(i=6;i<=NF;i++) printf $i" "; print ""}')"
            ;;
        *)
            echo "Raw: $sample_line"
            ;;
    esac
}

# Função para sugerir padrões baseados no tipo de log
suggest_patterns_for_type() {
    local log_type="$1"
    local file="$2"
    
    echo -e "\n${BOLD}🎯 SUGESTÕES ESPECÍFICAS PARA $log_type${RESET}"
    echo -e "${BOLD}========================================${RESET}"
    
    case "$log_type" in
        APACHE_ACCESS)
            echo -e "${CYAN}Padrões comuns em logs Apache:${RESET}"
            echo -e "• ${YELLOW}Status 404:${RESET} Tentativas de acesso a arquivos inexistentes"
            echo -e "• ${YELLOW}Status 403:${RESET} Tentativas de acesso negado"
            echo -e "• ${YELLOW}Status 500:${RESET} Erros internos do servidor"
            echo -e "• ${YELLOW}User-Agent:${RESET} Scanners, bots maliciosos"
            echo -e "• ${YELLOW}URLs suspeitas:${RESET} /admin, /wp-admin, /phpmyadmin"
            
            # Analisa padrões específicos do arquivo
            echo -e "\n${BOLD}📊 Análise do arquivo atual:${RESET}"
            local status_404=$(grep -c " 404 " "$file" 2>/dev/null || echo "0")
            local status_403=$(grep -c " 403 " "$file" 2>/dev/null || echo "0")
            local status_500=$(grep -c " 500 " "$file" 2>/dev/null || echo "0")
            local admin_access=$(grep -c "/admin" "$file" 2>/dev/null || echo "0")
            
            echo -e "• Status 404: $status_404 ocorrências"
            echo -e "• Status 403: $status_403 ocorrências"
            echo -e "• Status 500: $status_500 ocorrências"
            echo -e "• Acesso /admin: $admin_access ocorrências"
            ;;
            
        SSH_AUTH)
            echo -e "${CYAN}Padrões comuns em logs SSH:${RESET}"
            echo -e "• ${YELLOW}Failed password:${RESET} Tentativas de força bruta"
            echo -e "• ${YELLOW}Invalid user:${RESET} Usuários inexistentes"
            echo -e "• ${YELLOW}Accepted password:${RESET} Logins bem-sucedidos"
            echo -e "• ${YELLOW}Connection from:${RESET} IPs de origem"
            
            # Analisa padrões específicos do arquivo
            echo -e "\n${BOLD}📊 Análise do arquivo atual:${RESET}"
            local failed_pass=$(grep -c "Failed password" "$file" 2>/dev/null || echo "0")
            local invalid_user=$(grep -c "Invalid user" "$file" 2>/dev/null || echo "0")
            local accepted_pass=$(grep -c "Accepted password" "$file" 2>/dev/null || echo "0")
            
            echo -e "• Senhas falharam: $failed_pass tentativas"
            echo -e "• Usuários inválidos: $invalid_user tentativas"
            echo -e "• Senhas aceitas: $accepted_pass logins"
            ;;
            
        MYSQL)
            echo -e "${CYAN}Padrões comuns em logs MySQL:${RESET}"
            echo -e "• ${YELLOW}Access denied:${RESET} Tentativas de acesso negado"
            echo -e "• ${YELLOW}Query:${RESET} Consultas suspeitas"
            echo -e "• ${YELLOW}Connection:${RESET} Conexões de IPs suspeitos"
            echo -e "• ${YELLOW}Error:${RESET} Erros de sintaxe SQL"
            
            # Analisa padrões específicos do arquivo
            echo -e "\n${BOLD}📊 Análise do arquivo atual:${RESET}"
            local access_denied=$(grep -c "Access denied" "$file" 2>/dev/null || echo "0")
            local syntax_error=$(grep -c "syntax error" "$file" 2>/dev/null || echo "0")
            
            echo -e "• Acesso negado: $access_denied tentativas"
            echo -e "• Erros de sintaxe: $syntax_error ocorrências"
            ;;
            
        NGINX)
            echo -e "${CYAN}Padrões comuns em logs Nginx:${RESET}"
            echo -e "• ${YELLOW}Permission denied:${RESET} Acesso negado"
            echo -e "• ${YELLOW}Too large body:${RESET} Uploads suspeitos"
            echo -e "• ${YELLOW}Upstream error:${RESET} Erros de backend"
            echo -e "• ${YELLOW}FastCGI error:${RESET} Erros de processamento"
            ;;
            
        FAIL2BAN)
            echo -e "${CYAN}Padrões comuns em logs Fail2ban:${RESET}"
            echo -e "• ${YELLOW}Ban:${RESET} IPs banidos"
            echo -e "• ${YELLOW}Unban:${RESET} IPs desbanidos"
            echo -e "• ${YELLOW}Found:${RESET} Padrões encontrados"
            ;;
            
        VSFTPD)
            echo -e "${CYAN}Padrões comuns em logs VSFTPD:${RESET}"
            echo -e "• ${YELLOW}Failed login:${RESET} Tentativas de login FTP falharam"
            echo -e "• ${YELLOW}Successful login:${RESET} Logins FTP bem-sucedidos"
            echo -e "• ${YELLOW}Upload/Download:${RESET} Transferências de arquivos"
            echo -e "• ${YELLOW}Connection:${RESET} Conexões FTP"
            
            # Analisa padrões específicos do arquivo
            echo -e "\n${BOLD}📊 Análise do arquivo atual:${RESET}"
            local failed_login=$(grep -c "FAIL LOGIN" "$file" 2>/dev/null || echo "0")
            local successful_login=$(grep -c "OK LOGIN" "$file" 2>/dev/null || echo "0")
            local upload=$(grep -c "UPLOAD" "$file" 2>/dev/null || echo "0")
            local download=$(grep -c "DOWNLOAD" "$file" 2>/dev/null || echo "0")
            
            echo -e "• Logins falharam: $failed_login tentativas"
            echo -e "• Logins bem-sucedidos: $successful_login"
            echo -e "• Uploads: $upload arquivos"
            echo -e "• Downloads: $download arquivos"
            ;;
            
        CRON)
            echo -e "${CYAN}Padrões comuns em logs CRON:${RESET}"
            echo -e "• ${YELLOW}CMD:${RESET} Comandos executados"
            echo -e "• ${YELLOW}Session:${RESET} Sessões cron"
            echo -e "• ${YELLOW}Error:${RESET} Erros em jobs cron"
            echo -e "• ${YELLOW}Job:${RESET} Jobs agendados"
            
            # Analisa padrões específicos do arquivo
            echo -e "\n${BOLD}📊 Análise do arquivo atual:${RESET}"
            local cmd_executed=$(grep -c "CMD" "$file" 2>/dev/null || echo "0")
            local session_opened=$(grep -c "session opened" "$file" 2>/dev/null || echo "0")
            local session_closed=$(grep -c "session closed" "$file" 2>/dev/null || echo "0")
            
            echo -e "• Comandos executados: $cmd_executed"
            echo -e "• Sessões abertas: $session_opened"
            echo -e "• Sessões fechadas: $session_closed"
            ;;
            
        DOCKER)
            echo -e "${CYAN}Padrões comuns em logs Docker:${RESET}"
            echo -e "• ${YELLOW}Container:${RESET} Operações de container"
            echo -e "• ${YELLOW}Image:${RESET} Operações de imagem"
            echo -e "• ${YELLOW}Daemon:${RESET} Logs do daemon Docker"
            echo -e "• ${YELLOW}Error:${RESET} Erros do Docker"
            
            # Analisa padrões específicos do arquivo
            echo -e "\n${BOLD}📊 Análise do arquivo atual:${RESET}"
            local container_ops=$(grep -c "container" "$file" 2>/dev/null || echo "0")
            local image_ops=$(grep -c "image" "$file" 2>/dev/null || echo "0")
            local daemon_logs=$(grep -c "daemon" "$file" 2>/dev/null || echo "0")
            
            echo -e "• Operações de container: $container_ops"
            echo -e "• Operações de imagem: $image_ops"
            echo -e "• Logs do daemon: $daemon_logs"
            ;;
            
        REDIS)
            echo -e "${CYAN}Padrões comuns em logs Redis:${RESET}"
            echo -e "• ${YELLOW}Connection:${RESET} Conexões Redis"
            echo -e "• ${YELLOW}Command:${RESET} Comandos executados"
            echo -e "• ${YELLOW}Error:${RESET} Erros do Redis"
            echo -e "• ${YELLOW}Memory:${RESET} Uso de memória"
            
            # Analisa padrões específicos do arquivo
            echo -e "\n${BOLD}📊 Análise do arquivo atual:${RESET}"
            local connections=$(grep -c "connection" "$file" 2>/dev/null || echo "0")
            local commands=$(grep -c "command" "$file" 2>/dev/null || echo "0")
            local errors=$(grep -c "error" "$file" 2>/dev/null || echo "0")
            
            echo -e "• Conexões: $connections"
            echo -e "• Comandos: $commands"
            echo -e "• Erros: $errors"
            ;;
            
        MAIL)
            echo -e "${CYAN}Padrões comuns em logs Mail:${RESET}"
            echo -e "• ${YELLOW}From:${RESET} Remetentes"
            echo -e "• ${YELLOW}To:${RESET} Destinatários"
            echo -e "• ${YELLOW}Postfix:${RESET} Logs do Postfix"
            echo -e "• ${YELLOW}Sendmail:${RESET} Logs do Sendmail"
            
            # Analisa padrões específicos do arquivo
            echo -e "\n${BOLD}📊 Análise do arquivo atual:${RESET}"
            local from_count=$(grep -c "from=" "$file" 2>/dev/null || echo "0")
            local to_count=$(grep -c "to=" "$file" 2>/dev/null || echo "0")
            local postfix_count=$(grep -c "postfix" "$file" 2>/dev/null || echo "0")
            
            echo -e "• Remetentes: $from_count"
            echo -e "• Destinatários: $to_count"
            echo -e "• Logs Postfix: $postfix_count"
            ;;
            
        DNS)
            echo -e "${CYAN}Padrões comuns em logs DNS:${RESET}"
            echo -e "• ${YELLOW}Query:${RESET} Consultas DNS"
            echo -e "• ${YELLOW}Response:${RESET} Respostas DNS"
            echo -e "• ${YELLOW}Bind:${RESET} Logs do BIND"
            echo -e "• ${YELLOW}Zone:${RESET} Transferências de zona"
            
            # Analisa padrões específicos do arquivo
            echo -e "\n${BOLD}📊 Análise do arquivo atual:${RESET}"
            local queries=$(grep -c "query" "$file" 2>/dev/null || echo "0")
            local responses=$(grep -c "response" "$file" 2>/dev/null || echo "0")
            local bind_logs=$(grep -c "bind" "$file" 2>/dev/null || echo "0")
            
            echo -e "• Consultas: $queries"
            echo -e "• Respostas: $responses"
            echo -e "• Logs BIND: $bind_logs"
            ;;
            
        HAPROXY)
            echo -e "${CYAN}Padrões comuns em logs HAProxy:${RESET}"
            echo -e "• ${YELLOW}Proxy:${RESET} Operações de proxy"
            echo -e "• ${YELLOW}Backend:${RESET} Logs de backend"
            echo -e "• ${YELLOW}Frontend:${RESET} Logs de frontend"
            echo -e "• ${YELLOW}Load:${RESET} Balanceamento de carga"
            
            # Analisa padrões específicos do arquivo
            echo -e "\n${BOLD}📊 Análise do arquivo atual:${RESET}"
            local proxy_ops=$(grep -c "proxy" "$file" 2>/dev/null || echo "0")
            local backend_ops=$(grep -c "backend" "$file" 2>/dev/null || echo "0")
            local frontend_ops=$(grep -c "frontend" "$file" 2>/dev/null || echo "0")
            
            echo -e "• Operações proxy: $proxy_ops"
            echo -e "• Operações backend: $backend_ops"
            echo -e "• Operações frontend: $frontend_ops"
            ;;
            
        LETSENCRYPT)
            echo -e "${CYAN}Padrões comuns em logs Let's Encrypt:${RESET}"
            echo -e "• ${YELLOW}Certificate:${RESET} Operações de certificado"
            echo -e "• ${YELLOW}Renewal:${RESET} Renovações automáticas"
            echo -e "• ${YELLOW}Challenge:${RESET} Desafios de validação"
            echo -e "• ${YELLOW}Error:${RESET} Erros de certificado"
            
            # Analisa padrões específicos do arquivo
            echo -e "\n${BOLD}📊 Análise do arquivo atual:${RESET}"
            local cert_ops=$(grep -c "certificate" "$file" 2>/dev/null || echo "0")
            local renewal_ops=$(grep -c "renewal" "$file" 2>/dev/null || echo "0")
            local challenge_ops=$(grep -c "challenge" "$file" 2>/dev/null || echo "0")
            
            echo -e "• Operações de certificado: $cert_ops"
            echo -e "• Renovações: $renewal_ops"
            echo -e "• Desafios: $challenge_ops"
            ;;
            
        OPENVPN)
            echo -e "${CYAN}Padrões comuns em logs OpenVPN:${RESET}"
            echo -e "• ${YELLOW}Connection:${RESET} Conexões VPN"
            echo -e "• ${YELLOW}Client:${RESET} Clientes conectados"
            echo -e "• ${YELLOW}Authentication:${RESET} Autenticação"
            echo -e "• ${YELLOW}Route:${RESET} Roteamento"
            
            # Analisa padrões específicos do arquivo
            echo -e "\n${BOLD}📊 Análise do arquivo atual:${RESET}"
            local connections=$(grep -c "connection" "$file" 2>/dev/null || echo "0")
            local clients=$(grep -c "client" "$file" 2>/dev/null || echo "0")
            local auth_ops=$(grep -c "authentication" "$file" 2>/dev/null || echo "0")
            
            echo -e "• Conexões: $connections"
            echo -e "• Clientes: $clients"
            echo -e "• Autenticações: $auth_ops"
            ;;
            
        PHP_FPM)
            echo -e "${CYAN}Padrões comuns em logs PHP-FPM:${RESET}"
            echo -e "• ${YELLOW}FPM:${RESET} Processos FPM"
            echo -e "• ${YELLOW}Error:${RESET} Erros PHP"
            echo -e "• ${YELLOW}Fatal:${RESET} Erros fatais"
            echo -e "• ${YELLOW}Warning:${RESET} Avisos PHP"
            
            # Analisa padrões específicos do arquivo
            echo -e "\n${BOLD}📊 Análise do arquivo atual:${RESET}"
            local fpm_ops=$(grep -c "fpm" "$file" 2>/dev/null || echo "0")
            local php_errors=$(grep -c "PHP.*Error" "$file" 2>/dev/null || echo "0")
            local fatal_errors=$(grep -c "PHP.*Fatal" "$file" 2>/dev/null || echo "0")
            
            echo -e "• Operações FPM: $fpm_ops"
            echo -e "• Erros PHP: $php_errors"
            echo -e "• Erros fatais: $fatal_errors"
            ;;
            
        NODE_PM2)
            echo -e "${CYAN}Padrões comuns em logs Node.js/PM2:${RESET}"
            echo -e "• ${YELLOW}App:${RESET} Aplicações Node.js"
            echo -e "• ${YELLOW}Process:${RESET} Processos PM2"
            echo -e "• ${YELLOW}Error:${RESET} Erros da aplicação"
            echo -e "• ${YELLOW}Restart:${RESET} Reinicializações"
            
            # Analisa padrões específicos do arquivo
            echo -e "\n${BOLD}📊 Análise do arquivo atual:${RESET}"
            local app_logs=$(grep -c "app" "$file" 2>/dev/null || echo "0")
            local process_logs=$(grep -c "process" "$file" 2>/dev/null || echo "0")
            local error_logs=$(grep -c "error" "$file" 2>/dev/null || echo "0")
            
            echo -e "• Logs de app: $app_logs"
            echo -e "• Logs de processo: $process_logs"
            echo -e "• Logs de erro: $error_logs"
            ;;
            
        VARNISH)
            echo -e "${CYAN}Padrões comuns em logs Varnish:${RESET}"
            echo -e "• ${YELLOW}Cache:${RESET} Operações de cache"
            echo -e "• ${YELLOW}Hit:${RESET} Cache hits"
            echo -e "• ${YELLOW}Miss:${RESET} Cache misses"
            echo -e "• ${YELLOW}Backend:${RESET} Operações de backend"
            
            # Analisa padrões específicos do arquivo
            echo -e "\n${BOLD}📊 Análise do arquivo atual:${RESET}"
            local cache_ops=$(grep -c "cache" "$file" 2>/dev/null || echo "0")
            local hits=$(grep -c "hit" "$file" 2>/dev/null || echo "0")
            local misses=$(grep -c "miss" "$file" 2>/dev/null || echo "0")
            
            echo -e "• Operações de cache: $cache_ops"
            echo -e "• Cache hits: $hits"
            echo -e "• Cache misses: $misses"
            ;;
            
        UFW)
            echo -e "${CYAN}Padrões comuns em logs UFW:${RESET}"
            echo -e "• ${YELLOW}Block:${RESET} Bloqueios"
            echo -e "• ${YELLOW}Allow:${RESET} Permissões"
            echo -e "• ${YELLOW}Deny:${RESET} Negações"
            echo -e "• ${YELLOW}Rule:${RESET} Regras aplicadas"
            
            # Analisa padrões específicos do arquivo
            echo -e "\n${BOLD}📊 Análise do arquivo atual:${RESET}"
            local blocks=$(grep -c "block" "$file" 2>/dev/null || echo "0")
            local allows=$(grep -c "allow" "$file" 2>/dev/null || echo "0")
            local denies=$(grep -c "deny" "$file" 2>/dev/null || echo "0")
            
            echo -e "• Bloqueios: $blocks"
            echo -e "• Permissões: $allows"
            echo -e "• Negações: $denies"
            ;;
            
        *)
            echo -e "${CYAN}Análise genérica de logs:${RESET}"
            echo -e "• ${YELLOW}IPs:${RESET} Endereços de origem"
            echo -e "• ${YELLOW}Timestamps:${RESET} Horários dos eventos"
            echo -e "• ${YELLOW}Erros:${RESET} Mensagens de erro"
            echo -e "• ${YELLOW}Warnings:${RESET} Avisos do sistema"
            ;;
    esac
}

# Função para treinar com arquivo específico
train_with_file() {
    local file="$1"
    
    if [[ ! -f "$file" ]]; then
        echo -e "${RED}${BOLD}❌ Arquivo não encontrado: $file${RESET}"
        return 1
    fi
    
    echo -e "${BOLD}${CYAN}🎓 TREINANDO COM ARQUIVO: $(basename "$file")${RESET}"
    echo -e "${BOLD}${CYAN}========================================${RESET}"
    
    # Detecta tipo automaticamente
    local log_type=$(detect_log_type "$file")
    echo -e "${GREEN}${BOLD}✅ Tipo detectado: $log_type${RESET}"
    
    # Mostra estrutura do log
    echo -e "\n${BOLD}📋 ESTRUTURA DO LOG:${RESET}"
    extract_log_fields "$file" "$log_type"
    
    # Sugere padrões específicos
    suggest_patterns_for_type "$log_type" "$file"
    
    # Menu de treinamento específico
    while true; do
        echo -e "\n${BOLD}Escolha uma ação:${RESET}"
        echo "1) Adicionar padrão específico para $log_type"
        echo "2) Analisar eventos suspeitos no arquivo"
        echo "3) Extrair padrões automaticamente"
        echo "4) Ver estatísticas do arquivo"
        echo "5) Voltar"
        
        read -p "Opção: " choice
        
        case $choice in
            1)
                add_pattern_for_type "$log_type" "$file"
                ;;
            2)
                analyze_suspicious_events "$file" "$log_type"
                ;;
            3)
                auto_extract_patterns "$file" "$log_type"
                ;;
            4)
                show_file_statistics "$file" "$log_type"
                ;;
            5)
                break
                ;;
            *)
                echo -e "${RED}Opção inválida: '$choice'${RESET}"
                ;;
        esac
    done
}

# Função para adicionar padrão específico por tipo
add_pattern_for_type() {
    local log_type="$1"
    local file="$2"
    
    echo -e "\n${BOLD}📝 ADICIONAR PADRÃO PARA $log_type${RESET}"
    echo -e "${BOLD}================================${RESET}"
    
    # Mostra exemplo de linha do arquivo
    local sample_line=$(head -1 "$file")
    echo -e "${CYAN}Exemplo de linha:${RESET} $sample_line"
    
    read -p "Regex/Pattern: " pattern
    read -p "Categoria (CRÍTICO/ALTO/MÉDIO/BAIXO/INFO): " category
    read -p "Descrição: " description
    read -p "Peso (0-10): " weight
    read -p "Tags (separadas por vírgula): " tags
    
    # Adiciona ao arquivo de configuração
    echo "$pattern|$category|$description|$weight|$tags|$log_type" >> "$PATTERNS_CONFIG"
    echo -e "${GREEN}${BOLD}✅ Padrão adicionado para $log_type${RESET}"
    
    # Registra no histórico
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Adicionado padrão: $pattern ($category) para $log_type" >> "$TRAINING_HISTORY"
}

# Função para analisar eventos suspeitos
analyze_suspicious_events() {
    local file="$1"
    local log_type="$2"
    
    echo -e "\n${BOLD}🔍 EVENTOS SUSPEITOS EM $log_type${RESET}"
    echo -e "${BOLD}================================${RESET}"
    
    case "$log_type" in
        APACHE_ACCESS)
            echo -e "${BOLD}Status de erro:${RESET}"
            grep " [45][0-9][0-9] " "$file" | head -5
            
            echo -e "\n${BOLD}Acessos a diretórios sensíveis:${RESET}"
            grep -E "(admin|wp-admin|phpmyadmin|\.env|\.git)" "$file" | head -5
            
            echo -e "\n${BOLD}User-Agents suspeitos:${RESET}"
            grep -E "(nikto|sqlmap|nmap|dirb|gobuster)" "$file" | head -5
            ;;
            
        SSH_AUTH)
            echo -e "${BOLD}Tentativas de força bruta:${RESET}"
            grep "Failed password" "$file" | head -5
            
            echo -e "\n${BOLD}Usuários inválidos:${RESET}"
            grep "Invalid user" "$file" | head -5
            ;;
            
        MYSQL)
            echo -e "${BOLD}Acessos negados:${RESET}"
            grep "Access denied" "$file" | head -5
            
            echo -e "\n${BOLD}Erros de sintaxe:${RESET}"
            grep "syntax error" "$file" | head -5
            ;;
            
        *)
            echo -e "${YELLOW}Análise genérica não disponível para $log_type${RESET}"
            ;;
    esac
}

# Função para extrair padrões automaticamente
auto_extract_patterns() {
    local file="$1"
    local log_type="$2"
    
    echo -e "\n${BOLD}🤖 EXTRAÇÃO AUTOMÁTICA DE PADRÕES${RESET}"
    echo -e "${BOLD}==================================${RESET}"
    
    case "$log_type" in
        APACHE_ACCESS)
            echo -e "${BOLD}Status codes mais frequentes:${RESET}"
            awk '{print $9}' "$file" | sort | uniq -c | sort -nr | head -5
            
            echo -e "\n${BOLD}URLs mais acessadas:${RESET}"
            awk '{print $7}' "$file" | sort | uniq -c | sort -nr | head -5
            
            echo -e "\n${BOLD}IPs mais ativos:${RESET}"
            awk '{print $1}' "$file" | sort | uniq -c | sort -nr | head -5
            ;;
            
        SSH_AUTH)
            echo -e "${BOLD}Usuários mais tentados:${RESET}"
            grep "Invalid user" "$file" | awk '{print $8}' | sort | uniq -c | sort -nr | head -5
            
            echo -e "\n${BOLD}IPs com mais falhas:${RESET}"
            grep "Failed password" "$file" | awk '{print $11}' | sort | uniq -c | sort -nr | head -5
            ;;
            
        *)
            echo -e "${YELLOW}Extração automática não disponível para $log_type${RESET}"
            ;;
    esac
}

# Função para mostrar estatísticas do arquivo
show_file_statistics() {
    local file="$1"
    local log_type="$2"
    
    echo -e "\n${BOLD}📊 ESTATÍSTICAS DO ARQUIVO${RESET}"
    echo -e "${BOLD}==========================${RESET}"
    
    local total_lines=$(wc -l < "$file")
    local file_size=$(du -h "$file" | cut -f1)
    local first_date=$(head -1 "$file" | awk '{print $1, $2}' 2>/dev/null || echo "N/A")
    local last_date=$(tail -1 "$file" | awk '{print $1, $2}' 2>/dev/null || echo "N/A")
    
    echo -e "• ${BOLD}Total de linhas:${RESET} $total_lines"
    echo -e "• ${BOLD}Tamanho:${RESET} $file_size"
    echo -e "• ${BOLD}Primeira entrada:${RESET} $first_date"
    echo -e "• ${BOLD}Última entrada:${RESET} $last_date"
    echo -e "• ${BOLD}Tipo de log:${RESET} $log_type"
}

# Função principal
main() {
    echo -e "${BOLD}${CYAN}🎓 SISTEMA DE TREINAMENTO INTELIGENTE PARA ANÁLISE DE LOGS${RESET}"
    echo -e "${BOLD}${CYAN}========================================================${RESET}"
    
    # Inicializa arquivos se não existirem
    [[ ! -f "$PATTERNS_CONFIG" ]] && touch "$PATTERNS_CONFIG"
    [[ ! -f "$TRAINING_HISTORY" ]] && touch "$TRAINING_HISTORY"
    
    while true; do
        echo -e "\n${BOLD}Escolha uma opção:${RESET}"
        echo "1) Treinar com arquivo específico"
        echo "2) Treinar com pasta de logs (detecção automática)"
        echo "3) Ver histórico de treinamento"
        echo "4) Listar padrões aprendidos"
        echo "5) Exportar configuração"
        echo "6) Sair"
        
        read -p "Opção: " choice
        
        case $choice in
            1)
                read -p "Caminho do arquivo de log: " log_file
                train_with_file "$log_file"
                ;;
            2)
                read -p "Caminho da pasta de logs: " logs_dir
                train_with_directory "$logs_dir"
                ;;
            3)
                show_training_history
                ;;
            4)
                list_learned_patterns
                ;;
            5)
                export_configuration
                ;;
            6)
                echo -e "${GREEN}${BOLD}✅ Treinamento concluído!${RESET}"
                exit 0
                ;;
            *)
                echo -e "${RED}Opção inválida: '$choice'${RESET}"
                ;;
        esac
    done
}

# Função para treinar com pasta de logs
train_with_directory() {
    local dir="$1"
    
    if [[ ! -d "$dir" ]]; then
        echo -e "${RED}${BOLD}❌ Diretório não encontrado: $dir${RESET}"
        return 1
    fi
    
    echo -e "${BOLD}${CYAN}📁 ANALISANDO PASTA: $dir${RESET}"
    echo -e "${BOLD}${CYAN}==============================${RESET}"
    
    # Lista arquivos de log
    local log_files=$(find "$dir" -type f -name "*.log" -o -name "*access*" -o -name "*error*" -o -name "*auth*" 2>/dev/null)
    
    if [[ -z "$log_files" ]]; then
        echo -e "${YELLOW}Nenhum arquivo de log encontrado${RESET}"
        return 1
    fi
    
    echo -e "${BOLD}Arquivos de log encontrados:${RESET}"
    local count=1
    for file in $log_files; do
        local log_type=$(detect_log_type "$file")
        echo -e "$count) $(basename "$file") - $log_type"
        ((count++))
    done
    
    read -p "Escolha um arquivo (número) ou 0 para sair: " file_choice
    
    if [[ "$file_choice" == "0" ]]; then
        return
    fi
    
    local selected_file=$(echo "$log_files" | sed -n "${file_choice}p")
    if [[ -n "$selected_file" ]]; then
        train_with_file "$selected_file"
    fi
}

# Função para mostrar histórico de treinamento
show_training_history() {
    echo -e "\n${BOLD}📜 HISTÓRICO DE TREINAMENTO${RESET}"
    echo -e "${BOLD}==========================${RESET}"
    
    if [[ -f "$TRAINING_HISTORY" ]]; then
        tail -20 "$TRAINING_HISTORY"
    else
        echo -e "${YELLOW}Nenhum histórico encontrado${RESET}"
    fi
}

# Função para listar padrões aprendidos
list_learned_patterns() {
    echo -e "\n${BOLD}📋 PADRÕES APRENDIDOS${RESET}"
    echo -e "${BOLD}====================${RESET}"
    
    if [[ -f "$PATTERNS_CONFIG" ]]; then
        while IFS='|' read -r pattern category description weight tags log_type; do
            [[ "$pattern" =~ ^#.*$ ]] && continue
            [[ -z "$pattern" ]] && continue
            
            echo -e "${BOLD}$category${RESET} (${weight}pts) - $log_type"
            echo -e "  ${CYAN}Padrão:${RESET} $pattern"
            echo -e "  ${CYAN}Descrição:${RESET} $description"
            echo -e "  ${CYAN}Tags:${RESET} $tags"
            echo
        done < "$PATTERNS_CONFIG"
    else
        echo -e "${YELLOW}Nenhum padrão encontrado${RESET}"
    fi
}

# Função para exportar configuração
export_configuration() {
    local export_file="log_analysis_config_$(date +%Y%m%d_%H%M%S).conf"
    
    echo -e "\n${BOLD}📤 EXPORTANDO CONFIGURAÇÃO${RESET}"
    echo -e "${BOLD}========================${RESET}"
    
    if [[ -f "$PATTERNS_CONFIG" ]]; then
        cp "$PATTERNS_CONFIG" "$export_file"
        echo -e "${GREEN}${BOLD}✅ Configuração exportada: $export_file${RESET}"
    else
        echo -e "${YELLOW}Nenhuma configuração para exportar${RESET}"
    fi
}

# Executa função principal
main "$@" 