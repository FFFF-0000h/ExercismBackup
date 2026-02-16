#!/usr/bin/env bash

# Usage:
#   ./clock.sh HOUR MINUTE
#   ./clock.sh HOUR MINUTE OPERATOR DELTA_MINUTES
# OPERATOR can be '+' or '-', DELTA_MINUTES is a non‑negative integer.

main() {
    # Validate argument count
    if [[ $# -ne 2 && $# -ne 4 ]]; then
        echo "invalid arguments" >&2
        exit 1
    fi

    # Validate that hour and minute are integers (may be negative? we'll handle)
    if ! [[ $1 =~ ^-?[0-9]+$ ]] || ! [[ $2 =~ ^-?[0-9]+$ ]]; then
        echo "invalid arguments" >&2
        exit 1
    fi

    # Base time in minutes
    local hour=$1 minute=$2
    local total_minutes=$(( hour * 60 + minute ))

    # If 4 arguments, apply the operation
    if [[ $# -eq 4 ]]; then
        local operator=$3 delta=$4
        # Validate operator and delta
        if ! [[ $operator == '+' || $operator == '-' ]]; then
            echo "invalid arguments" >&2
            exit 1
        fi
        if ! [[ $delta =~ ^[0-9]+$ ]]; then
            echo "invalid arguments" >&2
            exit 1
        fi

        if [[ $operator == '+' ]]; then
            total_minutes=$(( total_minutes + delta ))
        else
            total_minutes=$(( total_minutes - delta ))
        fi
    fi

    # Normalize to [0, 1439]
    # Using modulo that works for negative numbers in bash:
    total_minutes=$(( (total_minutes % 1440 + 1440) % 1440 ))

    # Extract hours and minutes
    local result_hour=$(( total_minutes / 60 ))
    local result_min=$(( total_minutes % 60 ))

    # Format with leading zeros
    printf "%02d:%02d\n" "$result_hour" "$result_min"
}

main "$@"