#!/bin/bash
#
# Checar horario de onibus 1001
#

# Verificar se ruby esta instalado
command -v ruby >/dev/null 2>&1 || { echo >&2 "Antes de executar, instale ruby. Abortando."; exit 1; }

# Instalar gmail gem, caso nao esteja
gmail_gem_installed=`gem list | egrep '^gmail '`
if [ ! -f "${gmail_gem_installed}" ]; then
  echo "Instalando gmail gem..."
  gem install gmail
fi

if [ ! -f "./stop" ]; then
  now=`date +"%m/%d/%Y -  %T"`
  url="https://vendas.autoviacao1001.com.br/perl/br5.cgi"
  params="ida=soloida&txt_desde=521&txt_hasta=359&fecha=120914"
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

