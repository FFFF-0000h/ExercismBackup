#include "etl.h"
#include <cctype>

namespace etl {

    std::map<char, int> transform(std::map<int, std::vector<char>> old) {
        std::map<char, int> result;
        for (const auto& [score, letters] : old) {
            for (char letter : letters) {
                result[std::tolower(letter)] = score;
            }
        }
        return result;
    }

}  // namespace etl