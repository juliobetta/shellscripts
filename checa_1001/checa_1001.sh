#!/bin/bash
#
# Checar horario de onibus 1001
#

now=`date +"%m/%d/%Y -  %T"`
url="https://vendas.autoviacao1001.com.br/perl/br5.cgi"
params="ida=soloida&txt_desde=521&txt_hasta=359&fecha=120914"
response=`curl -d "$params" ${url} | egrep "<td>(2[0-9]+:[0-9]+)"`

if [ ! -z ${response} ]; then
 ruby sendmail.rb $1 $2 "${url}?${params}"
else
  touch log.txt
  echo "$now : nao tem" >> log.txt 
fi
