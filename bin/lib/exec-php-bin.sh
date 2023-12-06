#!/bin/sh

cmd="$(basename "$0")"
cmd_args="$*"

# Workaround for launching artisan without creating alias,
# separate script or adding it to PATH
if [ $cmd = 'artisan' ]; then
    cmd='./artisan'
fi

compose_path="$(dirname $(readlink -f "$0"))/docker-compose.sh"

env_variables=(
    XDEBUG_MODE
    XDEBUG_TRIGGER
)

env_variables_args=''
for var in $env_variables; do
    env_variables_args="$env_variables_args --env=$var"
done

exec "$compose_path" '' \
    '' "--user=www-data $env_variables_args" \
    backend "$cmd $cmd_args"
