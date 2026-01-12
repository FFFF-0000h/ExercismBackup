#include "hexadecimal.h"
#include <string>
#include <cctype>
#include <cmath>

namespace hexadecimal {

int convert(std::string hex) {
    int decimal = 0;
    int power = 0;
    
    // Process string from right to left (least significant to most)
    for (int i = hex.length() - 1; i >= 0; i--) {
        char c = hex[i];
        int digit_value;
        
        // Convert character to digit value
        if (c >= '0' && c <= '9') {
            digit_value = c - '0';
        } else if (c >= 'a' && c <= 'f') {
            digit_value = c - 'a' + 10;
        } else if (c >= 'A' && c <= 'F') {
            digit_value = c - 'A' + 10;
        } else {
            // Invalid character - return 0 as specified
            return 0;
        }
        
        // Add contribution of this digit: digit_value * 16^power
        decimal += digit_value * static_cast<int>(std::pow(16, power));
        power++;
    }
    
    return decimal;
}

}  // namespace hexadecimal