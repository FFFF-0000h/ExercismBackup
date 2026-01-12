#!/usr/bin/env bash

# Handle "total" case first
if [[ "$1" == "total" ]]; then
    echo "18446744073709551615"
    exit 0
fi

# Validate the input is a number
if ! [[ "$1" =~ ^-?[0-9]+$ ]]; then
    echo "Error: invalid input"
    exit 1
fi

square=$1

# Check bounds: must be between 1 and 64 inclusive
if (( square < 1 || square > 64 )); then
    echo "Error: invalid input"
    exit 1
fi

# Special case for square 64 (2^63) which overflows in bash
if (( square == 64 )); then
    echo "9223372036854775808"
    exit 0
fi

# For other squares, use bit shifting
echo "$((1 << (square - 1)))"