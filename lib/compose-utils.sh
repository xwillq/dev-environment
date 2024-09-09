find_compose_config() {
    # Docker compose looks for configs in this order.
    for file in compose.yaml compose.yml docker-compose.yml docker-compose.yaml; do
        if [ -e $file ]; then
            echo $file
            return
        fi
    done

    echo 'Compose config not found' >&2
    return 1
}

find_compose_config_override() {
    # Docker compose looks for config overrides in this order. Name of main
    # config is not important and only the first found override file is used.
    for file in compose.override.yml compose.override.yaml docker-compose.override.yml docker-compose.override.yaml; do
        if [ -e $file ]; then
            echo $file
            return
        fi
    done

    echo 'Compose config override not found' >&2
    return 1
}

find_defined_service() {
    if ! defined_services="$(command docker --log-level=error compose config --services 2>&1)"; then
        echo "Failed to find required service with docker error: $defined_services" >&2
        return 2
    fi

    for service; do
        for defined_service in $defined_services; do
            if [ $defined_service = "$service" ]; then
                echo $defined_service
                return
            fi
        done
    done

    echo 'Failed to find required service. Make sure one of the following services exists:' >&2
    for service; do
        echo "$service" >&2
    done
    return 1
}

find_defined_service_yq() {
    if ! defined_services="$(command yq '.services[] | key' "$1" 2>&1)"; then
        echo "Failed to find required service with yq error: $defined_services" >&2
        return 2
    fi

    shift

    for service; do
        for defined_service in $defined_services; do
            if [ $defined_service = "$service" ]; then
                echo $defined_service
                return
            fi
        done
    done

    echo 'Failed to find required service. Make sure one of the following services exists:' >&2
    for service; do
        echo "$service" >&2
    done
    return 1
}
