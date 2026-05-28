#include "binary_search.h"
#include <stdexcept>  // for std::domain_error

namespace binary_search {

std::size_t find(const std::vector<int>& data, int target) {
    if (data.empty()) {
        throw std::domain_error("value not found in array");
    }

    std::size_t left = 0;
    std::size_t right = data.size() - 1;

    while (left <= right) {
        std::size_t middle = left + (right - left) / 2;

        if (data[middle] == target) {
            return middle;
        } else if (data[middle] < target) {
            left = middle + 1;
        } else {
            // data[middle] > target
            if (middle == 0) break;  // avoid underflow when middle is 0
            right = middle - 1;
        }
    }

    throw std::domain_error("value not found in array");
}

}  // namespace binary_search