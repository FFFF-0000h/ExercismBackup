#include "triangle.h"

namespace triangle {
    flavor kind(double a, double b, double c) {
        // All sides must be positive
        if (a <= 0 || b <= 0 || c <= 0) {
            throw std::domain_error("Sides must be positive");
        }
        // Triangle inequality: sum of any two sides must be >= the third
        if (a + b < c || a + c < b || b + c < a) {
            throw std::domain_error("Invalid triangle: violates triangle inequality");
        }
        // Determine type
        if (a == b && b == c) {
            return flavor::equilateral;
        }
        if (a == b || a == c || b == c) {
            return flavor::isosceles;
        }
        return flavor::scalene;
    }
}