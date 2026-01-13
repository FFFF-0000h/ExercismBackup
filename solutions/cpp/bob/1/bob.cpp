#include "bob.h"
#include <string>
#include <cctype>
#include <algorithm>

namespace bob {

std::string hey(const std::string& input) {
    // Check for silence (only whitespace)
    bool is_silence = true;
    for (char c : input) {
        if (!std::isspace(static_cast<unsigned char>(c))) {
            is_silence = false;
            break;
        }
    }
    if (is_silence) {
        return "Fine. Be that way!";
    }
    
    // Check if all letters are uppercase (yelling)
    bool has_letters = false;
    bool is_yelling = true;
    
    for (char c : input) {
        if (std::isalpha(static_cast<unsigned char>(c))) {
            has_letters = true;
            if (!std::isupper(static_cast<unsigned char>(c))) {
                is_yelling = false;
                break;
            }
        }
    }
    
    // Yelling requires at least one letter
    is_yelling = is_yelling && has_letters;
    
    // Check if it's a question (ends with '?')
    bool is_question = false;
    // Find the last non-whitespace character
    for (auto it = input.rbegin(); it != input.rend(); ++it) {
        if (!std::isspace(static_cast<unsigned char>(*it))) {
            is_question = (*it == '?');
            break;
        }
    }
    
    // Determine response
    if (is_yelling && is_question) {
        return "Calm down, I know what I'm doing!";
    } else if (is_yelling) {
        return "Whoa, chill out!";
    } else if (is_question) {
        return "Sure.";
    } else {
        return "Whatever.";
    }
}

}  // namespace bob