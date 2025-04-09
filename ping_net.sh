#!/bin/bash
usage() {
    echo "Modo de uso: $0 REDE"
    echo "Exemplo: $0 192.168.0"
    exit 1
}

if [ "$1" == "" ]; then
    usage
fi

REDE="$1"

echo "Verificando IPs ativos na rede $REDE..."

START=1
END=254
for host in $(seq $START $END); do
    IP="$REDE.$host"
    #ping -c 1 $1.$host | grep "64 bytes" | cut -d " " -f 4 | sed 's/.$//'
    # Pingar com timeout de 1 segundo para ser mais rápido
    if ping -c 1 -W 1 "$IP" &> /dev/null; then
        echo "Ativo: $IP"
    fi
done