#include "pangram.h"
#include <ctype.h>
#include <stdbool.h>
#include <stddef.h>

bool is_pangram(const char *sentence) {
    if (sentence == NULL) {
        return false;
    }
    
    // Create a boolean array to track which letters we've seen
    bool letters_seen[26] = {false};
    
    // Iterate through each character in the sentence
    for (int i = 0; sentence[i] != '\0'; i++) {
        char c = sentence[i];
        
        // Convert to lowercase if it's a letter
        if (isalpha((unsigned char)c)) {
            c = tolower((unsigned char)c);
            letters_seen[c - 'a'] = true;
        }
    }
    
    // Check if all letters have been seen
    for (int i = 0; i < 26; i++) {
        if (!letters_seen[i]) {
            return false;
        }
    }
    
    return true;
}