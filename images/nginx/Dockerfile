FROM nginx:1.23-alpine

RUN addgroup -g 82 -S www-data; \
    adduser -u 82 -D -S -G www-data www-data

COPY config/nginx.conf /etc/nginx/nginx.conf
COPY config/server.conf.template /etc/nginx/templates/server.conf.template

ENV NGINX_PORT=8080
ENV PHP_HOST=backend
ENV PUBLIC_DIR=/app/public
