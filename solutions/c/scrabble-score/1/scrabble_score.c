#include "scrabble_score.h"
#include <ctype.h>

unsigned int score(const char *word) {
    // Scrabble letter values
    static const int letter_values[26] = {
        ['A' - 'A'] = 1, ['E' - 'A'] = 1, ['I' - 'A'] = 1, ['O' - 'A'] = 1,
        ['U' - 'A'] = 1, ['L' - 'A'] = 1, ['N' - 'A'] = 1, ['R' - 'A'] = 1,
        ['S' - 'A'] = 1, ['T' - 'A'] = 1, ['D' - 'A'] = 2, ['G' - 'A'] = 2,
        ['B' - 'A'] = 3, ['C' - 'A'] = 3, ['M' - 'A'] = 3, ['P' - 'A'] = 3,
        ['F' - 'A'] = 4, ['H' - 'A'] = 4, ['V' - 'A'] = 4, ['W' - 'A'] = 4,
        ['Y' - 'A'] = 4, ['K' - 'A'] = 5, ['J' - 'A'] = 8, ['X' - 'A'] = 8,
        ['Q' - 'A'] = 10,['Z' - 'A'] = 10
    };

    unsigned int total = 0;
    for (const char *p = word; *p; ++p) {
        char c = toupper(*p);
        if (c >= 'A' && c <= 'Z') {
            total += letter_values[c - 'A'];
        }
    }
    return total;
}