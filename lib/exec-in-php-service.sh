#!/usr/bin/env sh

set -e

script_path="$(readlink -f "$0")"
lib_path="${script_path%/*}"

. "$lib_path/compose-utils.sh"

if compose_config="$(find_compose_config 2>/dev/null)"; then
    php_services='backend laravel.test php-fpm php'
    if find_compose_config_override 1>/dev/null 2>/dev/null; then
        service="$(find_defined_service $php_services)"
    else
        service="$(find_defined_service_yq "$compose_config" $php_services)"
    fi

    if [ -n "$service" ]; then
        set -- "$service" "$@"
        . "$lib_path/set-docker-compose-parameters.sh"
        exec docker --log-level=error compose "$@"
    fi
fi

if [ "$IMAGE" ]; then
    set -- "$IMAGE" "$@"
elif [ "$PHP_IMAGE" ]; then
    set -- "$PHP_IMAGE" "$@"
elif [ "$PHP_VERSION" ]; then
    set -- "php:$PHP_VERSION" "$@"
else
    set -- 'php:latest' "$@"
fi

. "$lib_path/set-docker-parameters.sh"

exec docker "$@"
