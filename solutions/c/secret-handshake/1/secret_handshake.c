#include "secret_handshake.h"
#include <stdlib.h>
#include <string.h>

static const char *action_strings[] = {
    "wink",
    "double blink",
    "close your eyes",
    "jump"
};

const char **commands(size_t number) {
    // Allocate array of 5 pointers (max 4 actions + NULL terminator)
    const char **result = calloc(5, sizeof(char *));
    if (!result) return NULL;

    int indices[4];
    int count = 0;

    // Check bits 0-3 (actions)
    for (int i = 0; i < 4; i++) {
        if (number & (1 << i)) {
            indices[count++] = i;
        }
    }

    // Check bit 4 (reverse flag)
    if (number & (1 << 4)) {
        // Reverse the order
        for (int i = 0; i < count; i++) {
            result[i] = action_strings[indices[count - 1 - i]];
        }
    } else {
        // Keep original order
        for (int i = 0; i < count; i++) {
            result[i] = action_strings[indices[i]];
        }
    }

    result[count] = NULL;
    return result;
}