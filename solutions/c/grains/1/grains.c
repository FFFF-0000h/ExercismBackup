#include "grains.h"
#include <math.h>

uint64_t square(uint8_t index) {
    // Check for valid square (1-64)
    if (index < 1 || index > 64) {
        return 0;
    }
    
    // Square n has 2^(n-1) grains
    // Using bit shift for powers of 2
    return (uint64_t)1 << (index - 1);
}

uint64_t total(void) {
    // Sum of geometric series: 2^0 + 2^1 + ... + 2^63 = 2^64 - 1
    // Since we're using 64-bit unsigned int, this equals UINT64_MAX
    return UINT64_MAX;
}