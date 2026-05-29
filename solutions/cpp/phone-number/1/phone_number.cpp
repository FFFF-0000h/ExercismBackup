#include "phone_number.h"
#include <cctype>
#include <stdexcept>
#include <algorithm>

namespace phone_number {

phone_number::phone_number(const std::string& input) {
    validate_and_clean(input);
}

static bool is_allowed(char c) {
    return std::isdigit(static_cast<unsigned char>(c)) ||
           c == ' ' || c == '.' || c == '-' || c == '(' || c == ')' || c == '+';
}

void phone_number::validate_and_clean(const std::string& input) {
    // Check for any disallowed characters
    if (!std::all_of(input.begin(), input.end(), is_allowed)) {
        throw std::domain_error("invalid character in phone number");
    }

    // Extract digits only
    std::string digits;
    std::copy_if(input.begin(), input.end(), std::back_inserter(digits),
                 [](char c) { return std::isdigit(static_cast<unsigned char>(c)); });

    // Must have 10 or 11 digits
    if (digits.size() != 10 && digits.size() != 11) {
        throw std::domain_error("incorrect number of digits");
    }

    // If 11 digits, first must be '1'
    if (digits.size() == 11) {
        if (digits[0] != '1') {
            throw std::domain_error("11 digits must start with 1");
        }
        digits.erase(0, 1);  // remove country code
    }

    // At this point we have exactly 10 digits
    // Validate area code (first digit) and exchange code (fourth digit) are 2-9
    if (digits[0] < '2' || digits[0] > '9') {
        throw std::domain_error("area code cannot start with zero or one");
    }
    if (digits[3] < '2' || digits[3] > '9') {
        throw std::domain_error("exchange code cannot start with zero or one");
    }

    cleaned = digits;
}

std::string phone_number::number() const {
    return cleaned;
}

}  // namespace phone_number