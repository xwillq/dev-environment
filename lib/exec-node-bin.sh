#!/usr/bin/env sh

set -e

set -- "${0##*/}" "$@"

script_path="$(readlink -f "$0")"
lib_path="${script_path%/*}"

if [ "$IMAGE" ]; then
    set -- "$IMAGE" "$@"
elif [ "$NODE_IMAGE" ]; then
    set -- "$NODE_IMAGE" "$@"
elif [ "$NODE_VERSION" ]; then
    set -- "node:$NODE_VERSION" "$@"
else
    set -- 'node:lts' "$@"
fi

cache_dir="/tmp"
set -- "--env=NPM_CONFIG_CACHE=$cache_dir/npm" "--volume=node-cache:$cache_dir" "$@"

ENV='NODE_OPTIONS'

. "$lib_path/set-docker-parameters.sh"

exec docker "$@"
