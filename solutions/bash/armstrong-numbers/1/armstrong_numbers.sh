#!/usr/bin/env bash

# Function to check if a number is an Armstrong number
is_armstrong() {
    local number="$1"
    
    # Extract digits
    local digits
    digits=$(echo "$number" | grep -o .)
    
    # Count digits
    local num_digits
    num_digits=$(echo "$digits" | wc -l)
    
    # Calculate sum of digits^num_digits
    local sum=0
    while read -r digit; do
        sum=$((sum + digit ** num_digits))
    done <<< "$digits"
    
    # Check if sum equals original number
    if [ "$sum" -eq "$number" ]; then
        echo "true"
    else
        echo "false"
    fi
}

# Main function
main() {
    # Check if argument is provided
    if [ $# -ne 1 ]; then
        echo "Usage: $0 <number>"
        exit 1
    fi
    
    # Validate input is a positive integer
    if ! [[ "$1" =~ ^[0-9]+$ ]]; then
        echo "Error: Input must be a positive integer"
        exit 1
    fi
    
    # Remove leading zeros
    number=$(echo "$1" | sed 's/^0*//')
    
    # Handle case where input was all zeros
    if [ -z "$number" ]; then
        number="0"
    fi
    
    # Check and output result
    is_armstrong "$number"
}

# Call main with all arguments
main "$@"