#pragma once

#include <string>

namespace date_independent {

class clock {
public:
    // Factory method to create a clock at a specific time
    static clock at(int hours, int minutes);

    // Arithmetic
    clock plus(int minutes) const;
    clock minus(int minutes) const;

    // Comparison
    bool operator==(const clock& other) const;
    bool operator!=(const clock& other) const;

    // String conversion
    std::string to_string() const;
    operator std::string() const;   // implicit conversion for testing

private:
    // Private constructor – use clock::at to create instances
    clock(int hours, int minutes);
    int minutes_since_midnight_;    // 0 .. 1439
};

}  // namespace date_independent