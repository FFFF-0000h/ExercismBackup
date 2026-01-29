#include "isogram.h"
#include <ctype.h>
#include <stddef.h>

bool is_isogram(const char phrase[]) {
    if (!phrase) return false;
    
    unsigned int letter_flags = 0;
    
    for (size_t i = 0; phrase[i] != '\0'; i++) {
        char c = phrase[i];
        
        // Skip spaces and hyphens as specified
        if (c == ' ' || c == '-') {
            continue;
        }
        
        // Convert to lowercase
        char lower_c = tolower(c);
        
        // Check if this is a valid letter
        if (lower_c < 'a' || lower_c > 'z') {
            return false;  // Invalid character
        }
        
        // Create bit mask for this letter
        unsigned int bit_mask = 1 << (lower_c - 'a');
        
        // Check if we've seen this letter before
        if ((letter_flags & bit_mask) != 0) {
            return false;  // Letter repeats, not an isogram
        }
        
        // Mark this letter as seen
        letter_flags |= bit_mask;
    }
    
    return true;  // No repeating letters found
}