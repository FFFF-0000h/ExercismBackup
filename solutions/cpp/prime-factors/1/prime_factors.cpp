#include "prime_factors.h"
#include <vector>
namespace prime_factors {

	std::vector<long long> of(long long num)
	{
		std::vector<long long> result = {};
		int divider = 2;
		while (num > 1) {
			if (num % divider == 0) {
				result.push_back(divider);
				num = num / divider;
			}
			else {
				divider++;
			}
		}

		return result;
	}

}  // namespace prime_factors