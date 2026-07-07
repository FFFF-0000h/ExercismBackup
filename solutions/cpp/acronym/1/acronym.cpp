#include "acronym.h"
#include <cctype>

namespace acronym {

std::string acronym(std::string const& phrase) {
    std::string result;
    bool in_word = false;

    for (char ch : phrase) {
        if (std::isalpha(static_cast<unsigned char>(ch))) {
            if (!in_word) {
                result += std::toupper(static_cast<unsigned char>(ch));
                in_word = true;
            }
        } else if (ch == ' ' || ch == '-') {
            in_word = false;
        }
        // All other characters (punctuation, apostrophes) are ignored
        // and do not break the current word.
    }

    return result;
}

}  // namespace acronym