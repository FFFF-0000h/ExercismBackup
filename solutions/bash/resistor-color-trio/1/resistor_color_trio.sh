#!/usr/bin/env bash

declare -A COLORS=(
    [black]=0
    [brown]=1
    [red]=2
    [orange]=3
    [yellow]=4
    [green]=5
    [blue]=6
    [violet]=7
    [grey]=8
    [white]=9
)

main() {
    local color1="$1"
    local color2="$2"
    local color3="$3"

    # Validate colors
    if [[ -z "${COLORS[$color1]}" || -z "${COLORS[$color2]}" || -z "${COLORS[$color3]}" ]]; then
        echo "Invalid color(s)"
        exit 1
    fi

    local digit1="${COLORS[$color1]}"
    local digit2="${COLORS[$color2]}"
    local exponent="${COLORS[$color3]}"

    local main_value=$(( 10 * digit1 + digit2 ))
    local value=$(( main_value * 10 ** exponent ))

    local divisor=1
    local prefix=""

    if (( value >= 1000000000 )); then
        divisor=1000000000
        prefix="giga"
    elif (( value >= 1000000 )); then
        divisor=1000000
        prefix="mega"
    elif (( value >= 1000 )); then
        divisor=1000
        prefix="kilo"
    fi

    if (( divisor > 1 )); then
        if (( value % divisor == 0 )); then
            echo "$(( value / divisor )) ${prefix}ohms"
        else
            echo "$value ohms"
        fi
    else
        echo "$value ohms"
    fi
}

main "$@"