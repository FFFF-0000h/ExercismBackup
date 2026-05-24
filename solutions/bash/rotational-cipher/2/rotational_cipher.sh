#!/usr/bin/env bash

main() {
    local text="$1"
    local key="$2"

    local result=""
    local len=${#text}

    local i char ascii base shifted_code escape_sequence rotated
    for ((i = 0; i < len; i++)); do
        char="${text:i:1}"

        if [[ $char =~ [a-z] ]]; then
            printf -v ascii "%d" "'$char"
            base=97
            shifted_code=$(( (ascii - base + key) % 26 + base ))
            printf -v escape_sequence '\\%03o' "$shifted_code"
            printf -v rotated '%b' "$escape_sequence"
            result+="$rotated"
        elif [[ $char =~ [A-Z] ]]; then
            printf -v ascii "%d" "'$char"
            base=65
            shifted_code=$(( (ascii - base + key) % 26 + base ))
            printf -v escape_sequence '\\%03o' "$shifted_code"
            printf -v rotated '%b' "$escape_sequence"
            result+="$rotated"
        else
            result+="$char"
        fi
    done

    echo "$result"
}

main "$@"