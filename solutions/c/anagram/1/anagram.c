#include "anagram.h"
#include <string.h>
#include <ctype.h>
#include <stdlib.h>

// Helper function to compare two characters case-insensitively
static int char_compare(const void *a, const void *b) {
    return *(const char *)a - *(const char *)b;
}

// Helper to convert string to lowercase and sort its characters
static void normalize_word(const char *word, char *buffer) {
    size_t len = strlen(word);
    for (size_t i = 0; i < len; i++) {
        buffer[i] = tolower((unsigned char)word[i]);
    }
    buffer[len] = '\0';
    qsort(buffer, len, sizeof(char), char_compare);
}

// Helper to check if two words are case-insensitive equal
static int is_same_word(const char *word1, const char *word2) {
    size_t len1 = strlen(word1);
    size_t len2 = strlen(word2);
    if (len1 != len2) return 0;
    
    for (size_t i = 0; i < len1; i++) {
        if (tolower((unsigned char)word1[i]) != tolower((unsigned char)word2[i])) {
            return 0;
        }
    }
    return 1;
}

void find_anagrams(const char *subject, struct candidates *candidates) {
    // Normalize the subject
    char subject_normalized[MAX_STR_LEN + 1];
    normalize_word(subject, subject_normalized);

    for (size_t i = 0; i < candidates->count; i++) {
        const char *candidate_word = candidates->candidate[i].word;

        // If the candidate is the same word as subject (case-insensitive), it's not an anagram
        if (is_same_word(subject, candidate_word)) {
            candidates->candidate[i].is_anagram = NOT_ANAGRAM;
            continue;
        }

        // If lengths differ, not an anagram
        if (strlen(subject) != strlen(candidate_word)) {
            candidates->candidate[i].is_anagram = NOT_ANAGRAM;
            continue;
        }

        // Normalize the candidate and compare
        char candidate_normalized[MAX_STR_LEN + 1];
        normalize_word(candidate_word, candidate_normalized);

        if (strcmp(subject_normalized, candidate_normalized) == 0) {
            candidates->candidate[i].is_anagram = IS_ANAGRAM;
        } else {
            candidates->candidate[i].is_anagram = NOT_ANAGRAM;
        }
    }
}