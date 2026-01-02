#include "vehicle_purchase.h"

namespace vehicle_purchase {

// needs_license determines whether a license is needed to drive a type of
// vehicle. Only "car" and "truck" require a license.
bool needs_license(std::string kind) {
    // Return true if kind is "car" or "truck"
    return kind == "car" || kind == "truck";
}

// choose_vehicle recommends a vehicle for selection. It always recommends the
// vehicle that comes first in lexicographical order.
std::string choose_vehicle(std::string option1, std::string option2) {
    // Compare the two options lexicographically
    std::string chosen;
    if (option1 < option2) {
        chosen = option1;
    } else {
        chosen = option2;
    }
    
    return chosen + " is clearly the better choice.";
}

// calculate_resell_price calculates how much a vehicle can resell for at a
// certain age.
double calculate_resell_price(double original_price, double age) {
     // Apply discount based on age
    if (age < 3) {
        // Less than 3 years: 80% of original price
        return original_price * 0.8;
    } else if (age < 10) {
        // 3 to 9 years: 70% of original price
        return original_price * 0.7;
    } else {
        // 10+ years: 50% of original price
        return original_price * 0.5;
    }
}

}  // namespace vehicle_purchase
