#!/usr/bin/env bash

main() {
    # If no arguments, output nothing.
    if [ $# -eq 0 ]; then
        return 0
    fi

    local first="$1"

    # Generate the chain of losses.
    while [ $# -gt 1 ]; do
        echo "For want of a $1 the $2 was lost."
        shift
    done

    # The final line references the very first item.
    echo "And all for the want of a $first."
}

main "$@"