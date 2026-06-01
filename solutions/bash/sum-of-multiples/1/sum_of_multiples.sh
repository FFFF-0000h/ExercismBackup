#!/usr/bin/env bash

main() {
    local level="$1"
    shift
    local sum=0
    local i base

    for ((i = 1; i < level; i++)); do
        for base in "$@"; do
            if (( base != 0 && i % base == 0 )); then
                sum=$((sum + i))
                break
            fi
        done
    done

    echo "$sum"
}

main "$@"