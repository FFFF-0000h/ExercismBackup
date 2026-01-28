#ifndef DOCTOR_DATA_H
#define DOCTOR_DATA_H

#include <string>

namespace star_map {
    enum class System {
        Sol,
        BetaHydri,
        AlphaCentauri,
        EpsilonEridani,
        DeltaEridani,
        Omicron2Eridani
    };
}

namespace heaven {
    class Vessel {
    public:
        // Member variables
        std::string name;
        int generation;
        star_map::System current_system;
        int busters;  // Number of buster devices
        
        // Constructors
        Vessel(std::string name, int generation);
        Vessel(std::string name, int generation, star_map::System current_system);
        
        // Member functions
        Vessel replicate(std::string new_name);
        void make_buster();
        bool shoot_buster();
    };
    
    // Non-member functions
    std::string get_older_bob(const Vessel& a, const Vessel& b);
    bool in_the_same_system(const Vessel& a, const Vessel& b);
}

#endif