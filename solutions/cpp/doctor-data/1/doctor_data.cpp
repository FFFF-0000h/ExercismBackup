#include "doctor_data.h"

namespace heaven {
    // Constructor with 2 arguments (default system is Sol)
    Vessel::Vessel(std::string name, int generation)
        : name(name), generation(generation), current_system(star_map::System::Sol), busters(0) {}
    
    // Constructor with 3 arguments
    Vessel::Vessel(std::string name, int generation, star_map::System current_system)
        : name(name), generation(generation), current_system(current_system), busters(0) {}
    
    // Replicate function - creates a new vessel with increased generation
    Vessel Vessel::replicate(std::string new_name) {
        // Create a new vessel with same system, generation+1, and no busters
        return Vessel(new_name, generation + 1, current_system);
    }
    
    // Add a buster device
    void Vessel::make_buster() {
        busters++;
    }
    
    // Shoot a buster device if available
    bool Vessel::shoot_buster() {
        if (busters > 0) {
            busters--;
            return true;
        }
        return false;
    }
    
    // Non-member function: Returns the name of the older "Bob" (lower generation)
    std::string get_older_bob(const Vessel& a, const Vessel& b) {
        if (a.generation < b.generation) {
            return a.name;
        } else {
            return b.name;
        }
    }
    
    // Non-member function: Checks if two vessels are in the same system
    bool in_the_same_system(const Vessel& a, const Vessel& b) {
        return a.current_system == b.current_system;
    }
}