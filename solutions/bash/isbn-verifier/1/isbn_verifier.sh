#!/usr/bin/env bash

main() {
    local isbn="$1"

    # Remove hyphens
    local cleaned="${isbn//-/}"

    # Must be exactly 10 characters
    if [[ ${#cleaned} -ne 10 ]]; then
        echo "false"
        return
    fi

    local sum=0
    local weight=10

    for (( i=0; i<10; i++ )); do
        local char="${cleaned:$i:1}"

        if [[ "$char" =~ [0-9] ]]; then
            sum=$(( sum + char * weight ))
        elif [[ "$char" == "X" || "$char" == "x" ]]; then
            # X is only valid as the last character
            if [[ $i -ne 9 ]]; then
                echo "false"
                return
            fi
            sum=$(( sum + 10 * weight ))
        else
            echo "false"
            return
        fi

        weight=$(( weight - 1 ))
    done

    if [[ $(( sum % 11 )) -eq 0 ]]; then
        echo "true"
    else
        echo "false"
    fi
}

main "$@"