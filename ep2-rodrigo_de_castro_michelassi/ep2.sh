#!/bin/bash

#declaração de variáveis
export flag
export ociosidade
export data
export ips
export listen
export somaOc
export media
export tempo
export cem
export res

n=0
tempo=0
flag=1
cem=100

#FAZER
#ENVIAR RESPOSTA PARA UM ARQUIVO, SEM SOBRESCREVER
while [ $flag == 1 ]; do
    while [ $n -lt 100 ]; do
        #obter os dados pedidos
        data=$(date +"%d/%m/%Y %T")
        data="Data e hora: "$data
        ips=$(netstat -anp 2>/dev/null | grep 45052 | uniq -u | grep ESTABLISHED | awk '{printf "%s; ", $4}') #recebe os IPs nao repetidos
        listen=$(netstat -anp 2>/dev/null | grep 45052 | uniq -u | grep LISTEN)
        ips="IPs: "$ips
        ociosidade=$(top -n 1 | head -n 3 | tail -n 1 | grep Cpu | awk '{printf "%s", $8}' | tr ',' '.')

        if [ $( echo "$ociosidade>$3" | bc -l ) -eq 0 ]; then       #   resposta com ociosidade
            somaOc=$( echo "$somaOc+$ociosidade" | bc -l )
            ociosidade="Ociosidade da CPU: "$ociosidade
            res=$data'\n'$ociosidade'\n'                           
        else                                                        #   resposta sem ociosidade
            somaOc=$( echo "$somaOc+$ociosidade" | bc -l )
            res=$data'\n'
        fi

        #verifica se LISTEN está vazio (servidor está on/off)
        if [ -z "$listen" ]; then                 
            msg='O servidor está fora do ar.'
            tempo=$( echo $tempo+1 | bc)1
            res=$res$msg
        else
            res=$res$ips'\n'
        fi
        
        #envia a mensagem para o bot
        curl -s --data "text=$(echo -e $res)" https://api.telegram.org/bot$4/sendMessage?chat_id=$5/dev/null
        echo -e "$res\n" >> $2
        cat $2

        let n=n+1
        sleep $1    #demorar o tempo passado de execução no terminal
    done

    tempo=$( echo "$tempo*$1" | bc )
    tempo=$"Tempo fora do ar: "$tempo's'
    media=$( echo "$somaOc/$cem" | bc )
    media="Ociosidade Média: "$media
    res=$tempo'\n'$media

    #Enviar os dados a cada 100 rodadas para o bot
    curl -s --data "text=$(echo -e $res)" https://api.telegram.org/bot$4/sendMessage?chat_id=$5/dev/null
    echo -e "\n$res\n" >> $2
    cat $2

    n=0
    somaOc=0
    tempo=0
    echo -e '\n\n'
done
exit 0

#   para executar o codigo (minha máquina)
#   ./ep2.sh 1 ./Documents/USP/2nd\ semester/tecprog/projetos/ep2-rodrigo_de_castro_michelassi/texto.txt 95 5794998504:AAGJlQ_aQOwLOy0v6pMTbsV2MRlIZJxFhLU 5179476747