#!/usr/bin/env bash

main () {
    # Check if argument is provided
    if [ $# -ne 1 ]; then
        echo "Usage: $(basename "$0") <string>"
        exit 1
    fi
    
    local input="$1"
    local reversed=""
    
    # Loop through each character from end to beginning
    for (( i=${#input}-1; i>=0; i-- )); do
        reversed="${reversed}${input:$i:1}"
    done
    
    echo "$reversed"
}

main "$@"