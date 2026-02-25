

#include "protein_translation.h"
#include <stdbool.h>
#include <stddef.h>
#include <string.h>

amino_acid_t translation(const char *dna) {
    if (0 == strncmp("AUG", dna, 3)) {
        return Methionine;
    } else if (0 == strncmp("UUU", dna, 3)) {
        return Phenylalanine;
    } else if (0 == strncmp("UUC", dna, 3)) {
        return Phenylalanine;
    } else if (0 == strncmp("UUA", dna, 3)) {
        return Leucine;
    } else if (0 == strncmp("UUG", dna, 3)) {
        return Leucine;
    } else if (0 == strncmp("UC", dna, 2)) {
        return Serine;
    } else if (0 == strncmp("UAU", dna, 3)) {
        return Tyrosine;
    } else if (0 == strncmp("UAC", dna, 3)) {
        return Tyrosine;
    } else if (0 == strncmp("UGU", dna, 3)) {
        return Cysteine;
    } else if (0 == strncmp("UGC", dna, 3)) {
        return Cysteine;
    } else if (0 == strncmp("UGG", dna, 3)) {
        return Tryptophan;
    } else if (0 == strncmp("UAA", dna, 3)) {
        return STOP;
    } else if (0 == strncmp("UAG", dna, 3)) {
        return STOP;
    } else if (0 == strncmp("UGA", dna, 3)) {
        return STOP;
    } else {
        return UNVALID;
    }
}


protein_t protein(const char *const rna) {
    const size_t rna_len = strlen(rna);
    const size_t proteine_len = rna_len / 3;
    protein_t decoded = (protein_t){.valid = true, .count = 0};
    for (; decoded.count < proteine_len; decoded.count += 1) {
        const amino_acid_t acid = translation(&(rna[3 * decoded.count]));
        if (STOP == acid) {
            return decoded;
        } else if (UNVALID == acid) {
            return (protein_t){.valid = false};
        } else {
            decoded.amino_acids[decoded.count] = acid;
        }
    }
    return 3 * proteine_len == rna_len ? decoded : (protein_t){.valid = false};
}