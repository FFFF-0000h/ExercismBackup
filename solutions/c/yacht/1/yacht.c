#include "yacht.h"

int score(dice_t dice, category_t category) {
    int counts[7] = {0}; // index 1-6
    for (int i = 0; i < 5; i++) {
        int face = dice.faces[i];
        if (face >= 1 && face <= 6) {
            counts[face]++;
        }
    }

    switch (category) {
        case ONES:
        case TWOS:
        case THREES:
        case FOURS:
        case FIVES:
        case SIXES: {
            int value = category + 1; // ONES=0 -> 1, etc.
            return counts[value] * value;
        }

        case FULL_HOUSE: {
            int three = 0, two = 0;
            for (int i = 1; i <= 6; i++) {
                if (counts[i] == 3) three = i;
                else if (counts[i] == 2) two = i;
            }
            if (three && two) {
                // sum all dice
                int total = 0;
                for (int i = 0; i < 5; i++) total += dice.faces[i];
                return total;
            }
            return 0;
        }

        case FOUR_OF_A_KIND: {
            for (int i = 1; i <= 6; i++) {
                if (counts[i] >= 4) {
                    return i * 4;
                }
            }
            return 0;
        }

        case LITTLE_STRAIGHT: {
            // must have exactly 1,2,3,4,5
            if (counts[1] == 1 && counts[2] == 1 && counts[3] == 1 &&
                counts[4] == 1 && counts[5] == 1 && counts[6] == 0) {
                return 30;
            }
            return 0;
        }

        case BIG_STRAIGHT: {
            // must have exactly 2,3,4,5,6
            if (counts[2] == 1 && counts[3] == 1 && counts[4] == 1 &&
                counts[5] == 1 && counts[6] == 1 && counts[1] == 0) {
                return 30;
            }
            return 0;
        }

        case CHOICE: {
            int total = 0;
            for (int i = 0; i < 5; i++) total += dice.faces[i];
            return total;
        }

        case YACHT: {
            for (int i = 1; i <= 6; i++) {
                if (counts[i] == 5) return 50;
            }
            return 0;
        }

        default:
            return 0;
    }
}