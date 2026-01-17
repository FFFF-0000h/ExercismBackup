#include "two_fer.h"
#include <stdio.h>
#include <string.h>

void two_fer(char *buffer, const char *name) {
    if (name == NULL || strlen(name) == 0) {
        // No name provided
        sprintf(buffer, "One for you, one for me.");
    } else {
        // Name provided
        sprintf(buffer, "One for %s, one for me.", name);
    }
}