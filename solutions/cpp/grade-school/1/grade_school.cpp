#include <algorithm>
#include "grade_school.h"

namespace grade_school {

    void school::add(const std::string& name, unsigned grade) {
        auto pos = _roster.find(grade);
        if (pos != _roster.end()) {
            auto& v = pos->second;
            auto new_pos = std::lower_bound(v.begin(), v.end(), name);
            v.insert(new_pos, name);
        } else {
            _roster[grade] = {name};
        }
    }

    std::map<int, std::vector<std::string>> school::roster() const {
        return _roster;
    }

    std::vector<std::string> school::grade(unsigned grade) const {
        auto pos = _roster.find(grade);
        if (pos != _roster.end()) {
            return pos->second;
        } else {
            return {};
        }
    }

}  // namespace grade_school