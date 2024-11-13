#!/bin/bash
python manage.py makemigrations
python manage.py migrate
python manage.py init -y
python manage.py collectstatic --noinput
uvicorn application.asgi:application --port 8000 --host 0.0.0.0 --workers 4
