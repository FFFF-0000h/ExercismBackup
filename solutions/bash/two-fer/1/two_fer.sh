#!/usr/bin/env bash

main () {
    # If name is provided as first argument, use it
    # Otherwise, use "you"
    local name="${1:-you}"
    
    echo "One for $name, one for me."
}

main "$@"