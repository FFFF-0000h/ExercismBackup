#!/usr/bin/env bash

# Function to get ordinal suffix for a number
get_ordinal_suffix() {
    local num=$1
    
    # Handle special cases: 11, 12, 13
    local last_two=$((num % 100))
    if [[ $last_two -ge 11 && $last_two -le 13 ]]; then
        echo "th"
        return
    fi
    
    # Handle other cases based on last digit
    local last_digit=$((num % 10))
    case $last_digit in
        1) echo "st" ;;
        2) echo "nd" ;;
        3) echo "rd" ;;
        *) echo "th" ;;
    esac
}

# Main function
main() {
    local name="$1"
    local number="$2"
    
    # Validate input
    if [[ $# -ne 2 ]]; then
        echo "Usage: $0 <name> <number>"
        exit 1
    fi
    
    # Validate number is between 1 and 999
    if ! [[ "$number" =~ ^[0-9]+$ ]]; then
        echo "Error: Number must be an integer"
        exit 1
    fi
    
    if [[ $number -lt 1 || $number -gt 999 ]]; then
        echo "Error: Number must be between 1 and 999"
        exit 1
    fi
    
    # Get ordinal suffix
    local suffix
    suffix=$(get_ordinal_suffix "$number")
    
    # Output the greeting
    echo "$name, you are the ${number}${suffix} customer we serve today. Thank you!"
}

# Call main with all arguments
main "$@"