FROM php:8.1-cli-alpine3.15


# Установка roadrunner, composer и расширений

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

RUN install-php-extensions pcntl zip intl sockets gd
RUN install-php-extensions pdo_mysql pdo_pgsql redis
RUN install-php-extensions xdebug-stable
RUN install-php-extensions exif

COPY --from=spiralscout/roadrunner:2.9.1 /usr/bin/rr /usr/bin/rr
COPY --from=composer:2.1.14 /usr/bin/composer /usr/bin/composer


# Установка дополнительных программ

RUN apk add git ffmpeg


# Настройка php

COPY config/php/ /usr/local/etc/php/

ENV PHP_MEMORY_LIMIT=128M


# Настройка образа

USER www-data:www-data

WORKDIR /app
CMD ["/usr/bin/rr", "serve"]
