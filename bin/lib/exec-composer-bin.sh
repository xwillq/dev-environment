#!/bin/sh

cmd="$(basename "$0")"
cmd_args="$*"

compose_path="$(dirname $(readlink -f "$0"))/docker-compose.sh"

exec "$compose_path" '' \
    '' '--user=www-data' \
    backend "vendor/bin/$cmd $cmd_args"
