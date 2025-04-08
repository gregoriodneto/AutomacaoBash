#!/bin/bash

# Função de Ajuda
usage() {
    echo "Uso: $0 -l <local-analise>"
    echo "Exemplo: $0 -l /home/user/files"
    exit 1
}

information() {
    echo "$DATA - Ultimo arquivo criado: $CAMINHO_COMPLETO"
}

# Verificar os valores passados por parâmetro
while getopts "l:h" opt; do
    case "$opt" in
        l) LOCAL="$OPTARG" ;;
        h) usage ;;
        *) usage ;;
    esac
done

# Verifica se foi passado os campos
if [ -z "$LOCAL" ]; then
    echo "Local de análise é obrigatoria"
    usage
fi

# Criando a variável da data/hora
# Imprime o nome do arquivo criado, no caso o último arquivo
# Registra as informações do log em um arquivo de real time
ULTIMO_ARQUIVO=""
while true; do
    DATA=$(date +"%Y-%m-%d_%H-%M-%S")
    ARQUIVO=$(ls -t $LOCAL | grep -v "^logs.txt$" | head -n 1)
    CAMINHO_COMPLETO="$LOCAL/$ARQUIVO"
    
    if [ "$ARQUIVO" != "$ULTIMO_ARQUIVO" ]; then
        information | tee -a "logs.txt"
        ULTIMO_ARQUIVO="$ARQUIVO"
    fi

    sleep 5
done