#!/bin/bash

# Função para exibir ajuda
usage() {
    echo "Uso: $0"
    echo "O script perguntará interativamente:"
    echo "  - Porta para escutar"
    echo "  - Arquivo a ser enviado ao conectar"
    echo "  - Caminho do arquivo de log"
    exit 1
}

read -p "Digite a porta para escutar: " port
if ! [[ "$port" =~ ^[0-9]+$ ]] || [ "$port" -lt 1 ] || [ "$port" -gt 65535 ]; then
    echo "Porta inválida. Digite um número entre 1 e 65535."
    exit 1
fi

read -p "Digite o caminho do arquivo a ser enviado (ex: resposta.txt): " file
if [ ! -f "$file" ]; then
    echo "Arquivo '$file' não encontrado."
    exit 1
fi

read -p "Digite o caminho do arquivo de log (ex: log.txt): " log

echo "[+] Iniciando honeypot na porta $port..."
echo "[+] Logs serão salvos em $log"
echo "[+] Ctrl+C para sair"

while true; do
    echo "[*] Aguardando conexão na porta $port..."
    nc -vnlp "$port" < "$file" >> "$log" 2>&1
    echo "[!] Conexão detectada em $(date '+%Y-%m-%d %H:%M:%S')" >> "$log"
done