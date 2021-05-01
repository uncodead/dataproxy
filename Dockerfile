FROM python:2.7-stretch

RUN apt-get -y update && apt-get -y upgrade && apt-get install nginx -y

WORKDIR /var/www/dataproxy

COPY dataproxy/. .
COPY Pipfile .
COPY Pipfile.lock .

RUN pip install pipenv
RUN pipenv install --system --deploy

RUN cp /var/www/dataproxy/deploy/dataproxy.nginx /etc/nginx/sites-available/dataproxy

RUN mkdir /var/log/dataproxy \
 && rm -rf /etc/nginx/sites-enabled/default \
 && ln -s /etc/nginx/sites-available/dataproxy /etc/nginx/sites-enabled/dataproxy

ENV GUNICORN_TIMEOUT 3000

EXPOSE 80

RUN cp /var/www/dataproxy/deploy/docker_entrypoint.sh /docker_entrypoint.sh

RUN chmod +x /docker_entrypoint.sh

ENTRYPOINT ["sh", "/docker_entrypoint.sh"]
