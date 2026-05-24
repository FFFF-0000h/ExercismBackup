#include "clock.h"

#include <iomanip>
#include <sstream>

namespace date_independent {

clock clock::at(int hours, int minutes) {
    return clock(hours, minutes);
}

clock::clock(int hours, int minutes) {
    int total = hours * 60 + minutes;
    // Normalize to [0, 1440)
    total %= 1440;
    if (total < 0) {
        total += 1440;
    }
    minutes_since_midnight_ = total;
}

clock clock::plus(int minutes) const {
    return clock(0, minutes_since_midnight_ + minutes);
}

clock clock::minus(int minutes) const {
    return clock(0, minutes_since_midnight_ - minutes);
}

bool clock::operator==(const clock& other) const {
    return minutes_since_midnight_ == other.minutes_since_midnight_;
}

bool clock::operator!=(const clock& other) const {
    return !(*this == other);
}

std::string clock::to_string() const {
    int hours = minutes_since_midnight_ / 60;
    int mins = minutes_since_midnight_ % 60;
    std::ostringstream oss;
    oss << std::setw(2) << std::setfill('0') << hours << ':'
        << std::setw(2) << std::setfill('0') << mins;
    return oss.str();
}

clock::operator std::string() const {
    return to_string();
}

}  // namespace date_independent