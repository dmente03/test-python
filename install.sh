#!/bin/bash
export LC_ALL=C

sudo apt-get update
sudo apt-get upgrade

#Intalando dependências Python
sudo apt-get install build-essential python-dev python-virtualenv python-pip nginx

#Intalando banco de dados MySQL
sudo apt-get install mysql-server libmysqlclient-dev python-mysqldb

#Definição de diretório base
BASE=$PWD

#Criando bando de dados
mysql -uroot -p -v -e 'CREATE DATABASE django CHARACTER SET utf8 COLLATE utf8_general_ci;'

#Edição de usuário e senha de banco de dados
sudo vi $BASE/mysite/settings.py

cd $BASE

#Criando ambiente virtual
virtualenv venvapp

#Ativando ambiente virtual 
source venvapp/bin/activate

#Instalando o Django
pip install django==1.8.5

#Instalando MySQL Connector
pip install mysql-python

#Instalando WSGI 
pip install gunicorn

#Instalando coletor de arquivos estáticos
pip install django whitenoise

#Agrupando arquivos estáticos
python manage.py collectstatic

#Migrando banco
python manage.py migrate

#Criando usário master
python manage.py createsuperuser

#Criando arquivo de configuração do nginx apontando para diretório da instalação da aplicação
source nginx.sh

#Copiar nossa configuração de Nginx para o diretório do aplicativo
sudo mv /etc/nginx/sites-enabled/default /etc/nginx/sites-enabled/default.bkp
sudo cp $BASE/config/nginx.conf /etc/nginx/sites-enabled/default

#Reiniciando Nginx
sudo service nginx restart

#Iniciando aplicação
./start.sh