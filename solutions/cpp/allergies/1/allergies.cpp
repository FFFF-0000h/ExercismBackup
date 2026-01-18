#include "allergies.h"
#include <unordered_set>
#include <string>

namespace allergies {

allergy_test::allergy_test(int score) : score_(score) {
    // List of known allergens and their values
    allergens_ = {
        {"eggs", 1},
        {"peanuts", 2},
        {"shellfish", 4},
        {"strawberries", 8},
        {"tomatoes", 16},
        {"chocolate", 32},
        {"pollen", 64},
        {"cats", 128}
    };
    
    // Build the set of allergic_to items
    for (const auto& allergen : allergens_) {
        if (is_allergic_to(allergen.first)) {
            allergic_to_.emplace(allergen.first);
        }
    }
}

bool allergy_test::is_allergic_to(const std::string& item) const {
    // Check if item is a known allergen
    auto it = allergens_.find(item);
    if (it != allergens_.end()) {
        // Use bitwise AND to check if the corresponding bit is set
        return (score_ & it->second) != 0;
    }
    return false;  // Unknown allergen
}

std::unordered_set<std::string> allergy_test::get_allergies() const {
    return allergic_to_;
}

}  // namespace allergies