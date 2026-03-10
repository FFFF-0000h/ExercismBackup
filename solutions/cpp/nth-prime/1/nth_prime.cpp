// nth_prime.cpp
#include "nth_prime.h"
#include <stdexcept>

namespace nth_prime {

int nth(int n) {
    if (n <= 0) {
        throw std::domain_error("n must be a positive integer");
    }

    int count = 0;
    int candidate = 2;

    while (true) {
        bool is_prime = true;
        // Check divisibility up to sqrt(candidate)
        for (int i = 2; i * i <= candidate; ++i) {
            if (candidate % i == 0) {
                is_prime = false;
                break;
            }
        }
        if (is_prime) {
            ++count;
            if (count == n) {
                return candidate;
            }
        }
        // Increment candidate; after 2 we can skip even numbers
        ++candidate;
    }
}

}  // namespace nth_prime