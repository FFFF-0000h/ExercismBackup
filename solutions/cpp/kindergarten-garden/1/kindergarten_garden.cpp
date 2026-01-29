#include "kindergarten_garden.h"
#include <vector>
#include <unordered_map>
#include <sstream>
#include <algorithm>

namespace kindergarten_garden {
    std::vector<std::string> const STUDENTS {"Alice", "Bob", "Charlie", "David", "Eve", "Fred", "Ginny", "Harriet", "Ileana", "Joseph", "Kincaid", "Larry"};

    std::unordered_map<char, Plants> plants_name {
        {'C', Plants::clover},
        {'G', Plants::grass},
        {'V', Plants::violets},
        {'R', Plants::radishes},
    };

    std::array<Plants, 4> plants(std::string garden, std::string student) {
        std::istringstream ss {garden};
        std::string line {};

        auto student_position {get_student_position(student)};
        std::string student_plants {};
        while(std::getline(ss, line)) {
            student_plants += line.substr(student_position, 2);
        }

        std::array<Plants, 4> plants {};
        for (int i {0}; i < 4; i++) {
            plants[i] = plants_name[student_plants[i]];
        }

        return plants;
    }

    size_t get_student_position(std::string student) {
        auto index {std::find(STUDENTS.begin(), STUDENTS.end(), student) - STUDENTS.begin()};
        return 2*index;
    }
}  // namespace kindergarten_garden
