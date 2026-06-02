#!/usr/bin/env bash

main() {
    local letter="$1"
    local n
    n=$(($(printf '%d' "'$letter") - $(printf '%d' "'A")))
    local width="$((2 * n + 1))"

    # Top half (including middle row)
    for ((i = 0; i <= n; i++)); do
        local char_code
        char_code=$(( $(printf '%d' "'A") + i ))
        local char
        char=$(printf "\\$(printf '%03o' "$char_code")")
        local left_spaces="$((n - i))"
        local mid_spaces="$((2 * i - 1))"

        printf '%*s' "$left_spaces" ""

        if ((i == 0)); then
            printf '%s' "$char"
        else
            printf '%s' "$char"
            printf '%*s' "$mid_spaces" ""
            printf '%s' "$char"
        fi

        printf '%*s\n' "$left_spaces" ""
    done

    # Bottom half
    for ((i = n - 1; i >= 0; i--)); do
        local char_code
        char_code=$(( $(printf '%d' "'A") + i ))
        local char
        char=$(printf "\\$(printf '%03o' "$char_code")")
        local left_spaces="$((n - i))"
        local mid_spaces="$((2 * i - 1))"

        printf '%*s' "$left_spaces" ""

        if ((i == 0)); then
            printf '%s' "$char"
        else
            printf '%s' "$char"
            printf '%*s' "$mid_spaces" ""
            printf '%s' "$char"
        fi

        printf '%*s\n' "$left_spaces" ""
    done
}

main "$@"