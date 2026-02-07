#include "allergies.h"
#include <math.h>

bool is_allergic_to(allergen_t allergen, int allergy_score) {
    return (bool) (((allergen_t) pow(2, allergen)) & allergy_score);
}

allergen_list_t get_allergens(int allergy_score) {
    allergen_list_t allergen_list;
    
    allergen_list.count = 0;
    for (allergen_t allergen = ALLERGEN_EGGS; allergen < ALLERGEN_COUNT; allergen++) {
        const bool is_allergic = is_allergic_to(allergen, allergy_score);
        if (!is_allergic) continue;

        allergen_list.allergens[allergen] = true;
        allergen_list.count++;
    }

    return allergen_list;
}