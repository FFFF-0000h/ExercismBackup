#include "hamming.h"
#include <string.h>

int compute(const char *lhs, const char *rhs) {
    // Check if either string is NULL
    if (lhs == NULL || rhs == NULL) {
        return -1;
    }
    
    // Get lengths of both strings
    size_t lhs_len = strlen(lhs);
    size_t rhs_len = strlen(rhs);
    
    // Check if lengths are equal
    if (lhs_len != rhs_len) {
        return -1;
    }
    
    // Calculate Hamming distance
    int distance = 0;
    for (size_t i = 0; i < lhs_len; i++) {
        if (lhs[i] != rhs[i]) {
            distance++;
        }
    }
    
    return distance;
}