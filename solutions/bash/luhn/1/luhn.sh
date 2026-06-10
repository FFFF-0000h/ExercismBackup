#!/usr/bin/env bash

main() {
    local number="$1"

    # Remove all spaces
    local cleaned="${number// /}"

    # Must have at least 2 digits
    if [[ ${#cleaned} -le 1 ]]; then
        echo "false"
        return
    fi

    # Check for non-digit characters
    if [[ "$cleaned" =~ [^0-9] ]]; then
        echo "false"
        return
    fi

    local sum=0
    local double=0  # 0 = no double, 1 = double

    # Process from right to left
    for (( i=${#cleaned}-1; i>=0; i-- )); do
        local digit=${cleaned:$i:1}

        if [[ $double -eq 1 ]]; then
            digit=$(( digit * 2 ))
            if [[ $digit -gt 9 ]]; then
                digit=$(( digit - 9 ))
            fi
        fi

        sum=$(( sum + digit ))
        double=$(( 1 - double ))
    done

    if [[ $(( sum % 10 )) -eq 0 ]]; then
        echo "true"
    else
        echo "false"
    fi
}

main "$@"