#!/bin/bash
#
# Checar horario de onibus 1001
#

if [ ! -f "./stop" ]; then

  . ./funcoes.sh $1 $2

  url="https://vendas.autoviacao1001.com.br/perl/br5.cgi"
  params="ida=soloida&txt_desde=521&txt_hasta=359&fecha=120921"
  response=`curl -q -d "$params" ${url} | egrep "<td>(2[0-9]+:[0-9]+)"` # >= 20:50h

  if [ ! -z "${response}" ]; then
    ruby ./sendmail.rb $1 $2 "Passagem 1001 - Campos/Carangola >= 20:50" "${url}?${params}"
    echo "$now : TEM PASSAGEM RAPAAZ" >> ./log.txt
    touch ./stop
  else
    touch ./log.txt
    echo "$now : nao tem passagem" >> ./log.txt
  fi
fi

