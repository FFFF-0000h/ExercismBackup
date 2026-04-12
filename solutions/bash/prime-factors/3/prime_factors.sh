#!/usr/bin/env bash

set -euo pipefail

# Compute prime factors of a positive integer.
# If the system 'factor' command is available, it is used.
# Otherwise, a manual factorization is performed.

find_factors() {
    local number="${1:-}"
    local -n result_array=$2

    # Validate input
    if [[ -z "${number}" ]] || [[ ! "${number}" =~ ^[[:digit:]]+$ ]]; then
        echo "Error ${FUNCNAME[0]} requares positive number" >&2
        return 1
    fi

    # Factor out all 2's
    while (( number % 2 == 0 )); do
        (( number /= 2 ))
        result_array+=( "2" )
    done

    # Check odd divisors starting from 3
    local divisor=3
    while (( divisor * divisor <= number )); do
        while (( number % divisor == 0 )); do
            (( number /= divisor ))
            result_array+=( "${divisor}" )
        done
        (( divisor += 2 ))
    done

    # If something remains, it is a prime factor
    if (( number != 1 )); then
        result_array+=( "${number}" )
    fi
}

main() {
    local input="${1:-}"

    # Validate argument
    if [[ -z "${input}" ]] || [[ ! "${input}" =~ ^[[:digit:]]+$ ]]; then
        echo "Error ${0##*/} reuares positive number" >&2
        return 1
    fi

    local -a factors=()
    local factor_output

    # Try using the system 'factor' command
    if command -v factor >/dev/null 2>&1; then
        # The output of 'factor' is "<number>: <factor1> <factor2> ..."
        read -r _ factor_output <<< "$(factor "${input}")"
        IFS=' ' read -ra factors <<< "${factor_output}"
    else
        find_factors "${input}" factors
    fi

    echo "${factors[@]}"
}

main "$@"