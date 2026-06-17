// food_chain.cpp
#include "food_chain.h"
#include <vector>

namespace food_chain {

namespace {
    const std::vector<std::string> animals = {
        "fly",
        "spider",
        "bird",
        "cat",
        "dog",
        "goat",
        "cow",
        "horse"
    };

    const std::vector<std::string> comments = {
        "",
        "It wriggled and jiggled and tickled inside her.\n",
        "How absurd to swallow a bird!\n",
        "Imagine that, to swallow a cat!\n",
        "What a hog, to swallow a dog!\n",
        "Just opened her throat and swallowed a goat!\n",
        "I don't know how she swallowed a cow!\n",
        ""
    };
}

std::string verse(int n) {
    n--; // convert to 0-indexed
    std::string result = "I know an old lady who swallowed a " + animals[n] + ".\n";

    // For the horse, special ending
    if (n == 7) {
        return result + "She's dead, of course!\n";
    }

    // Add the comment line for this animal (if any)
    result += comments[n];

    // Build the chain of what happened after
    for (int i = n; i > 0; i--) {
        result += "She swallowed the " + animals[i] + " to catch the " + animals[i - 1];
        if (i - 1 == 1) {
            result += " that wriggled and jiggled and tickled inside her";
        }
        result += ".\n";
    }

    result += "I don't know why she swallowed the fly. Perhaps she'll die.\n";
    return result;
}

std::string verses(int start, int end) {
    std::string result;
    for (int i = start; i <= end; i++) {
        result += verse(i);
        result += "\n";
    }
    return result;
}

std::string sing() {
    return verses(1, 8);
}

}  // namespace food_chain