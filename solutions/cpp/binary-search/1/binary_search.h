#pragma once

#include <cstddef>   // for std::size_t
#include <vector>

namespace binary_search {

// Returns the index of the target in the sorted vector `data`.
// Throws `std::domain_error` if the target is not found.
std::size_t find(const std::vector<int>& data, int target);

}  // namespace binary_search