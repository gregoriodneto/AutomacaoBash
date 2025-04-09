#!/bin/bash

usage() {
    echo "Use: $0 -f <arquivo.txt>"
    echo "Exemplo: $0 -f /home/root/file/arquivo.txt"
    exit 1
}

# Ler as opções
while getopts "f:h" opt; do
    case "$opt" in
        f) ARQUIVO="$OPTARG" ;;
        h) usage ;;
        *) usage ;;
    esac
done

if [ -z "$ARQUIVO" ]; then
    echo "Arquivo com a lista dos ips é obrigatório."
    usage
fi

if [ ! -f "$ARQUIVO" ]; then
    echo "Erro: Arquivo '$ARQUIVO' não encontrado."
    exit 1
fi

while IFS= read -r ip; do
    echo $ip
done < "$ARQUIVO"
