#include <string>
#include <cstddef> // For std::size_t
#include <algorithm> // For std::transform
#include <cctype>    // For ::toupper

namespace log_line {
std::string message(std::string line) {
    std::size_t colonPos = line.find_first_of(":");
    if (colonPos != std::string::npos && colonPos + 2 < line.length()) {
        return line.substr(colonPos + 2);
    }
    return "";
}

std::string log_level(std::string line) {
    std::size_t open_pos = line.find_first_of("[");
    std::size_t close_pos = line.find("]", open_pos + 1);

    if (open_pos != std::string::npos && close_pos != std::string::npos && open_pos < close_pos) {
        std::size_t length = close_pos - open_pos - 1;
        std::string level = line.substr(open_pos + 1, length);
        // Convert to uppercase
        std::transform(level.begin(), level.end(), level.begin(), ::toupper);
        return level;
    }
    return "";
}

std::string reformat(std::string line) {
    std::string msg = message(line);
    std::string level = log_level(line);
    return msg + " (" + level + ")";
}
    
}// namespace log_line