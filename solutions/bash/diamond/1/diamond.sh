#!/usr/bin/env bash

main() {
    local letter="$1"
    local n=$(($(printf '%d' "'$letter") - $(printf '%d' "'A")))
    local width=$((2 * n + 1))

    # Top half (including middle row)
    for ((i = 0; i <= n; i++)); do
        local char=$(printf "\\$(printf '%03o' $(( $(printf '%d' "'A") + i )))")
        local left_spaces=$((n - i))
        local mid_spaces=$((2 * i - 1))

        if ((i == 0)); then
            # First row: just 'A' with leading/trailing spaces
            printf '%*s' "$left_spaces" ""
            printf '%s' "$char"
            printf '%*s' "$left_spaces" ""
        else
            printf '%*s' "$left_spaces" ""
            printf '%s' "$char"
            printf '%*s' "$mid_spaces" ""
            printf '%s' "$char"
            printf '%*s' "$left_spaces" ""
        fi
        echo
    done

    # Bottom half
    for ((i = n - 1; i >= 0; i--)); do
        local char=$(printf "\\$(printf '%03o' $(( $(printf '%d' "'A") + i )))")
        local left_spaces=$((n - i))
        local mid_spaces=$((2 * i - 1))

        if ((i == 0)); then
            printf '%*s' "$left_spaces" ""
            printf '%s' "$char"
            printf '%*s' "$left_spaces" ""
        else
            printf '%*s' "$left_spaces" ""
            printf '%s' "$char"
            printf '%*s' "$mid_spaces" ""
            printf '%s' "$char"
            printf '%*s' "$left_spaces" ""
        fi
        echo
    done
}

main "$@"