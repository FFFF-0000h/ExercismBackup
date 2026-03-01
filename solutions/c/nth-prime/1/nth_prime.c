#include "nth_prime.h"

uint32_t nth(uint32_t n) {
    // Return the nth prime (n >= 1). If n == 0, return 0 as an error indicator.
    if (n == 0) {
        return 0;
    }

    uint32_t count = 0;          // number of primes found so far
    uint32_t candidate = 2;       // first prime number

    while (1) {
        int is_prime = 1;

        // Test divisibility up to the square root of candidate
        for (uint32_t i = 2; i * i <= candidate; ++i) {
            if (candidate % i == 0) {
                is_prime = 0;
                break;
            }
        }

        if (is_prime) {
            ++count;
            if (count == n) {
                return candidate;
            }
        }

        ++candidate;
    }
}