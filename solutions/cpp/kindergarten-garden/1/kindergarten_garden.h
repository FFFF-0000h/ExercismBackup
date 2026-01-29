#pragma once
#include <array>
#include <string>

namespace kindergarten_garden {
    enum class Plants {
        clover,
        grass,
        violets,
        radishes
    };
    std::array<Plants, 4> plants(std::string garden, std::string student);
    size_t get_student_position(std::string student);
}  // namespace kindergarten_garden
