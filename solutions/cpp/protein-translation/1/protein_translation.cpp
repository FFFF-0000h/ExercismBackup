#include "protein_translation.h"
#include <string>
#include <vector>
#include <unordered_map>

namespace protein_translation {

std::vector<std::string> proteins(const std::string& rna) {
    std::vector<std::string> result;
    
    // Create codon to protein mapping
    std::unordered_map<std::string, std::string> codon_map = {
        {"AUG", "Methionine"},
        {"UUU", "Phenylalanine"}, {"UUC", "Phenylalanine"},
        {"UUA", "Leucine"}, {"UUG", "Leucine"},
        {"UCU", "Serine"}, {"UCC", "Serine"}, 
        {"UCA", "Serine"}, {"UCG", "Serine"},
        {"UAU", "Tyrosine"}, {"UAC", "Tyrosine"},
        {"UGU", "Cysteine"}, {"UGC", "Cysteine"},
        {"UGG", "Tryptophan"},
        {"UAA", "STOP"}, {"UAG", "STOP"}, {"UGA", "STOP"}
    };
    
    // Process RNA in chunks of 3 characters (codons)
    for (size_t i = 0; i < rna.length(); i += 3) {
        if (i + 3 > rna.length()) {
            break; // Incomplete codon at the end
        }
        
        std::string codon = rna.substr(i, 3);
        
        // Check if codon is in our map
        auto it = codon_map.find(codon);
        if (it == codon_map.end()) {
            // Unknown codon - for this exercise, we'll assume it's not in the input
            // but we could throw an exception if needed
            break;
        }
        
        std::string protein = it->second;
        
        // Check for STOP codon
        if (protein == "STOP") {
            break;
        }
        
        // Add the protein to our result
        result.push_back(protein);
    }
    
    return result;
}

}  // namespace protein_translation