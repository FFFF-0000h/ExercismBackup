#include "phone_number.h"
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

static const char *INVALID_RESULT = "0000000000";

static int is_allowed_char(char c) {
    return (c >= '0' && c <= '9') ||
           c == ' ' || c == '.' || c == '-' || c == '(' || c == ')' || c == '+';
}

char *phone_number_clean(const char *input) {
    if (input == NULL) {
        char *res = malloc(11);
        if (res) memcpy(res, INVALID_RESULT, 11);
        return res;
    }

    // Check for any invalid characters
    for (const char *p = input; *p; p++) {
        if (!is_allowed_char(*p)) {
            char *res = malloc(11);
            if (res) memcpy(res, INVALID_RESULT, 11);
            return res;
        }
    }

    // Extract digits
    int len = strlen(input);
    char digits[len + 1];
    int count = 0;
    for (int i = 0; i < len; i++) {
        if (isdigit((unsigned char)input[i])) {
            digits[count++] = input[i];
        }
    }
    digits[count] = '\0';

    // Number of digits must be 10 or 11
    if (count != 10 && count != 11) {
        char *res = malloc(11);
        if (res) memcpy(res, INVALID_RESULT, 11);
        return res;
    }

    // If 11 digits, must start with '1'
    if (count == 11) {
        if (digits[0] != '1') {
            char *res = malloc(11);
            if (res) memcpy(res, INVALID_RESULT, 11);
            return res;
        }
        // remove leading '1'
        memmove(digits, digits + 1, count); // shifts the remaining 10 digits + null
        count = 10;
    }

    // Validate area code (first digit) and exchange code (fourth digit)
    if (digits[0] == '0' || digits[0] == '1' || digits[3] == '0' || digits[3] == '1') {
        char *res = malloc(11);
        if (res) memcpy(res, INVALID_RESULT, 11);
        return res;
    }

    // Valid number: copy to result
    char *result = malloc(11);
    if (result == NULL) return NULL; // allocation failure
    memcpy(result, digits, 11); // includes null terminator
    return result;
}