#!/usr/bin/env bash

main() {
    local input_date="$1"
    local gigasecond=1000000000

    # Convert input to epoch seconds (using UTC)
    local epoch
    epoch=$(TZ=UTC date -d "$input_date" +%s 2>/dev/null)

    if [[ -z "$epoch" ]]; then
        echo "Error: Unable to parse date '$input_date'" >&2
        exit 1
    fi

    local new_epoch=$((epoch + gigasecond))

    # Format output in ISO 8601 without timezone suffix
    TZ=UTC date -d "@$new_epoch" "+%Y-%m-%dT%H:%M:%S"
}

main "$@"