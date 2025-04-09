#!/bin/bash
echo "Digite o servico para ser iniciado:"
read serv
service $serv restart
echo "Servicos ativos":
ps aux | grep $serv
echo "Portas Abertas"
netstat -nlpt