#!/usr/bin/env bash

# Helper functions
square_of_sum() {
    local n=$1
    # Formula: [n(n+1)/2]^2
    local sum
    sum=$(( n * (n + 1) / 2 ))
    echo $(( sum * sum ))
}

sum_of_squares() {
    local n=$1
    # Formula: n(n+1)(2n+1)/6
    local product
    product=$(( n * (n + 1) * (2 * n + 1) ))
    echo $(( product / 6 ))
}

difference() {
    local n=$1
    # Formula: square_of_sum - sum_of_squares
    local square_sum
    local sum_square
    square_sum=$(square_of_sum "$n")
    sum_square=$(sum_of_squares "$n")
    echo $(( square_sum - sum_square ))
}

# Main function
main() {
    if [ $# -ne 2 ]; then
        echo "Usage: $0 {square_of_sum|sum_of_squares|difference} <number>"
        exit 1
    fi
    
    local operation=$1
    local n=$2
    
    # Validate number
    if ! [[ "$n" =~ ^[0-9]+$ ]] || [ "$n" -lt 0 ]; then
        echo "Error: Please provide a non-negative integer"
        exit 1
    fi
    
    case "$operation" in
        "square_of_sum")
            square_of_sum "$n"
            ;;
        "sum_of_squares")
            sum_of_squares "$n"
            ;;
        "difference")
            difference "$n"
            ;;
        *)
            echo "Error: Unknown operation '$operation'"
            echo "Valid operations: square_of_sum, sum_of_squares, difference"
            exit 1
            ;;
    esac
}

# Call main with all arguments
main "$@"