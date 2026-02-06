#include "lasagna_master.h"

namespace lasagna_master {

// Task 1: Estimate preparation time
int preparationTime(const std::vector<std::string>& layers, int avgTimePerLayer) {
    // Multiply number of layers by average time per layer
    return static_cast<int>(layers.size()) * avgTimePerLayer;
}

// Task 2: Compute amounts of noodles and sauce needed
amount quantities(const std::vector<std::string>& layers) {
    amount result{0, 0.0};
    
    for (const auto& layer : layers) {
        if (layer == "noodles") {
            result.noodles += 50;  // 50 grams per noodle layer
        } else if (layer == "sauce") {
            result.sauce += 0.2;   // 0.2 liters per sauce layer
        }
    }
    
    return result;
}

// Task 3: Add secret ingredient from friend's list
void addSecretIngredient(std::vector<std::string>& myIngredients,
                        const std::vector<std::string>& friendsIngredients) {
    // Check if myIngredients has at least one element
    if (myIngredients.empty()) {
        return;
    }
    
    // Replace the last element (which should be "?") with friend's last ingredient
    myIngredients.back() = friendsIngredients.back();
}

// Task 4: Scale recipe for more portions
std::vector<double> scaleRecipe(const std::vector<double>& quantities, int portions) {
    std::vector<double> scaled;
    scaled.reserve(quantities.size());
    
    // Scale factor: portions / 2 (since original is for 2 portions)
    double scaleFactor = portions / 2.0;
    
    for (double amount : quantities) {
        scaled.push_back(amount * scaleFactor);
    }
    
    return scaled;
}

// Task 5: Unlock Family Secret - add single secret ingredient
void addSecretIngredient(std::vector<std::string>& myIngredients,
                        const std::string& secretIngredient) {
    // Check if myIngredients has at least one element
    if (myIngredients.empty()) {
        return;
    }
    
    // Replace the last element (which should be "?") with the secret ingredient
    myIngredients.back() = secretIngredient;
}

}  // namespace lasagna_master