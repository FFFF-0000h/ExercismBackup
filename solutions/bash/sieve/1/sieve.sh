#!/usr/bin/env bash

# Sieve of Eratosthenes - Bash implementation
# Prints all prime numbers up to (and including) the given limit,
# as a single space-separated line.

main() {
    local limit=$1
    local primes=()

    # No primes below 2
    if (( limit < 2 )); then
        echo ""
        exit 0
    fi

    local -a sieve   # indexed array: 0 = prime, 1 = composite
    local p i

    # Mark multiples of each prime p starting from 2
    for (( p = 2; p * p <= limit; p++ )); do
        if (( sieve[p] == 0 )); then
            for (( i = p * p; i <= limit; i += p )); do
                sieve[i]=1
            done
        fi
    done

    # Collect all unmarked numbers (primes)
    for (( i = 2; i <= limit; i++ )); do
        if (( sieve[i] == 0 )); then
            primes+=("$i")
        fi
    done

    # Output primes space-separated
    echo "${primes[*]}"
}

main "$@"