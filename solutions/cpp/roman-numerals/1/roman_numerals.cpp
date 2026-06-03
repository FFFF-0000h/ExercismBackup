#include "roman_numerals.h"
#include <vector>

namespace roman_numerals {

    std::string convert(int number) {
        const std::vector<int> values = {1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1};
        const std::vector<std::string> numerals = {
            "M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"
        };

        std::string result;
        for (size_t i = 0; i < values.size(); i++) {
            while (number >= values[i]) {
                result += numerals[i];
                number -= values[i];
            }
        }
        return result;
    }

}  // namespace roman_numerals