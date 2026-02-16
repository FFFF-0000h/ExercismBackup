pub struct Allergies {
    score: u32,
}

#[derive(Debug, PartialEq, Eq, Clone, Copy)]
pub enum Allergen {
    Eggs,
    Peanuts,
    Shellfish,
    Strawberries,
    Tomatoes,
    Chocolate,
    Pollen,
    Cats,
}

impl Allergen {
    // Get the bit value for each allergen
    fn value(&self) -> u32 {
        match self {
            Allergen::Eggs => 1,
            Allergen::Peanuts => 2,
            Allergen::Shellfish => 4,
            Allergen::Strawberries => 8,
            Allergen::Tomatoes => 16,
            Allergen::Chocolate => 32,
            Allergen::Pollen => 64,
            Allergen::Cats => 128,
        }
    }
    
    // Get all allergens in order
    fn all() -> [Allergen; 8] {
        [
            Allergen::Eggs,
            Allergen::Peanuts,
            Allergen::Shellfish,
            Allergen::Strawberries,
            Allergen::Tomatoes,
            Allergen::Chocolate,
            Allergen::Pollen,
            Allergen::Cats,
        ]
    }
}

impl Allergies {
    pub fn new(score: u32) -> Self {
        Allergies { score }
    }

    pub fn is_allergic_to(&self, allergen: &Allergen) -> bool {
        // Check if the specific bit is set
        // We mask with 0xFF to only consider the lower 8 bits (allergens we care about)
        (self.score & 0xFF) & allergen.value() != 0
    }

    pub fn allergies(&self) -> Vec<Allergen> {
        let mut result = Vec::new();
        let masked_score = self.score & 0xFF; // Only consider valid allergens
        
        for allergen in Allergen::all() {
            if masked_score & allergen.value() != 0 {
                result.push(allergen);
            }
        }
        
        result
    }
}