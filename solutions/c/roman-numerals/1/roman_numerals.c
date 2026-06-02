// roman_numerals.c
#include "roman_numerals.h"
#include <stdlib.h>
#include <string.h>

char *to_roman_numeral(unsigned int number) {
    char *result = malloc(16);
    if (!result) return NULL;
    
    int pos = 0;
    
    const unsigned int values[] = {1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1};
    const char *numerals[] = {"M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"};
    
    for (int i = 0; i < 13; i++) {
        while (number >= values[i]) {
            int len = strlen(numerals[i]);
            strcpy(result + pos, numerals[i]);
            pos += len;
            number -= values[i];
        }
    }
    
    result[pos] = '\0';
    return result;
}