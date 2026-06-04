#pragma once
#include <string>
#include <map>

namespace word_count {
    std::map<std::string, int> words(const std::string& text);
}