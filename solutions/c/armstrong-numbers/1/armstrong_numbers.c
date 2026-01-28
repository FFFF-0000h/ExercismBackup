#include "armstrong_numbers.h"
#include <math.h>

bool is_armstrong_number(int candidate) {
    // Handle negative numbers (Armstrong numbers are defined for non-negative integers)
    if (candidate < 0) {
        return false;
    }
    
    // Special case: 0 is an Armstrong number (0^1 = 0)
    if (candidate == 0) {
        return true;
    }
    
    // Count the number of digits
    int num = candidate;
    int digit_count = 0;
    
    while (num > 0) {
        digit_count++;
        num /= 10;
    }
    
    // Calculate sum of digits raised to power of digit_count
    num = candidate;
    long long sum = 0;  // Use long long to avoid overflow for large numbers
    
    while (num > 0) {
        int digit = num % 10;
        
        // Calculate digit^digit_count using pow() from math.h
        // Could also use a loop for integer exponentiation
        sum += (long long)pow(digit, digit_count);
        
        // Early exit if sum exceeds candidate (optimization)
        if (sum > candidate) {
            return false;
        }
        
        num /= 10;
    }
    
    return sum == candidate;
}