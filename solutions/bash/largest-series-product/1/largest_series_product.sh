#!/usr/bin/env bash

# Function to validate input
validate_input() {
    local input="$1"
    local span="$2"
    
    # Check if input contains only digits
    if [[ ! "$input" =~ ^[0-9]*$ ]]; then
        echo "input must only contain digits" >&2
        exit 1
    fi
    
    # Check if span is negative
    if [[ "$span" -lt 0 ]]; then
        echo "span must not be negative" >&2
        exit 1
    fi
    
    # Check if span is zero
    if [[ "$span" -eq 0 ]]; then
        echo "span must not be zero" >&2
        exit 1
    fi
    
    # Check if span is not longer than input
    if [[ "$span" -gt "${#input}" ]]; then
        echo "span must not exceed string length" >&2
        exit 1
    fi
}

# Function to calculate product of digits in a string
calculate_product() {
    local str="$1"
    local product=1
    
    # Iterate through each character
    for (( i=0; i<${#str}; i++ )); do
        digit="${str:$i:1}"
        product=$((product * digit))
    done
    
    echo "$product"
}

# Main function
main() {
    # Check number of arguments
    if [[ $# -ne 2 ]]; then
        echo "Usage: $0 <digits> <span>" >&2
        exit 1
    fi
    
    local input="$1"
    local span="$2"
    
    # Validate input
    validate_input "$input" "$span"
    
    # Handle empty string with valid span
    if [[ -z "$input" ]] && [[ "$span" -eq 0 ]]; then
        echo 1
        return 0
    fi
    
    # Initialize max product (start with first product)
    local max_product=0
    local first_product_calculated=0
    
    # Iterate through all possible series
    for (( i=0; i <= ${#input} - span; i++ )); do
        series="${input:i:span}"
        product=$(calculate_product "$series")
        
        # Update max product
        if [[ $first_product_calculated -eq 0 ]] || [[ "$product" -gt "$max_product" ]]; then
            max_product="$product"
            first_product_calculated=1
        fi
    done
    
    echo "$max_product"
}

# Call main with all positional arguments
main "$@"