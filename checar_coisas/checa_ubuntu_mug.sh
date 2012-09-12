#! /bin/sh
#
# Checar se Caneca Ubuntu se encontra disponivel na loja da CANONICAL
#
now=`date +"%m/%d/%Y -  %T"`

# Verificar se email foi passado
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

url="http://shop.canonical.com/product_info.php"
params="?products_id=828"
response=`curl -d "$params" ${url} | egrep "<b>Out of Stock"`

if [ -f "./stop_ubuntu_mug" -a -z "${response}" ]; then
  ruby ./sendmail.rb $1 $2 "Ubuntu MUG" "${url}?${params}"
  echo "$now : TEM CANECAAAA" >> ./log.txt
  touch ./stop_ubuntu_mug
else
  touch ./log.txt
  if [ -f "./stop_ubuntu_mug" ]; then rm ./stop_ubuntu_mug; fi
  echo "$now : nao tem caneca" >> ./log.txt
fi
