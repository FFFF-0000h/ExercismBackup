#!/usr/bin/env bash

main () {
    # Check number of arguments
    if [ $# -eq 1 ]; then
        # Exactly one argument - treat as person's name
        echo "Hello, $1"
    elif [ $# -eq 0 ] || [ $# -gt 1 ]; then
        # Zero or more than one argument - print error
        echo "Usage: error_handling.sh <person>"
        exit 1
    fi
}

# Call main with all positional arguments
main "$@"