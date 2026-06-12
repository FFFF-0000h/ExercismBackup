#include "series.h"
#include <string.h>
#include <stdlib.h>

slices_t slices(char *input_text, unsigned int substring_length) {
    slices_t result;
    result.substring_count = 0;
    result.substring = NULL;

    unsigned int input_length = strlen(input_text);

    // Validate inputs
    if (input_length == 0 || substring_length == 0 || substring_length > input_length) {
        return result;
    }

    // Calculate number of possible substrings
    result.substring_count = input_length - substring_length + 1;

    // Allocate array of pointers
    result.substring = malloc(result.substring_count * sizeof(char *));
    if (result.substring == NULL) {
        result.substring_count = 0;
        return result;
    }

    // Create each substring
    for (unsigned int i = 0; i < result.substring_count; i++) {
        result.substring[i] = malloc(substring_length + 1);
        if (result.substring[i] == NULL) {
            // Clean up previously allocated memory
            for (unsigned int j = 0; j < i; j++) {
                free(result.substring[j]);
            }
            free(result.substring);
            result.substring = NULL;
            result.substring_count = 0;
            return result;
        }
        strncpy(result.substring[i], input_text + i, substring_length);
        result.substring[i][substring_length] = '\0';
    }

    return result;
}