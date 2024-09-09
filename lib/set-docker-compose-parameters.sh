if [ -z "$service" ]; then
    echo 'Variable $service must be set to use set-docker-compose-parameters.sh' >&2
    exit 1
fi


# Volume binding and port publishing can only be done with `run`. 
# So, if it was requested, command must be set to `run`. It is done early 
# because other options might depend on command.
if [ -n "$VOLUME" ]; then
    if [ -n "$compose_command" -a "$compose_command" != 'run' ]; then
        echo "Volume binding cannot be used with $compose_command"
        exit 1
    fi

    compose_command='run'

    set -- "--volume=$VOLUME" "$@"
fi

if [ -n "${PORT+set}" ]; then
    if [ -n "$compose_command" -a "$compose_command" != 'run' ]; then
        echo "Port publishing cannot be used with $compose_command"
        exit 1
    fi

    compose_command='run'

    if [ "${PORT:-all}" = 'all' -o "$PORT" = 'true' ]; then
        set -- '--service-ports' "$@"
    else
        set -- "--publish=$PORT" "$@"
    fi
fi


if [ -n "$ENV" ]; then
    old_ifs="$IFS"
    IFS=,
    for var in $ENV; do
        set -- "--env=$var" "$@"
    done 
    IFS="$OLD_IFS"
fi

# If stdin is not attached to terminal, don't attach container to terminal as well.
# This allows using this script both interactively and  with stdin redirection.
if [ ! -t 0 ]; then
    set -- '--no-TTY' "$@"
fi


if [ -z "$compose_command" ]; then
    service_containers="$(command docker --log-level=error compose ps --quiet --status=running "$service" 2>&1)"
    if [ $? -ne 0 ]; then
        echo "Failed to retrieve service containers with error: $defined_services"
        exit 1
    fi

    if [ -n "$service_containers" ]; then
        compose_command='exec'
    else
        compose_command='run'
    fi
fi

if [ "$compose_command" = 'run' ]; then
    set -- '--rm' "$@"
fi


set -- "$compose_command" "$@"
