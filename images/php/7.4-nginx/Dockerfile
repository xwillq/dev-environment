FROM php:7.4-fpm-alpine3.15


# Установка nginx, supervisor, composer, расширений и дополнительных программ

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

RUN install-php-extensions opcache pcntl zip intl sockets gd exif pdo_mysql pdo_pgsql redis xdebug yaml bcmath

RUN apk add nginx supervisor git

COPY --from=composer:2.1.14 /usr/bin/composer /usr/bin/composer


# Настройка php

COPY config/php/ /usr/local/etc/php/
COPY config/php-fpm.conf /usr/local/etc/php-fpm.conf
COPY config/php-fpm.d/ /usr/local/etc/php-fpm.d/

RUN rm /usr/local/etc/php-fpm.d/zz-docker.conf
RUN mkdir /var/run/php-fpm && chown www-data:www-data /var/run/php-fpm

ENV PHP_MEMORY_LIMIT=128M

# Настройка nginx

COPY config/nginx/ /etc/nginx/

# Настройка supervisor

COPY config/supervisord.conf /etc/supervisor/supervisord.conf
COPY config/supervisord-includes/ /etc/supervisor/conf.d/


# Настройка образа

RUN git config --system --add safe.directory /app

COPY config/docker-entrypoint.sh /docker-entrypoint.sh
COPY config/docker-entrypoint.d/ /docker-entrypoint.d/

ENTRYPOINT ["/docker-entrypoint.sh"]

WORKDIR /app
RUN chown -R www-data:www-data /app
STOPSIGNAL SIGQUIT

CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
