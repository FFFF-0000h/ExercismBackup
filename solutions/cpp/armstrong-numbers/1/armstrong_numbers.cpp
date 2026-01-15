#include "armstrong_numbers.h"
#include <cmath>
#include <string>

namespace armstrong_numbers {

bool is_armstrong_number(int number) {
    // Convert number to string to easily get digits and count
    std::string num_str = std::to_string(number);
    int num_digits = num_str.length();
    
    // Calculate sum of digits raised to power of num_digits
    int sum = 0;
    int original_number = number;
    
    // Handle negative numbers (Armstrong numbers are typically non-negative)
    if (number < 0) {
        return false;
    }
    
    // Special case: 0 is an Armstrong number (0^1 = 0)
    if (number == 0) {
        return true;
    }
    
    // Calculate using arithmetic (more efficient than string operations)
    int temp = number;
    while (temp > 0) {
        int digit = temp % 10;
        sum += static_cast<int>(std::pow(digit, num_digits));
        temp /= 10;
    }
    
    return sum == original_number;
}

}  // namespace armstrong_numbers