#include "dnd_character.h"
#include <stdlib.h>
#include <time.h>
#include <math.h>

// Helper function to roll a single 6-sided die
static int roll_die(void) {
    return rand() % 6 + 1;
}

// Helper function to compare integers for qsort (descending order)
static int compare_desc(const void *a, const void *b) {
    return *(int*)b - *(int*)a;
}

int ability(void) {
    int rolls[4];
    
    // Roll 4 dice
    for (int i = 0; i < 4; i++) {
        rolls[i] = roll_die();
    }
    
    // Sort in descending order
    qsort(rolls, 4, sizeof(int), compare_desc);
    
    // Sum the highest three rolls
    return rolls[0] + rolls[1] + rolls[2];
}

int modifier(int score) {
    // Calculate modifier: floor((score - 10) / 2)
    return (int)floor((score - 10) / 2.0);
}

dnd_character_t make_dnd_character(void) {
    dnd_character_t character;
    
    // Initialize random seed if not already done
    static int initialized = 0;
    if (!initialized) {
        srand(time(NULL));
        initialized = 1;
    }
    
    // Generate ability scores
    character.strength = ability();
    character.dexterity = ability();
    character.constitution = ability();
    character.intelligence = ability();
    character.wisdom = ability();
    character.charisma = ability();
    
    // Calculate hitpoints
    character.hitpoints = 10 + modifier(character.constitution);
    
    return character;
}