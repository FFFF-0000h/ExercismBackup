#include "sum_of_multiples.h"
#include <stdbool.h>
#include <stdlib.h>

unsigned int sum(const unsigned int *factors, const size_t number_of_factors,
                 const unsigned int limit) {
    
    // Handle edge cases
    if (factors == NULL || number_of_factors == 0 || limit == 0) {
        return 0;
    }
    
    // Allocate a boolean array to mark visited multiples
    // We'll only allocate for limit elements since we only care about numbers < limit
    bool *visited = calloc(limit, sizeof(bool));
    if (visited == NULL) {
        return 0;  // Memory allocation failed
    }
    
    unsigned int total = 0;
    
    // For each factor
    for (size_t i = 0; i < number_of_factors; i++) {
        unsigned int factor = factors[i];
        
        // Skip factor 0
        if (factor == 0) {
            continue;
        }
        
        // Find all multiples of this factor less than limit
        for (unsigned int multiple = factor; multiple < limit; multiple += factor) {
            // If we haven't seen this multiple before, add it to total
            if (!visited[multiple]) {
                visited[multiple] = true;
                total += multiple;
            }
        }
    }
    
    free(visited);
    return total;
}