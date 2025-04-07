#!/bin/bash

# Funcao de Ajuda
usage() {
    echo "Uso: $0 -o <origem> -d <destino>"
    echo "Exemplo: $0 -o /home/user/files -d /mnt/backup"
    exit 1
}

# Verifica se os argumentos foram fornecidos
#if [ -z "$1" ] || [ -z "$2" ]; then
#    echo "Uso: $0 /caminho/da/origem /caminho/do/backup"
#    exit 1
#fi

# Ler as opções
while getopts "o:d:h" opt; do
    case "$opt" in
        o) ORIGEM="$OPTARG" ;;
        d) DESTINO="$OPTARG" ;;
        h) usage ;;
        *) usage ;;
    esac
done

# Verifica se os parametros foram passados
if [ -z "$ORIGEM" ] || [ -z "$DESTINO" ]; then
    echo "Uso: Origem e destino são obrigatorios."
    usage
fi

# Criar nome do diretorio de backup com data e hora.
#ORIGEM="$1"
#DESTINO="$2"
DATA=$(date + "%Y-%m-%d_%H-%M-%S")
BACKUP_DIR="$DESTINO/backup_$DATA"

# Criar o diretorio de destino
mkdir -p "$BACKUP_DIR"

# Copiar arquivos
cp -r "$ORIGEM"/* "$BACKUP_DIR"

# Log
echo "Backup realizado com sucesso em $DATA para $BACKUP_DIR" >> "$DESTINO/backup.log"