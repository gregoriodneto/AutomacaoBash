#!/bin/bash
usage() {
    echo "Modo de uso: $0 REDE PORTA"
    echo "Exemplo: $0 192.168.0 80"
    exit 1
}

if [ "$1" == "" ] || [ "$2" == "" ]; then
    usage
fi

REDE="$1"
PORTA="$2"

echo "Verificando se o IP $REDE esta com a porta $PORTA disponível..."

START=1
END=254
for host in $(seq $START $END); do
    IP="$REDE.$host"
    RESPOSTA=$(hping3 -S -p $PORTA -c 1 $IP 2> /dev/null | grep "flags=SA" | cut -d " " -f 2 | cut -d "=" -f 2)

    if [ ! -z "$RESPOSTA" ]; then
        echo "Porta $PORTA aberta em: $IP"
    fi
done