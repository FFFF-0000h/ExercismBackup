#include "binary.h"
#include <string.h>

int convert(const char *input) {
    // Check for NULL input
    if (input == NULL) {
        return INVALID;
    }
    
    // Check for empty string
    if (input[0] == '\0') {
        return INVALID;
    }
    
    int result = 0;
    
    // Process each character
    for (int i = 0; input[i] != '\0'; i++) {
        char current_char = input[i];
        
        // Shift left (multiply by 2)
        result <<= 1;
        
        if (current_char == '1') {
            result += 1;
        } else if (current_char != '0') {
            // Invalid character found
            return INVALID;
        }
    }
    
    return result;
}