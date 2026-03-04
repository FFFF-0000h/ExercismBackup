#include "nucleotide_count.h"
#include <stdexcept>

namespace nucleotide_count {
    std::map<char, int> count(const std::string& dna) {
        std::map<char, int> counts = {{'A', 0}, {'C', 0}, {'G', 0}, {'T', 0}};
        for (char c : dna) {
            auto it = counts.find(c);
            if (it == counts.end()) {
                throw std::invalid_argument("Invalid nucleotide");
            }
            it->second++;
        }
        return counts;
    }
}