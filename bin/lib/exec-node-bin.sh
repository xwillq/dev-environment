#!/bin/sh

cmd="$(basename "$0")"
cmd_args="$*"

docker_path="$(dirname $(readlink -f "$0"))/docker.sh"

env_variables=(
    NODE_OPTIONS
)

env_args=''
for var in $env_variables; do
    env_args="$env_args --env=$var"
done

cache_dir='/cache'
cache_args="--volume=npm-cache:$cache_dir --env=NPM_CONFIG_CACHE=$cache_dir"

workdir='/app'
workdir_args="--volume=$PWD:$workdir --workdir=$workdir"


exec "$docker_path" "$workdir_args $cache_args $env_args" \
    node:${NODE_VERSION:-lts}-alpine "$cmd $cmd_args"
