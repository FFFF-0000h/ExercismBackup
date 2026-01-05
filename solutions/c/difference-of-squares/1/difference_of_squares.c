#include "difference_of_squares.h"

unsigned int sum_of_squares(unsigned int number) {
    // Formula: n(n+1)(2n+1)/6
    return number * (number + 1) * (2 * number + 1) / 6;
}

unsigned int square_of_sum(unsigned int number) {
    // Formula: (n(n+1)/2)²
    unsigned int sum = number * (number + 1) / 2;
    return sum * sum;
}

unsigned int difference_of_squares(unsigned int number) {
    // Could compute directly: n(n+1)(3n+2)(n-1)/12
    // But simpler to use the existing functions
    return square_of_sum(number) - sum_of_squares(number);
}