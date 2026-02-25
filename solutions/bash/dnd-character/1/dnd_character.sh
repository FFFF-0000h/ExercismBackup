#!/usr/bin/env bash

diceroll() {
    echo $((1 + RANDOM % 6))
}

score() {
    nums=()
    for (( i = 0; i < 4; i++ )); do
        nums+=("$(diceroll)")
    done
    mapfile -t sorted < <(printf "%s\n" "${nums[@]}" | sort -nr)
    total=0
    for (( i = 0; i < 3; i++ )); do
        (( total += sorted[i] ))
    done
    echo "$total"
}

calc_modifier() {
    val=$(( $1 - 10 ))
    echo "scale=0; ($val / 2) - ($val < 0 && $val % 2 != 0)" | bc
}

main() {
    if [[ "$1" == "modifier" ]]; then
        modifier=$(calc_modifier "$2")
        echo "$modifier"
    else
        constitution=$(score)
        hitpoints=$((10 + $(calc_modifier constitution)))
        echo "strength $(score)"
        echo "dexterity $(score)"
        echo "constitution $constitution"
        echo "intelligence $(score)"
        echo "wisdom $(score)"
        echo "charisma $(score)"
        echo "hitpoints $hitpoints"
    fi
}

main "$@"
