#!/usr/bin/env bash

# Count the number of 1 bits in the binary representation of a number.
# Usage: ./script.sh <number>

main() {
    local n=${1:-0}       # default to 0 if no argument
    local count=0

    # Loop until n becomes zero
    while (( n > 0 )); do
        # Add the least significant bit to count
        (( count += n & 1 ))
        # Right shift to examine the next bit
        (( n >>= 1 ))
    done

    echo "$count"
}

main "$@"