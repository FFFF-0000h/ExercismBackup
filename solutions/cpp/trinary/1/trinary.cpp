#include "trinary.h"
#include <cmath>

namespace trinary {

int to_decimal(std::string trinary) {
    int result = 0;
    int power = trinary.length() - 1;
    
    for (char digit : trinary) {
        // Check if valid trinary digit
        if (digit < '0' || digit > '2') {
            return 0;  // Invalid trinary string
        }
        
        int value = digit - '0';
        result += value * static_cast<int>(std::pow(3, power));
        power--;
    }
    
    return result;
}

}  // namespace trinary