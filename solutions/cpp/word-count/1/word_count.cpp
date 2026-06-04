#include "word_count.h"
#include <cctype>
#include <sstream>

namespace word_count {

    std::map<std::string, int> words(const std::string& text) {
        std::map<std::string, int> result;

        std::string cleaned;
        for (char c : text) {
            if (std::isalnum(static_cast<unsigned char>(c)) || c == '\'') {
                cleaned += std::tolower(static_cast<unsigned char>(c));
            } else {
                cleaned += ' ';
            }
        }

        std::istringstream stream(cleaned);
        std::string word;

        while (stream >> word) {
            // Remove leading and trailing apostrophes (quotes)
            size_t start = word.find_first_not_of('\'');
            size_t end = word.find_last_not_of('\'');

            if (start != std::string::npos) {
                word = word.substr(start, end - start + 1);
                result[word]++;
            }
        }

        return result;
    }

}  // namespace word_count