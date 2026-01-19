// raindrops.c
#include "raindrops.h"
#include <stdio.h>
#include <string.h>

void convert(char result[], int drops) {
    // Start with empty string
    result[0] = '\0';
    
    // Check divisibility and append corresponding strings
    if (drops % 3 == 0) {
        strcat(result, "Pling");
    }
    if (drops % 5 == 0) {
        strcat(result, "Plang");
    }
    if (drops % 7 == 0) {
        strcat(result, "Plong");
    }
    
    // If no sounds were added (result is still empty), convert number to string
    if (result[0] == '\0') {
        sprintf(result, "%d", drops);
    }
}