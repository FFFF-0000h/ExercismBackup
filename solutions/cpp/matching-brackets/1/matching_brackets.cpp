#include "matching_brackets.h"
#include <stack>
#include <string_view>

namespace matching_brackets {

bool check(std::string_view input) {
    std::stack<char> brackets;
    
    for (char c : input) {
        // Handle opening brackets
        if (c == '(' || c == '[' || c == '{') {
            brackets.push(c);
        }
        // Handle closing brackets
        else if (c == ')' || c == ']' || c == '}') {
            // If stack is empty, there's no matching opening bracket
            if (brackets.empty()) {
                return false;
            }
            
            char top = brackets.top();
            brackets.pop();
            
            // Check if the closing bracket matches the opening bracket
            if ((c == ')' && top != '(') ||
                (c == ']' && top != '[') ||
                (c == '}' && top != '{')) {
                return false;
            }
        }
        // Ignore all other characters
    }
    
    // If stack is not empty, there are unmatched opening brackets
    return brackets.empty();
}

}  // namespace matching_brackets