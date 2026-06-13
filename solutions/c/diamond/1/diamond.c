#include "diamond.h"
#include <stdlib.h>
#include <string.h>

char **make_diamond(const char letter) {
    if (letter < 'A' || letter > 'Z') {
        return NULL;
    }
    
    // Calculate size: number of letters from A to the given letter
    int size = letter - 'A' + 1;
    
    // The diamond width and height is (2 * size - 1)
    int dimension = 2 * size - 1;
    
    // Allocate array of string pointers (plus one for NULL terminator)
    char **diamond = malloc((dimension + 1) * sizeof(char *));
    if (!diamond) {
        return NULL;
    }
    
    // Allocate and build each row
    for (int row = 0; row < dimension; row++) {
        // Allocate space for the row (dimension characters + null terminator)
        diamond[row] = malloc(dimension + 1);
        if (!diamond[row]) {
            // Free previously allocated rows
            for (int i = 0; i < row; i++) {
                free(diamond[i]);
            }
            free(diamond);
            return NULL;
        }
        
        // Calculate the current letter for this row
        // For top half (including middle): row goes from 0 to size-1
        // For bottom half: row goes from size to dimension-1
        int current_index;
        if (row < size) {
            current_index = row;
        } else {
            current_index = dimension - 1 - row;
        }
        char current_letter = 'A' + current_index;
        
        // Calculate leading and trailing spaces
        int leading_spaces = size - 1 - current_index;
        
        // Build the row
        int pos = 0;
        
        // Add leading spaces
        for (int i = 0; i < leading_spaces; i++) {
            diamond[row][pos++] = ' ';
        }
        
        // Add first letter
        diamond[row][pos++] = current_letter;
        
        // If not 'A', add inner spaces and second letter
        if (current_letter != 'A') {
            int inner_spaces = 2 * current_index - 1;
            for (int i = 0; i < inner_spaces; i++) {
                diamond[row][pos++] = ' ';
            }
            diamond[row][pos++] = current_letter;
        }
        
        // Add trailing spaces
        for (int i = 0; i < leading_spaces; i++) {
            diamond[row][pos++] = ' ';
        }
        
        // Null terminate the row
        diamond[row][pos] = '\0';
    }
    
    // NULL terminate the array
    diamond[dimension] = NULL;
    
    return diamond;
}

void free_diamond(char **diamond) {
    if (!diamond) {
        return;
    }
    
    for (int i = 0; diamond[i] != NULL; i++) {
        free(diamond[i]);
    }
    free(diamond);
}