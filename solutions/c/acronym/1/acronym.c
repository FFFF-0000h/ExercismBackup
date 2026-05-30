// acronym.c
#include "acronym.h"
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

char *abbreviate(const char *phrase) {
    // Null or empty phrase returns NULL
    if (phrase == NULL || *phrase == '\0') {
        return NULL;
    }

    size_t len = strlen(phrase);
    // Allocate maximum possible size (each character could be start of word)
    char *acronym = malloc(len + 1);
    if (!acronym) return NULL;

    size_t idx = 0;
    int start_of_word = 1;

    for (size_t i = 0; i < len; i++) {
        char c = phrase[i];
        // Any whitespace, hyphen, or underscore acts as word separator
        if (c == ' ' || c == '-' || c == '_') {
            start_of_word = 1;
        } else if (isalpha((unsigned char)c)) {
            if (start_of_word) {
                acronym[idx++] = toupper((unsigned char)c);
                start_of_word = 0;
            }
        }
        // All other characters (punctuation, digits, etc.) are ignored
    }

    acronym[idx] = '\0';
    return acronym;
}