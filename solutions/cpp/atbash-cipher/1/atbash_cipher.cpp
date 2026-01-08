#include "atbash_cipher.h"
#include <string>
#include <cctype>
#include <algorithm>

namespace atbash_cipher {

namespace {
    // Helper function to encode/decode a single character
    char atbash_char(char ch) {
        if (std::isdigit(ch)) {
            return ch;  // Numbers remain unchanged
        }
        
        if (std::isalpha(ch)) {
            // Atbash transformation: a↔z, b↔y, etc.
            // For lowercase: 'a' (97) + 'z' (122) = 219
            // So encoded = 219 - original
            return static_cast<char>(219 - std::tolower(ch));
        }
        
        // Non-alphanumeric characters are ignored in encoding
        return '\0';
    }
}

std::string encode(const std::string& text) {
    std::string result;
    int char_count = 0;
    
    for (char ch : text) {
        char encoded = atbash_char(ch);
        
        if (encoded != '\0') {
            // Add space every 5 characters (but not before the first character)
            if (char_count > 0 && char_count % 5 == 0) {
                result += ' ';
            }
            
            result += encoded;
            char_count++;
        }
    }
    
    return result;
}

std::string decode(const std::string& text) {
    std::string result;
    
    for (char ch : text) {
        if (ch == ' ') {
            continue;  // Skip spaces in decoding
        }
        
        char decoded = atbash_char(ch);
        if (decoded != '\0') {
            result += decoded;
        }
    }
    
    return result;
}

}  // namespace atbash_cipher