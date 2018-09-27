#!/bin/bash
#
# script que altera a porta do servidor de SSH
# Autor: Diego Tumelero
# Versão 1: 10/09/2018
# Versão 2: 26/09/2018


# esta linha consulta a porta atual do servidor de SSH
# o comando grep serve para filtrar a saida do comando cat
# o comando awk serve para filtrar exaramente o número da 
# porta na linha que o comando grep trouxe, que no caso é o segundo campo
# o uso da crase ` é para que o comando seja executado e seu resultado atribuído a variável $porta_atual
porta_atual=`cat /etc/ssh/sshd_config | grep 'Port ' | awk '{print $2}'`

echo "A porta atual do SSHd é $porta_atual"     #imprime na tela a porta atual do sshd
echo "Digite a nova porta do servidor de SSH"
read porta_nova					                #pede pro usuário digitar o número da porta nova para o sshd

# testar se a linha da porta é comentada ou não
teste_hashtag=`cat /etc/ssh/sshd_config | grep '#Port *' | awk '{print $1}'`

if [ "$teste_hashtag" = "#Port" ] ; then
    # arquivo com a linha da porta comentada e com a porta 22

    # a linha abaixo realiza a troca da porta do sshd, utilizando o comando sed
    # repare que são utilizadas as variáveis $porta_atual e $porta_nova
    # esta linha necessita do sudo
    sudo sed -i "s/#Port 22/Port $porta_nova/" /etc/ssh/sshd_config
else
    # linha da porta não comentada, pode ser porta 22 ou não
    sudo sed -i "s/Port $porta_atual/Port $porta_nova/" /etc/ssh/sshd_config
fi

#apenas imprime a confirmação da nova porta do sshd
porta_confirmacao=`cat /etc/ssh/sshd_config | grep 'Port ' | awk '{print $2}'`
echo "A porta atual do SSHd é $porta_confirmacao"

read pause
clear

sudo systemctl restart sshd			            #reinicia o serviço do sshd
systemctl status sshd

read pause
clear
