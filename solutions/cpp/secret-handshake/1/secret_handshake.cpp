#include "secret_handshake.h"
#include <algorithm>  // for std::reverse

namespace secret_handshake {

std::vector<std::string> commands(int number) {
    std::vector<std::string> actions;

    // Rightmost five bits: 0..4
    if (number & 1)   actions.push_back("wink");
    if (number & 2)   actions.push_back("double blink");
    if (number & 4)   actions.push_back("close your eyes");
    if (number & 8)   actions.push_back("jump");
    // Bit 4: reverse the order of the accumulated actions
    if (number & 16)  std::reverse(actions.begin(), actions.end());

    return actions;
}

}  // namespace secret_handshake