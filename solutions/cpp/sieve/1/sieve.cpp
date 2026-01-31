#include "sieve.h"
#include <vector>
#include <algorithm>

namespace sieve {

std::vector<int> primes(int limit) {
    // Handle edge cases
    if (limit < 2) {
        return {};
    }
    
    // Create a boolean array "prime[0..limit]" and initialize
    // all entries as true. A value in prime[i] will finally be
    // false if i is Not a prime, else true.
    std::vector<bool> is_prime(limit + 1, true);
    
    // 0 and 1 are not prime numbers
    is_prime[0] = false;
    is_prime[1] = false;
    
    // Sieve of Eratosthenes
    for (int p = 2; p * p <= limit; p++) {
        // If is_prime[p] is not changed, then it is a prime
        if (is_prime[p]) {
            // Mark all multiples of p as not prime
            for (int i = p * p; i <= limit; i += p) {
                is_prime[i] = false;
            }
        }
    }
    
    // Collect all prime numbers
    std::vector<int> result;
    for (int i = 2; i <= limit; i++) {
        if (is_prime[i]) {
            result.push_back(i);
        }
    }
    
    return result;
}

}  // namespace sieve