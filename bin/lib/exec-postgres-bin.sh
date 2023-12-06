#!/bin/sh

cmd="$(basename "$0")"
cmd_args="$*"

env_dir=$(dirname $(dirname $(dirname $(readlink -f "$0"))))
compose_path="$env_dir/bin/lib/docker-compose.sh"

exec "$compose_path" "--project-directory=$env_dir/databases" \
    'exec' '' \
    postgres "$cmd $cmd_args"
