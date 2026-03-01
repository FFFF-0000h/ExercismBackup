#include "rna_transcription.h"
#include <string>

namespace rna_transcription {

char to_rna(char nucleotide) {
    switch (nucleotide) {
        case 'G': return 'C';
        case 'C': return 'G';
        case 'T': return 'A';
        case 'A': return 'U';
        default:  return nucleotide;  // fallback for invalid input
    }
}

std::string to_rna(const std::string& dna) {
    std::string result;
    result.reserve(dna.size());  // optional: pre-allocate memory
    for (char c : dna) {
        result += to_rna(c);
    }
    return result;
}

}  // namespace rna_transcription