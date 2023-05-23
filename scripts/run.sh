#!/bin/sh

set -e

python /socialin/backend/manage.py wait_for_db
python /socialin/backend/manage.py collectstatic --noinput
python /socialin/backend/manage.py migrate

uwsgi --socket :9000 --workers 4 --master --enable-threads --module conf.wsgi