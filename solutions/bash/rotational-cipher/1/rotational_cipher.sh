#!/usr/bin/env bash

# Rotational Cipher (Caesar Cipher) implementation in Bash
# Usage: ./rotational_cipher.sh <text> <key>

main() {
    local text="$1"
    local key="$2"

    local result=""
    local len=${#text}

    for ((i = 0; i < len; i++)); do
        local char="${text:i:1}"
        local ascii base rotated shift_val

        if [[ $char =~ [a-z] ]]; then
            printf -v ascii "%d" "'$char"
            base=97
            shift_val=$(( (ascii - base + key) % 26 + base ))
            printf -v rotated "\\$(printf '%03o' "$shift_val")"
            result+="$rotated"
        elif [[ $char =~ [A-Z] ]]; then
            printf -v ascii "%d" "'$char"
            base=65
            shift_val=$(( (ascii - base + key) % 26 + base ))
            printf -v rotated "\\$(printf '%03o' "$shift_val")"
            result+="$rotated"
        else
            result+="$char"
        fi
    done

    echo "$result"
}

main "$@"