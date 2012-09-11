#!/bin/bash
#
# Checar horario de onibus 1001
#

url="https://vendas.autoviacao1001.com.br/perl/br5.cgi"
params="ida=soloida&txt_desde=521&txt_hasta=359&fecha=120914&fecha_vuelta=120911"
response=`curl -d "$params" ${url}`
echo ${response}
