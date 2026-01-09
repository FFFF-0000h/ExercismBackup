#include "rotational_cipher.h"
#include <string>
#include <cctype>

namespace rotational_cipher {

std::string rotate(std::string text, int shift_key) {
    // Normalize the shift key to handle values > 26 or < 0
    shift_key = shift_key % 26;
    if (shift_key < 0) {
        shift_key += 26;  // Handle negative shifts
    }
    
    std::string result;
    result.reserve(text.length());  // Pre-allocate memory for efficiency
    
    for (char ch : text) {
        if (std::isalpha(ch)) {
            char base = std::islower(ch) ? 'a' : 'A';
            // Apply shift with modulo 26 to wrap around alphabet
            char shifted = static_cast<char>((ch - base + shift_key) % 26 + base);
            result.push_back(shifted);
        } else {
            // Non-alphabetic characters remain unchanged
            result.push_back(ch);
        }
    }
    
    return result;
}

}  // namespace rotational_cipher