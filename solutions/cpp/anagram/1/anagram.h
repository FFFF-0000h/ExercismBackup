#pragma once

#include <string>
#include <vector>

namespace anagram {

class anagram {
public:
    explicit anagram(std::string word);
    
    std::vector<std::string> matches(const std::vector<std::string>& candidates) const;

private:
    std::string word_;
    std::string normalized_word_;
    
    std::string normalize(const std::string& str) const;
    bool is_anagram(const std::string& candidate) const;
};

}  // namespace anagram