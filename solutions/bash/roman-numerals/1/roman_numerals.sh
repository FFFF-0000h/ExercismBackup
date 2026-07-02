#!/usr/bin/env bash

# Convert Arabic numeral to Roman numeral
convert_to_roman() {
    local number=$1
    local result=""
    
    # Define the Roman numeral mappings in descending order
    local values=(1000 900 500 400 100 90 50 40 10 9 5 4 1)
    local numerals=("M" "CM" "D" "CD" "C" "XC" "L" "XL" "X" "IX" "V" "IV" "I")
    
    # Iterate through each value-symbol pair
    for ((i = 0; i < ${#values[@]}; i++)); do
        local value=${values[i]}
        local numeral=${numerals[i]}
        
        # While the number is greater than or equal to the current value
        while ((number >= value)); do
            result+="$numeral"
            ((number -= value))
        done
    done
    
    echo "$result"
}

main() {
    # Check if an argument was provided
    if [[ -z "$1" ]]; then
        echo "Usage: $0 <number>"
        exit 1
    fi
    
    local arabic_number=$1
    
    # Validate input is a number
    if ! [[ "$arabic_number" =~ ^[0-9]+$ ]]; then
        echo "Error: Input must be a positive integer"
        exit 1
    fi
    
    # Validate range (1-3999)
    if ((arabic_number < 1 || arabic_number > 3999)); then
        echo "Error: Number must be between 1 and 3999"
        exit 1
    fi
    
    # Convert and display the result
    local roman_numeral=$(convert_to_roman "$arabic_number")
    echo "$roman_numeral"
}

# Call main with all positional arguments
main "$@"