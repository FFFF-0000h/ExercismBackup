#include "luhn.h"
#include <ctype.h>
#include <string.h>
#include <stdlib.h>

bool luhn(const char *num)
{
    if (num == NULL) {
        return false;
    }

    // First pass: validate characters and calculate length without spaces
    int len_without_spaces = 0;
    for (int i = 0; num[i] != '\0'; i++) {
        if (isdigit((unsigned char)num[i])) {
            len_without_spaces++;
        } else if (num[i] == ' ') {
            continue;
        } else {
            return false;  // Invalid character
        }
    }

    // Strings of length 1 or less are not valid
    if (len_without_spaces <= 1) {
        return false;
    }

    // Extract digits only (no spaces)
    char *digits = malloc(len_without_spaces + 1);
    if (digits == NULL) {
        return false;
    }

    int pos = 0;
    for (int i = 0; num[i] != '\0'; i++) {
        if (isdigit((unsigned char)num[i])) {
            digits[pos++] = num[i];
        }
    }
    digits[pos] = '\0';

    // Apply Luhn algorithm
    int sum = 0;
    bool double_digit = false;
    
    // Process from right to left
    for (int i = len_without_spaces - 1; i >= 0; i--) {
        int digit = digits[i] - '0';
        
        if (double_digit) {
            digit *= 2;
            if (digit > 9) {
                digit -= 9;
            }
        }
        
        sum += digit;
        double_digit = !double_digit;  // Toggle for next digit
    }

    free(digits);
    
    return (sum % 10 == 0);
}