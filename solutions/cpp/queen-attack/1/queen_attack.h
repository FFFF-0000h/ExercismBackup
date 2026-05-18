// queen_attack.h
#pragma once

#include <utility>
#include <stdexcept>

namespace queen_attack {

using position = std::pair<int, int>; // (row, col)

class chess_board {
public:
    chess_board(position white, position black);

    position white() const { return white_; }
    position black() const { return black_; }

    bool can_attack() const;

private:
    position white_;
    position black_;

    static bool valid_position(position pos);
};

} // namespace queen_attack