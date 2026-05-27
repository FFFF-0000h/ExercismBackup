#include "beer_song.h"
#include <string>

namespace beer_song {

namespace {
    // Returns "n bottles", "1 bottle", or "no more bottles"
    std::string bottle_phrase(int n) {
        if (n == 0) {
            return "no more bottles";
        } else if (n == 1) {
            return "1 bottle";
        } else {
            return std::to_string(n) + " bottles";
        }
    }

    // Capitalise the first character (only if it's a letter)
    std::string capitalise(const std::string& s) {
        if (s.empty()) return s;
        std::string result = s;
        result[0] = static_cast<char>(std::toupper(result[0]));
        return result;
    }
}

std::string verse(int n) {
    switch (n) {
        case 0:
            return "No more bottles of beer on the wall, no more bottles of beer.\n"
                   "Go to the store and buy some more, 99 bottles of beer on the wall.\n";
        case 1:
            return "1 bottle of beer on the wall, 1 bottle of beer.\n"
                   "Take it down and pass it around, no more bottles of beer on the wall.\n";
        case 2:
            return "2 bottles of beer on the wall, 2 bottles of beer.\n"
                   "Take one down and pass it around, 1 bottle of beer on the wall.\n";
        default: {
            std::string line1 = capitalise(bottle_phrase(n)) + " of beer on the wall, "
                              + bottle_phrase(n) + " of beer.\n";
            std::string line2 = "Take one down and pass it around, "
                              + bottle_phrase(n - 1) + " of beer on the wall.\n";
            return line1 + line2;
        }
    }
}

std::string sing(int start, int end) {
    std::string song;
    for (int i = start; i >= end; --i) {
        if (!song.empty()) {
            song += "\n";   // blank line between verses
        }
        song += verse(i);
    }
    return song;
}

}  // namespace beer_song