// kindergarten_garden.c
#include "kindergarten_garden.h"
#include <string.h>

static const char *students[] = {
    "Alice", "Bob", "Charlie", "David", "Eve",
    "Fred", "Ginny", "Harriet", "Ileana", "Joseph",
    "Kincaid", "Larry"
};

static plant_t char_to_plant(char c) {
    switch (c) {
        case 'G': return GRASS;
        case 'C': return CLOVER;
        case 'R': return RADISHES;
        case 'V': return VIOLETS;
        default:  return GRASS; // should not happen
    }
}

plants_t plants(const char *diagram, const char *student) {
    plants_t result;

    // Find student index
    int idx = -1;
    for (int i = 0; i < 12; i++) {
        if (strcmp(student, students[i]) == 0) {
            idx = i;
            break;
        }
    }

    // Locate the newline separating the two rows
    const char *newline = strchr(diagram, '\n');
    const char *row1 = diagram;
    const char *row2 = newline ? newline + 1 : "";

    // Each student gets 2 plants per row, consecutive
    int start = idx * 2;
    result.plants[0] = char_to_plant(row1[start]);
    result.plants[1] = char_to_plant(row1[start + 1]);
    result.plants[2] = char_to_plant(row2[start]);
    result.plants[3] = char_to_plant(row2[start + 1]);

    return result;
}