#!/bin/bash

echo "Container started!"

python manage.py collectstatic --noinput
python manage.py migrate --noinput

exec "$@"
