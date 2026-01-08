#include "collatz_conjecture.h"

int steps(int start) {
    // Error cases: start must be positive
    if (start <= 0) {
        return ERROR_VALUE;
    }
    
    int step_count = 0;
    long n = start;  // Use long to prevent overflow for large numbers
    
    while (n > 1) {
        if (n % 2 == 0) {
            // Even: divide by 2
            n /= 2;
        } else {
            // Odd: 3n + 1
            n = 3 * n + 1;
        }
        step_count++;
        
        // Safety check to prevent infinite loop (though Collatz says it always reaches 1)
        if (step_count > 1000000) {
            // If we've done a million steps, something might be wrong
            return ERROR_VALUE;
        }
    }
    
    return step_count;
}