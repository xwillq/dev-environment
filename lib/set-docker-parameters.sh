if [ -n "$VOLUME" ]; then
    set -- "--volume=$VOLUME" "$@"
fi

if [ -n "${PORT+set}" ]; then
    if [ "${PORT:-all}" != 'all' -a "$PORT" != 'true' ]; then
        set -- "--publish=$PORT" "$@"
    else
        set -- '--publish-all' "$@"
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

# If stdin is attached to terminal, attach container to terminal as well.
# This allows using this script both interactively and  with stdin redirection.
if [ -t 0 ]; then
    set -- '--tty' '--interactive' "$@"
fi

workdir='/app'
set -- "--volume=$PWD:$workdir" "--workdir=$workdir" "$@"


set -- 'run' '--rm' "$@"
