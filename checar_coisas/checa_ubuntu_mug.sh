#!/bin/bash
#
# Checar se Caneca Ubuntu se encontra disponivel na loja da CANONICAL
#

. funcoes.sh $1 $2

url="http://shop.canonical.com/product_info.php"
params="?products_id=828"
response=`curl -d "$params" ${url} | egrep "<b>Out of Stock"`

if [ -f "./stop_ubuntu_mug" -a -z "${response}" ]; then
  ruby ./sendmail.rb $1 $2 "Ubuntu MUG" "${url}?${params}"
  echo "$now : TEM CANECAAAA" >> ./log.txt
  touch ./stop_ubuntu_mug
else
  touch ./log.txt
fi

if [ -f "./stop_ubuntu_mug" ]; then rm ./stop_ubuntu_mug; fi
  echo "$now : nao tem caneca" >> ./log.txt
fi