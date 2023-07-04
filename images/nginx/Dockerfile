FROM nginx:1.23-alpine

RUN addgroup -g 82 -S www-data; \
    adduser -u 82 -D -S -G www-data www-data

COPY config/nginx.conf /etc/nginx/nginx.conf
COPY config/backend.conf.template /etc/nginx/templates/backend.conf.template
COPY config/frontend.conf.template /etc/nginx/templates/frontend.conf.template

ENV BACKEND_PORT=8080
ENV PHP_HOST=backend
ENV PUBLIC_DIR=/app/public

ENV FRONTEND_PORT=3000
ENV DIST_DIR=/app
