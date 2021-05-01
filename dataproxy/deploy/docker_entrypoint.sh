#!/usr/bin/env bash

service nginx start

gunicorn wsgi:application --name dataproxy --workers 3 --bind=unix:/var/www/dataproxy/gunicorn.sock --log-level=debug --log-file=- --timeout $GUNICORN_TIMEOUT
