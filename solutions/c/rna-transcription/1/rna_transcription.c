#include "rna_transcription.h"
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

char *to_rna(const char *dna) {
    if (dna == NULL) {
        return NULL;
    }
    
    // Allocate memory for RNA string (same length as DNA + null terminator)
    size_t len = strlen(dna);
    char *rna = malloc(len + 1);
    if (rna == NULL) {
        return NULL; // Memory allocation failed
    }
    
    // Transcribe each nucleotide
    for (size_t i = 0; i < len; i++) {
        char nucleotide = dna[i];
        
        // Convert to uppercase if needed
        nucleotide = toupper((unsigned char)nucleotide);
        
        switch (nucleotide) {
            case 'G':
                rna[i] = 'C';
                break;
            case 'C':
                rna[i] = 'G';
                break;
            case 'T':
                rna[i] = 'A';
                break;
            case 'A':
                rna[i] = 'U';
                break;
            default:
                // Invalid nucleotide - free memory and return NULL
                free(rna);
                return NULL;
        }
    }
    
    rna[len] = '\0'; // Null-terminate the string
    return rna;
}