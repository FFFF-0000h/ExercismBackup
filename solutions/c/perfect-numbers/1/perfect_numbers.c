#include "perfect_numbers.h"
#include <math.h>

kind classify_number(int number) {
    // Validate input
    if (number <= 0) {
        return ERROR;
    }
    
    // Special case: 1 has no proper divisors other than itself
    if (number == 1) {
        return DEFICIENT_NUMBER;
    }
    
    int aliquot_sum = 1; // 1 is always a divisor (except for number == 1)
    
    // Only need to check up to sqrt(number)
    int limit = (int)sqrt(number);
    
    for (int i = 2; i <= limit; i++) {
        if (number % i == 0) {
            // Add divisor i
            aliquot_sum += i;
            
            // Add the paired divisor (unless it's the same as i, i.e., square root)
            if (i != number / i) {
                aliquot_sum += number / i;
            }
        }
    }
    
    // Compare aliquot sum with original number
    if (aliquot_sum == number) {
        return PERFECT_NUMBER;
    } else if (aliquot_sum > number) {
        return ABUNDANT_NUMBER;
    } else {
        return DEFICIENT_NUMBER;
    }
}