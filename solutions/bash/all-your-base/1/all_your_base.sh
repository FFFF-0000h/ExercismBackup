#!/usr/bin/env bash

main() {
    local input_base="$1"
    local digits_str="$2"
    local output_base="$3"

    # Validate bases
    if ! [[ "$input_base" =~ ^[0-9]+$ ]] || [[ "$input_base" -lt 2 ]]; then
        echo "Input base must be an integer >= 2" >&2
        exit 1
    fi
    if ! [[ "$output_base" =~ ^[0-9]+$ ]] || [[ "$output_base" -lt 2 ]]; then
        echo "Output base must be an integer >= 2" >&2
        exit 1
    fi

    # Empty digit string -> output 0
    if [[ -z "$digits_str" ]]; then
        echo "0"
        return
    fi

    # Split digits into array
    IFS=' ' read -ra digits <<< "$digits_str"

    # Convert from input base to decimal
    local decimal=0
    for digit in "${digits[@]}"; do
        # Must be a non-negative integer
        if ! [[ "$digit" =~ ^[0-9]+$ ]]; then
            echo "Invalid digit: $digit" >&2
            exit 1
        fi
        if (( digit >= input_base )); then
            echo "Digit too large: $digit" >&2
            exit 1
        fi
        decimal=$(( decimal * input_base + digit ))
    done

    # Convert decimal to output base
    if (( decimal == 0 )); then
        echo "0"
        return
    fi

    local result=""
    while (( decimal > 0 )); do
        local rem=$(( decimal % output_base ))
        result="$rem $result"
        decimal=$(( decimal / output_base ))
    done

    # Remove trailing space
    echo "${result% }"
}

main "$@"