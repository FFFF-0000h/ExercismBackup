#pragma once

#include <stdexcept>

namespace triangle {
    enum class flavor {
        equilateral,
        isosceles,
        scalene
    };
    flavor kind(double a, double b, double c);
}