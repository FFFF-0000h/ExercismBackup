#include "sum_of_multiples.h"

namespace sum_of_multiples {

int to(std::vector<int> const& factors, int level) {
    int sum = 0;
    for (int i = 1; i < level; ++i) {
        for (int factor : factors) {
            if (factor != 0 && i % factor == 0) {
                sum += i;
                break;  // count each i only once
            }
        }
    }
    return sum;
}

}  // namespace sum_of_multiples