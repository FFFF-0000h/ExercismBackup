#include "grains.h"

namespace grains {

unsigned long long square(int n) {
    // Square number n corresponds to 2^(n-1) grains
    // Use unsigned long long to avoid overflow for n=64
    return 1ULL << (n - 1);
}

unsigned long long total() {
    // Total grains on all 64 squares is 2^64 - 1
    // All bits set in an unsigned 64-bit integer gives exactly that
    return -1ULL;
}

}  // namespace grains