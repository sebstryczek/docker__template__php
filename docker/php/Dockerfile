FROM php:8.2-apache

RUN apt-get update

RUN apt-get install libnss3-tools -y
RUN curl -JLO "https://dl.filippo.io/mkcert/latest?for=linux/amd64" && \
    chmod +x mkcert-v*-linux-amd64 && \
    cp mkcert-v*-linux-amd64 /usr/local/bin/mkcert

RUN apt-get install certbot -y

# Install PHP extensions
# ###

COPY ./docker/php/config/000-default-ssl.conf /etc/apache2/sites-available/
COPY ./docker/php/setup.sh /setup.sh

ENTRYPOINT ["sh", "/setup.sh"]
