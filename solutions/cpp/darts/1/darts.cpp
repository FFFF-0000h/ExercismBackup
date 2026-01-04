#include "darts.h"
#include <cmath>

namespace darts {

int score(double x, double y) {
    // Calculate distance from center (0,0) using Pythagorean theorem
    double distance = std::sqrt(x * x + y * y);
    
    // Determine score based on distance from center
    if (distance <= 1.0) {
        return 10;      // Inner circle (radius 1)
    } else if (distance <= 5.0) {
        return 5;       // Middle circle (radius 5)
    } else if (distance <= 10.0) {
        return 1;       // Outer circle (radius 10)
    } else {
        return 0;       // Outside target
    }
}

}  // namespace darts