// queen_attack.cpp
#include "queen_attack.h"
#include <cstdlib>

namespace queen_attack {

bool chess_board::valid_position(position pos) {
    int row = pos.first;
    int col = pos.second;
    return row >= 0 && row < 8 && col >= 0 && col < 8;
}

chess_board::chess_board(position white, position black)
    : white_(white), black_(black)
{
    if (!valid_position(white_) || !valid_position(black_)) {
        throw std::domain_error("Queen position must be within 0..7 for both row and column");
    }
    if (white_ == black_) {
        throw std::domain_error("Queens cannot occupy the same position");
    }
}

bool chess_board::can_attack() const {
    int row_diff = std::abs(white_.first - black_.first);
    int col_diff = std::abs(white_.second - black_.second);

    return white_.first == black_.first ||      // same row
           white_.second == black_.second ||    // same column
           row_diff == col_diff;                // same diagonal
}

} // namespace queen_attack