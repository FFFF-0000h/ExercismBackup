#pragma once

#include <string>
#include <unordered_set>

namespace robot_name {

class robot {
public:
    robot();
    ~robot();

    std::string name() const;
    void reset();

private:
    std::string name_;
    static std::unordered_set<std::string> used_names;
    static bool seeded;
    void generate_name();
};

}  // namespace robot_name