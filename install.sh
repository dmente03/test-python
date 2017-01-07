#!/bin/bash

sudo apt-get update
sudo apt-get upgrade

#Intalando dependências Python
sudo apt-get install build-essential python-dev python-virtualenv python-pip nginx

#Intalando banco de dados MySQL
sudo apt-get install mysql-server libmysqlclient-dev python-mysqldb

#Edição de usuário e senha de banco de dados
sudo $EDITOR $PWD/mysite/settings.py

#Criando ambiente virtual
virtualenv .

#Ativando ambiente virtual 
source bin/activate

#Instalando o Django
pip install django==1.8.5

#Instalando MySQL Connector
pip install mysql-python

#Instalando WSGI 
pip install gunicorn

#Instalando coletor de arquivos estáticos
pip install django whitenoise

#Agrupando estáticos
python manage.py collectstatic

#Migrando banco
python manage.py migrate

#Criando usário master
python manage.py createsuperuser

#Copiar nossa configuração de Nginx para o diretório do aplicativo
sudo cp $PWD/nginx.conf /etc/nginx/sites-enabled/

#Reiniciando Nginx
sudo service nginx restart

#Iniciando aplicação
./start.sh
sudo service nginx restart