FROM python:3.8-slim

COPY . ./

RUN pip install Flask gunicorn

CMD gunicorn --bind :$PORT app:app
