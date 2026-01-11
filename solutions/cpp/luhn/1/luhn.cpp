#include "luhn.h"
#include <algorithm>
#include <cctype>
#include <iostream>

namespace luhn {

bool valid(const std::string& input) {
    // Remove spaces
    std::string cleaned;
    for (char c : input) {
        if (!std::isspace(static_cast<unsigned char>(c))) {
            cleaned.push_back(c);
        }
    }
    
    // Check if string has length 1 or less
    if (cleaned.length() <= 1) {
        return false;
    }
    
    // Check if all characters are digits
    for (char c : cleaned) {
        if (!std::isdigit(static_cast<unsigned char>(c))) {
            return false;
        }
    }
    
    // Luhn algorithm
    int sum = 0;
    bool doubleDigit = false;
    
    // Process from right to left
    for (int i = cleaned.length() - 1; i >= 0; --i) {
        int digit = cleaned[i] - '0';
        
        if (doubleDigit) {
            digit *= 2;
            if (digit > 9) {
                digit -= 9;
            }
        }
        
        sum += digit;
        doubleDigit = !doubleDigit;  // Toggle for next digit
    }
    
    return (sum % 10 == 0);
}

}  // namespace luhn