#include "series.h"
#include <stdexcept>

namespace series {

    std::vector<std::string> slice(const std::string& digits, int length) {
        if (length <= 0) {
            throw std::domain_error("Invalid length");
        }
        if (static_cast<std::size_t>(length) > digits.size()) {
            throw std::domain_error("Slice length exceeds string length");
        }
        std::vector<std::string> result;
        result.reserve(digits.size() - length + 1);
        for (std::size_t i = 0; i + length <= digits.size(); ++i) {
            result.push_back(digits.substr(i, length));
        }
        return result;
    }

}  // namespace series