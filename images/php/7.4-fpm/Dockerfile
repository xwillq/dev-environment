FROM php:7.4-fpm-alpine3.16


# Установка composer и расширений

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

RUN install-php-extensions opcache zip intl gd exif pdo_mysql pdo_pgsql redis xdebug imagick

COPY --from=composer:2.5 /usr/bin/composer /usr/bin/composer


# Установка дополнительных программ

RUN apk add git


# Настройка php

COPY config/php/ /usr/local/etc/php/
COPY config/php-fpm.conf /usr/local/etc/php-fpm.conf
COPY config/php-fpm.d/ /usr/local/etc/php-fpm.d/

ENV PHP_MEMORY_LIMIT=128M


# Настройка образа

RUN git config --system --add safe.directory /app

WORKDIR /app
RUN chown -R www-data:www-data /app
