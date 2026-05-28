#include "robot_name.h"
#include <random>
#include <algorithm>
#include <cctype>

namespace robot_name {

std::unordered_set<std::string> robot::used_names;
bool robot::seeded = false;

// Generate a single random name in format: two uppercase letters + three digits
static std::string random_name() {
    static std::mt19937 gen([]() {
        std::random_device rd;
        return std::mt19937(rd());
    }());

    std::uniform_int_distribution<> letters('A', 'Z');
    std::uniform_int_distribution<> digits(0, 9);

    std::string name(5, ' ');
    name[0] = static_cast<char>(letters(gen));
    name[1] = static_cast<char>(letters(gen));
    name[2] = static_cast<char>('0' + digits(gen));
    name[3] = static_cast<char>('0' + digits(gen));
    name[4] = static_cast<char>('0' + digits(gen));
    return name;
}

void robot::generate_name() {
    std::string candidate;
    do {
        candidate = random_name();
    } while (used_names.find(candidate) != used_names.end());

    used_names.insert(candidate);
    name_ = candidate;
}

robot::robot() {
    if (!seeded) {
        // Already seeded in random_name's static gen initialisation, but keep flag.
        seeded = true;
    }
    generate_name();
}

robot::~robot() {
    // Release the name so it can be reused by future robots
    used_names.erase(name_);
}

std::string robot::name() const {
    return name_;
}

void robot::reset() {
    used_names.erase(name_);   // free old name
    generate_name();           // generate and assign a new unique name
}

}  // namespace robot_name