#!/bin/sh

compose_args="$1"
compose_command="$2"
compose_command_args="$3"
service="$4"
cmd="$5"

if [ -z "$compose_command" ]; then
    active_services=$(docker compose $compose_args ps --services)

    if echo "$active_services" | grep "$service" >/dev/null; then
        compose_command='exec'
    else
        compose_command='run'
    fi
fi

if [ $compose_command = 'run' ]; then
    compose_command_args="$compose_command_args --rm"
fi

if [ ! -t 0 ]; then
    compose_command_args="$compose_command_args --no-TTY"
fi

exec docker compose $compose_args \
    $compose_command $compose_command_args \
    $service $cmd
