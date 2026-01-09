#include "queen_attack.h"

attack_status_t can_attack(position_t queen_1, position_t queen_2) {
    // Check if queens are on the same position (invalid per chess rules)
    if (queen_1.row == queen_2.row && queen_1.column == queen_2.column) {
        return INVALID_POSITION;
    }
    
    // Check if positions are valid (0-7 for 8x8 board)
    if (queen_1.row > 7 || queen_1.column > 7 || 
        queen_2.row > 7 || queen_2.column > 7) {
        return INVALID_POSITION;
    }
    
    // Check if queens are on the same row
    if (queen_1.row == queen_2.row) {
        return CAN_ATTACK;
    }
    
    // Check if queens are on the same column
    if (queen_1.column == queen_2.column) {
        return CAN_ATTACK;
    }
    
    // Check if queens are on the same diagonal
    // Two positions are on the same diagonal if the absolute difference
    // between their rows equals the absolute difference between their columns
    int row_diff = queen_1.row > queen_2.row ? 
                   queen_1.row - queen_2.row : 
                   queen_2.row - queen_1.row;
    int col_diff = queen_1.column > queen_2.column ? 
                   queen_1.column - queen_2.column : 
                   queen_2.column - queen_1.column;
    
    if (row_diff == col_diff) {
        return CAN_ATTACK;
    }
    
    // If none of the above conditions are met, queens cannot attack
    return CAN_NOT_ATTACK;
}