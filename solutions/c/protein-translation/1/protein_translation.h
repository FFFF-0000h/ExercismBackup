

#ifndef PROTEIN_TRANSLATION_H
#define PROTEIN_TRANSLATION_H

#include <stdbool.h>
#include <stddef.h>

#define MAX_AMINO_ACIDS 10

typedef enum {
    Methionine,
    Phenylalanine,
    Leucine,
    Serine,
    Tyrosine,
    Cysteine,
    Tryptophan,
    STOP,
    UNVALID,
} amino_acid_t;

typedef struct {
   bool valid;
   size_t count;
   amino_acid_t amino_acids[MAX_AMINO_ACIDS];
} protein_t;

amino_acid_t translation(const char *dna);

protein_t protein(const char *const rna);

#endif
