#!/usr/bin/env bash

main() {
    local planet="$1"
    local seconds="$2"
    local earth_year_sec=31557600.0

    declare -A periods
    periods["Mercury"]=0.2408467
    periods["Venus"]=0.61519726
    periods["Earth"]=1.0
    periods["Mars"]=1.8808158
    periods["Jupiter"]=11.862615
    periods["Saturn"]=29.447498
    periods["Uranus"]=84.016846
    periods["Neptune"]=164.79132

    if [[ -z "${periods[$planet]}" ]]; then
        echo "not a planet" >&2
        exit 1
    fi

    local period="${periods[$planet]}"

    awk -v seconds="$seconds" -v period="$period" -v earth="$earth_year_sec" '
        BEGIN {
            age = seconds / earth / period;
            printf "%.2f\n", age;
        }
    '
}

main "$@"