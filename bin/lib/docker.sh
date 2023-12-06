#!/bin/sh

docker_command_args="$1"
image="$2"
cmd="$3"

if [ -t 0 ]; then
    docker_command_args="$docker_command_args --tty --interactive"
fi

exec docker run --rm $docker_command_args $image $cmd
