#include "reverse_string.h"

namespace reverse_string {

std::string reverse_string(const std::string& str) {
    std::string reversed;
    reversed.reserve(str.length());  // Pre-allocate memory
    
    for (int i = str.length() - 1; i >= 0; i--) {
        reversed.push_back(str[i]);
    }
    
    return reversed;
}

}  // namespace reverse_string