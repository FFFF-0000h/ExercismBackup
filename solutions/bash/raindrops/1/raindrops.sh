#!/usr/bin/env bash

# Function to validate input is a positive integer
validate_input() {
    local input="$1"
    
    # Check if input is provided
    if [[ -z "$input" ]]; then
        echo "Error: No number provided." >&2
        echo "Usage: $(basename "$0") <positive integer>" >&2
        return 1
    fi
    
    # Check if input is a positive integer
    if ! [[ "$input" =~ ^[0-9]+$ ]]; then
        echo "Error: '$input' is not a positive integer." >&2
        echo "Usage: $(basename "$0") <positive integer>" >&2
        return 1
    fi
    
    return 0
}

# Function to convert number to raindrop sounds
convert_to_raindrops() {
    local number=$1
    local result=""
    
    # Check divisibility rules
    if (( number % 3 == 0 )); then
        result+="Pling"
    fi
    
    if (( number % 5 == 0 )); then
        result+="Plang"
    fi
    
    if (( number % 7 == 0 )); then
        result+="Plong"
    fi
    
    # Return number if no sounds were generated
    [[ -z "$result" ]] && echo "$number" || echo "$result"
}

main() {
    # Validate input
    validate_input "$1" || exit 1
    
    # Convert and output result
    convert_to_raindrops "$1"
}

main "$@"