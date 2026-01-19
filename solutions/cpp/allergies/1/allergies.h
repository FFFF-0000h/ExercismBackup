#pragma once
#include <string>
#include <unordered_set>
#include <unordered_map>

namespace allergies {

class allergy_test {
private:
    int score_;
    std::unordered_set<std::string> allergic_to_;
    std::unordered_map<std::string, int> allergens_;
    
public:
    // Constructor: takes an allergy score
    allergy_test(int score);
    
    // Check if allergic to a specific item
    bool is_allergic_to(const std::string& item) const;
    
    // Get all allergies as a set of strings
    std::unordered_set<std::string> get_allergies() const;
};

}  // namespace allergies