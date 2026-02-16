#include "rotational_cipher.h"
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

char *rotate(const char *text, int shift_key) {
    // Normalize shift key to range 0-25
    int shift = shift_key % 26;
    if (shift < 0) shift += 26;

    size_t len = strlen(text);
    char *result = malloc(len + 1);
    if (!result) return NULL;

    for (size_t i = 0; i < len; i++) {
        char c = text[i];
        if (isupper(c)) {
            result[i] = 'A' + (c - 'A' + shift) % 26;
        } else if (islower(c)) {
            result[i] = 'a' + (c - 'a' + shift) % 26;
        } else {
            result[i] = c;
        }
    }
    result[len] = '\0';
    return result;
}