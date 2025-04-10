#!/bin/bash
usage() {
    echo "Modo de uso: $0 SITE"
    echo "Exemplo: $0 http://teste.com.br"
    exit 1
}


# Cores ANSI
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
NC='\033[0m' # No Color (reset)

# Linha separadora
LINE="========================================"

URL="$1"

if [ -z "$URL" ]; then
    usage
fi

while true; do
    # Baixa a página
    wget -q "$URL" -O index.html

    # Extrai URLs
    LINKS=$(grep -oP '(?<=href=")[^"]+|(?<=src=")[^"]+' index.html | sort | uniq)

    # Cabeçalho
    echo -e "${NC}${LINE}"
    echo -e "${GREEN}[+] Resolvendo URLs em:${NC} $URL"
    echo -e "${NC}${LINE}"
    echo -e "${RED}Concluído: Salvando os resultados em: $URL.ip.txt"
    echo -e "${NC}${LINE}"
    printf "${NC}%-10s %-15s %-20s${NC}\n" "Line" "IP" "ADDRESS"

    # Contador
    i=1
    OUTPUT_FILE="${URL//http:\/\//}.ip.txt" > "$OUTPUT_FILE"

    for link in $LINKS; do
        # Pega o domínio
        if [[ "$link" == http* ]]; then
            DOMAIN=$(echo "$link" | awk -F/ '{print $3}')
        elif [[ "$link" == /* ]]; then
            DOMAIN=$(echo "$URL" | awk -F/ '{print $3}')
        else
            continue
        fi

        # Resolve o IP
        IP=$(host "$DOMAIN" | grep "has address" | head -n1 | awk '{print $4}')

        # Se achou IP, exibe
        if [ -n "$IP" ]; then
            printf "%-8s %-16s %-40s\n" "$i" "$IP" "$link"
            echo "$IP $link" >> "$OUTPUT_FILE"
            ((i++))
        fi
    done

    echo -e "${NC}${LINE}"
    read -p "$(echo -e "${GREEN}- Nova pesquisa? y/n: ${NC}")" RESPOSTA

    if [[ "$RESPOSTA" =~ ^[Yy]$ ]]; then
        read -p "$(echo -e "${YELLOW}Nova URL: ${NC}")" NOVA_URL
        if [ -n "$NOVA_URL" ]; then
            URL="$NOVA_URL"
        else
            echo -e "${RED}[x] URL vazia. Encerrando.${NC}"
            break
        fi
    else
        echo -e "${RED}[x] Saindo..."
        break
    fi
done