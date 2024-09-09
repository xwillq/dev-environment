find_composer_config() {
    dir="${PWD%/}"

    while [ ! -e "$dir/composer.json" -a -n "$dir"]; do
        dir="${dir%/*}"
    done

    if [ ! -e "$dir/composer.json" ]; then
        return 1
    fi

    echo "$dir/composer.json"
}
