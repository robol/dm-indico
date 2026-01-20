#!/bin/bash

cd /indico

echo "INDICO startup script"
echo ""
echo "Environment variables:"
echo " - INDICO_CONFIG=${INDICO_CONFIG}"
echo " - INDICO_VERSION=${INDICO_VERSION}"
echo " - INDICO_UNIPIEVENTS_VERSION=${INDICO_UNIPIEVENTS_VERSION}"
echo ""

# Upgrade steps from 3.2 to 3.3
if [ ! -L ~/web/indico.wsgi ]; then
  echo "The symlinks in web appear to be missing. Forcing their creation"
  indico setup create-symlinks ~/web/
fi

# Wait for the DB to come up
echo "Waiting for the DB to come up ..."
while ! nc -z $POSTGRES_SERVER 5432; do sleep 1; done;
echo "DB ready, continuing"

indico db prepare
indico db upgrade
indico db --all-plugins upgrade

indico celery worker -B &
uwsgi --ini /indico/uwsgi-indico.ini

