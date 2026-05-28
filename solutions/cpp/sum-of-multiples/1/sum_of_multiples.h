#pragma once
#include <vector>

namespace sum_of_multiples {

// Returns the sum of all unique multiples of the given factors
// that are less than the provided level.
int to(std::vector<int> const& factors, int level);

}  // namespace sum_of_multiples