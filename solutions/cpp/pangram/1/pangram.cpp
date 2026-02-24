#include "pangram.h"
#include <cctype>
#include <array>

namespace pangram {
    bool is_pangram(const std::string& sentence) {
        std::array<bool, 26> seen{};
        int count = 0;
        
        for (char ch : sentence) {
            if (std::isalpha(ch)) {
                int index = std::tolower(ch) - 'a';
                if (!seen[index]) {
                    seen[index] = true;
                    ++count;
                    if (count == 26) return true;
                }
            }
        }
        return false;
    }
}