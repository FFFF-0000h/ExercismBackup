#!/usr/bin/env bash

main() {
    # Check for correct number of arguments
    if [ $# -ne 1 ]; then
        echo "Usage: ${0##*/} <number>"
        return 1
    fi
    
    local number="$1"
    
    # Validate input
    if ! [[ "$number" =~ ^[0-9]+$ ]]; then
        echo "false"
        return 0
    fi
    
    # Remove leading zeros using parameter expansion
    # ${variable##pattern} removes longest matching prefix pattern
    number="${number##+(0)}"
    
    # Handle case where input was all zeros
    [[ -z "$number" ]] && number="0"
    
    # Get number of digits
    local num_digits=${#number}
    
    # Calculate sum of digits^num_digits
    local sum=0
    local i
    for ((i=0; i<num_digits; i++)); do
        local digit=${number:i:1}
        sum=$((sum + digit ** num_digits))
    done
    
    # Compare sum with original number
    if [ "$sum" -eq "$number" ]; then
        echo "true"
    else
        echo "false"
    fi
}

main "$@"