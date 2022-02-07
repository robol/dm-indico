#!/bin/bash

cd /indico

# Wait for the DB to come up
echo "Waiting for the DB to come up ..."
while ! nc -z $POSTGRES_SERVER 5432; do sleep 1; done;
echo "DB ready, continuing"

indico db prepare
indico db upgrade

indico celery worker -B &
uwsgi --ini /indico/uwsgi-indico.ini

