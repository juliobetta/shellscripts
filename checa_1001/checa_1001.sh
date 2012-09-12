#!/bin/bash
#
# Checar horario de onibus 1001
#
if [ ! -f "./stop" ]; then
  now=`date +"%m/%d/%Y -  %T"`
  
  # Verificar EMAIL
  if [ -z $1 ]; then
    echo "$now : Email nao fornecido. Abortando." >> ./log.txt; exit 1;
  fi

  if [ -z $2 ]; then
    echo "$now : Senha nao fornecida. Abortando." >> ./log.txt; exit 1;
  fi
  
  # Verificar se ruby esta instalado
  command -v ruby >/dev/null 2>&1 || { echo >&2 "Antes de executar, instale ruby. Abortando."; exit 1; }

  # Instalar gmail gem, caso nao esteja
  gmail_gem_installed=`gem list | egrep '^gmail '`
  if [ -z "${gmail_gem_installed}" ]; then
    echo "Instalando gmail gem..."
    gem install gmail
  fi

  url="https://vendas.autoviacao1001.com.br/perl/br5.cgi"
  params="ida=soloida&txt_desde=521&txt_hasta=359&fecha=120921"
  response=`curl -d "$params" ${url} | egrep "<td>(2[0-9]+:[0-9]+)"`

  if [ ! -z "${response}" ]; then
    ruby ./sendmail.rb $1 $2 "${url}?${params}"
    echo "$now : TEM PASSAGEM RAPAAZ" >> ./log.txt
    touch ./stop
  else
    touch ./log.txt
    echo "$now : nao tem" >> ./log.txt
  fi
fi

