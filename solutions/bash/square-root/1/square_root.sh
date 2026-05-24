#!/usr/bin/env bash

sqrt() {
    local number=$1
    local low=0
    local high=$number
    local mid

    while (( low <= high )); do
        mid=$(( (low + high) / 2 ))
        local square=$(( mid * mid ))

        if (( square == number )); then
            echo "$mid"
            return
        elif (( square < number )); then
            low=$(( mid + 1 ))
        else
            high=$(( mid - 1 ))
        fi
    done

    # Should not happen for perfect squares
    echo "Error: not a perfect square" >&2
    exit 1
}

main() {
    if (( $# != 1 )); then
        echo "Usage: $0 <number>" >&2
        exit 1
    fi
    sqrt "$1"
}

main "$@"