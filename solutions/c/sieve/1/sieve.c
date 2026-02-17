#include "sieve.h"
#include <stdlib.h>

uint32_t sieve(uint32_t limit, uint32_t *primes, size_t max_primes) {
    if (limit < 2) return 0;

    // Allocate a boolean array for numbers 0..limit
    uint8_t *is_prime = (uint8_t*)calloc(limit + 1, sizeof(uint8_t));
    if (!is_prime) return 0; // allocation failed

    // Initially mark all numbers from 2 as prime
    for (uint32_t i = 2; i <= limit; ++i) {
        is_prime[i] = 1;
    }

    // Sieve of Eratosthenes
    for (uint32_t p = 2; p * p <= limit; ++p) {
        if (is_prime[p]) {
            for (uint32_t multiple = p * p; multiple <= limit; multiple += p) {
                is_prime[multiple] = 0;
            }
        }
    }

    // Collect primes, up to max_primes
    uint32_t count = 0;
    for (uint32_t i = 2; i <= limit && count < max_primes; ++i) {
        if (is_prime[i]) {
            primes[count++] = i;
        }
    }

    free(is_prime);
    return count;
}