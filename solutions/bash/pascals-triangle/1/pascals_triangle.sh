#!/usr/bin/env bash

main() {
    local rows="$1"

    if [[ $rows -eq 0 ]]; then
        return
    fi

    # Store the triangle rows
    local -a triangle=()

    for ((i = 0; i < rows; i++)); do
        local row=""
        for ((j = 0; j <= i; j++)); do
            if [[ $j -eq 0 || $j -eq $i ]]; then
                if [[ -n "$row" ]]; then
                    row+=" "
                fi
                row+="1"
            else
                # Get values from previous row
                local prev_idx=$((i - 1))
                local prev_row="${triangle[$prev_idx]}"
                read -ra prev_values <<< "$prev_row"
                local left=${prev_values[$((j - 1))]}
                local right=${prev_values[$j]}
                row+=" $((left + right))"
            fi
        done
        triangle[$i]="$row"
    done

    # Print with proper indentation
    for ((i = 0; i < rows; i++)); do
        # Calculate leading spaces to center the triangle
        local spaces=$((rows - 1 - i))
        printf '%*s' "$spaces" ""
        echo "${triangle[$i]}"
    done
}

main "$@"