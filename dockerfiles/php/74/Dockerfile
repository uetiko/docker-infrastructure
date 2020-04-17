FROM php:7.4-fpm

COPY --from=composer:lastest /usr/bin/composer /usr/bin/composer

RUN apt-get update

RUN apt-get install -y --no-install-recommends \
        wget curl zip git zsh

RUN set -uex;

RUN wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh;
RUN sh ./install.sh; 

RUN rm ./install.sh

RUN apt-clean

WORKDIR /var/www/

RUN pecl install redis-5.1.1

RUN pecl install xdebug-2.8.1

RUN docker-php-ext-enable redis xdebug
