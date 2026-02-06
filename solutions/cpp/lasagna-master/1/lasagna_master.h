#pragma once
#include <string>
#include <vector>

namespace lasagna_master {

struct amount {
    int noodles;
    double sauce;
};

// Task 1: Estimate preparation time
int preparationTime(const std::vector<std::string>& layers, int avgTimePerLayer = 2);

// Task 2: Compute amounts of noodles and sauce needed
amount quantities(const std::vector<std::string>& layers);

// Task 3: Add secret ingredient from friend's list
void addSecretIngredient(std::vector<std::string>& myIngredients, 
                         const std::vector<std::string>& friendsIngredients);

// Task 4: Scale recipe for more portions
std::vector<double> scaleRecipe(const std::vector<double>& quantities, int portions);

// Task 5: Unlock Family Secret - add single secret ingredient
void addSecretIngredient(std::vector<std::string>& myIngredients,
                         const std::string& secretIngredient);

}  // namespace lasagna_master