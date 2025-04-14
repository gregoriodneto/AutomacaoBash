#!/bin/bash
if [ -z "$1" ]; then
    echo "Uso: ./open.sh <range_de_portas> (ex: 20-25)"
    exit 1
fi

range=$1
start=$(echo $range | cut -d '-' -f1)
end=$(echo $range | cut -d '-' -f2)

echo "Abrindo portas de $start até $end..."

for port in $(seq $start $end); do
    echo "Abrindo porta $port..."
    nc -vnlp $port &
    sleep 1
done

echo "Todas as portas do range $range foram abertas."
netstat -nlpt 2>/dev/null | grep LISTEN