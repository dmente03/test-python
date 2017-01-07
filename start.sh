#!/bin/bash
# Diretorio e arquivo de log
set -e
LOGFILE=/vagrant/tut-django/logs/gunicorn.log
LOGDIR=$(dirname $LOGFILE)
# Numero de processo simultaneo, modifique de acordo com seu processador
NUM_WORKERS=3
# Usuario/Grupo que vai rodar o gunicorn
USER=ubuntu
#GROUP=root
# Endereço local que o gunicorn irá rodar
ADDRESS=localhost:8000
# Ativando ambiente virtual e executando o gunicorn para este projeto
source /vagrant/tut-django/myvenv/bin/activate
cd /vagrant/tut-django/
test -d $LOGDIR || mkdir -p $LOGDIR
exec gunicorn -w $NUM_WORKERS --bind=$ADDRESS --user=$USER --log-level=debug --log-file=$LOGFILE 2>>$LOGFILE mysite.wsgi