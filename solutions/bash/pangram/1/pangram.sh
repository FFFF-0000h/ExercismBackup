#!/usr/bin/env bash

main () {
    # Convert input to lowercase
    local sentence="${1,,}"
    
    # Check for all letters a-z
    for letter in {a..z}; do
        if [[ ! "$sentence" =~ $letter ]]; then
            echo "false"
            return 0
        fi
    done
    
    echo "true"
}

main "$@"