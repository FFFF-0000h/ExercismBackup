#include "anagram.h"
#include <algorithm>
#include <cctype>

namespace anagram {

anagram::anagram(std::string word) : word_(std::move(word)) {
    normalized_word_ = normalize(word_);
}

std::vector<std::string> anagram::matches(const std::vector<std::string>& candidates) const {
    std::vector<std::string> result;
    
    for (const auto& candidate : candidates) {
        if (is_anagram(candidate)) {
            result.push_back(candidate);
        }
    }
    
    return result;
}

std::string anagram::normalize(const std::string& str) const {
    std::string normalized = str;
    
    // Convert to lowercase for case-insensitive comparison
    std::transform(normalized.begin(), normalized.end(), normalized.begin(),
                   [](unsigned char c) { return std::tolower(c); });
    
    // Sort the characters for comparison
    std::sort(normalized.begin(), normalized.end());
    
    return normalized;
}

bool anagram::is_anagram(const std::string& candidate) const {
    // Convert both to lowercase for case-insensitive comparison
    std::string lower_word = word_;
    std::string lower_candidate = candidate;
    
    std::transform(lower_word.begin(), lower_word.end(), lower_word.begin(),
                   [](unsigned char c) { return std::tolower(c); });
    std::transform(lower_candidate.begin(), lower_candidate.end(), lower_candidate.begin(),
                   [](unsigned char c) { return std::tolower(c); });
    
    // A word is not its own anagram (case-insensitive)
    if (lower_word == lower_candidate) {
        return false;
    }
    
    // Compare sorted versions of the words
    std::string sorted_word = lower_word;
    std::string sorted_candidate = lower_candidate;
    
    std::sort(sorted_word.begin(), sorted_word.end());
    std::sort(sorted_candidate.begin(), sorted_candidate.end());
    
    return sorted_word == sorted_candidate;
}

}  // namespace anagram