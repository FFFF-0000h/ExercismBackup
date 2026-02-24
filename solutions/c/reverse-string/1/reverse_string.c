#include "reverse_string.h"
#include <stdlib.h>
#include <string.h>

char *reverse(const char *value) {
    if (value == NULL) return NULL;
    
    size_t len = strlen(value);
    char *result = malloc(len + 1);
    if (result == NULL) return NULL;
    
    for (size_t i = 0; i < len; ++i) {
        result[i] = value[len - 1 - i];
    }
    result[len] = '\0';
    
    return result;
}