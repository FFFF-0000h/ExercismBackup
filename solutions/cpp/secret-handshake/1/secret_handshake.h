#pragma once

#include <string>
#include <vector>

namespace secret_handshake {

// Convert a number (1-31) to a sequence of handshake actions.
std::vector<std::string> commands(int number);

}  // namespace secret_handshake