#include "etl.h"
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

static int compare_keys(const void *a, const void *b) {
    const new_map *entry_a = (const new_map *)a;
    const new_map *entry_b = (const new_map *)b;
    return (int)(entry_a->key) - (int)(entry_b->key);
}

int convert(const legacy_map *input, const size_t input_len, new_map **output) {
    // Count total number of letters
    size_t total = 0;
    for (size_t i = 0; i < input_len; i++) {
        total += strlen(input[i].keys);
    }

    // Allocate output array
    *output = malloc(total * sizeof(new_map));
    if (*output == NULL) {
        return -1;
    }

    // Fill the output array
    size_t index = 0;
    for (size_t i = 0; i < input_len; i++) {
        int value = input[i].value;
        const char *keys = input[i].keys;
        for (size_t j = 0; j < strlen(keys); j++) {
            (*output)[index].key = tolower((unsigned char)keys[j]);
            (*output)[index].value = value;
            index++;
        }
    }

    // Sort by key
    qsort(*output, total, sizeof(new_map), compare_keys);

    return total;
}