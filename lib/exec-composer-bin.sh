#!/usr/bin/env sh

set -e

set -- "vendor/bin/${0##*/}" "$@"

script_path="$(readlink -f "$0")"
lib_path="${script_path%/*}"

exec "$lib_path/exec-in-php-service.sh" "$@"
