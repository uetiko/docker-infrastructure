FROM php:7.4-fpm

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN apt-get update

RUN apt-get install -y --no-install-recommends \
        wget curl zip git zsh \
        apt-utils \
        sendmail-bin \
        sendmail \
        libbz2-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libfreetype6-dev \
        libgeoip-dev \
        libgmp-dev \
        libmagickwand-dev \
        libmagickcore-dev \
        libc-client-dev \
        libkrb5-dev \
        libicu-dev \
        libldap2-dev \
        libpspell-dev \
        librecode0 \
        librecode-dev \
        libssh2-1 \
        libssh2-1-dev \
        libtidy-dev \
        libxslt1-dev \
        libyaml-dev \
        libzip-dev 

RUN docker-php-ext-configure gd

RUN docker-php-ext-configure \
    imap --with-kerberos --with-imap-ssl

RUN docker-php-ext-configure \
    opcache --enable-opcache

RUN docker-php-ext-configure zip

RUN docker-php-ext-install -j$(nproc) \
    bcmath \
    bz2 \
    calendar \
    exif \
    gettext \
    gmp \
    imap \
    intl \
    opcache \
    shmop \
    soap \
    sockets \
    sysvmsg \
    sysvsem \
    sysvshm \
    tidy 

RUN rm -f /usr/local/etc/php/conf.d/*sodium.ini 

RUN rm -f /usr/local/lib/php/extensions/*/*sodium.so 

RUN apt-get remove libsodium* -y  

RUN mkdir -p /tmp/libsodium  

RUN curl -sL https://github.com/jedisct1/libsodium/archive/1.0.18-RELEASE.tar.gz | tar xzf - -C  /tmp/libsodium 

RUN cd /tmp/libsodium/libsodium-1.0.18-RELEASE/ && ./configure \
    && make && make check && make install  

RUN cd / &&  rm -rf /tmp/libsodium &&  pecl install -o -f libsodium

RUN set -uex;

RUN wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh;
RUN sh ./install.sh; 

RUN rm ./install.sh

RUN apt autoremove

WORKDIR /var/www/

RUN pecl install redis-5.1.1

RUN pecl install xdebug-2.8.1

RUN docker-php-ext-enable redis xdebug


