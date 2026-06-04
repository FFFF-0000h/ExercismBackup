#include "bob.h"
#include <string.h>
#include <ctype.h>
#include <stdlib.h>

char *hey_bob(char *greeting) {
    // Remove trailing whitespace to check for silence
    char *end = greeting + strlen(greeting) - 1;
    while (end >= greeting && isspace((unsigned char)*end)) {
        end--;
    }
    
    // Check for silence (empty or only whitespace)
    if (end < greeting) {
        return "Fine. Be that way!";
    }

    // Check if the message contains any letters
    int has_letters = 0;
    int is_yelling = 1;
    for (char *p = greeting; p <= end; p++) {
        if (isalpha((unsigned char)*p)) {
            has_letters = 1;
            if (islower((unsigned char)*p)) {
                is_yelling = 0;
            }
        }
    }

    // Check if it's a question (ends with ?)
    int is_question = (*end == '?');

    if (is_yelling && has_letters && is_question) {
        return "Calm down, I know what I'm doing!";
    }
    if (is_yelling && has_letters) {
        return "Whoa, chill out!";
    }
    if (is_question) {
        return "Sure.";
    }

    return "Whatever.";
}