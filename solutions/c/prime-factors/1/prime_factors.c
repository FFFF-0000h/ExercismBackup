#include "prime_factors.h"

size_t find_factors(uint64_t n, uint64_t factors[static MAXFACTORS]) {
    size_t count = 0;
    uint64_t divisor = 2;

    while (divisor * divisor <= n) {
        while (n % divisor == 0) {
            factors[count++] = divisor;
            n /= divisor;
        }
        divisor++;
    }

    if (n > 1) {
        factors[count++] = n;
    }

    return count;
}