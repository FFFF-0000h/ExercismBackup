#pragma once

#include <string>
#include <stdexcept>

namespace hamming {
    int compute(const std::string& strand1, const std::string& strand2);
}