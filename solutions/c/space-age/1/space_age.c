// file.c:
#include "space_age.h"
#include <math.h>

#define EARTH_YEAR_SECONDS 31557600.0

float age(planet_t planet, int64_t seconds) {
    // Handle invalid input - maybe negative seconds
    if (seconds < 0) {
        return -1.0f;
    }
    
    double orbital_period;
    
    // Get orbital period based on planet
    switch(planet) {
        case MERCURY:
            orbital_period = 0.2408467;
            break;
        case VENUS:
            orbital_period = 0.61519726;
            break;
        case EARTH:
            orbital_period = 1.0;
            break;
        case MARS:
            orbital_period = 1.8808158;
            break;
        case JUPITER:
            orbital_period = 11.862615;
            break;
        case SATURN:
            orbital_period = 29.447498;
            break;
        case URANUS:
            orbital_period = 84.016846;
            break;
        case NEPTUNE:
            orbital_period = 164.79132;
            break;
        default:
            // Invalid planet
            return -1.0f;
    }
    
    // Calculate age on planet
    double earth_years = (double)seconds / EARTH_YEAR_SECONDS;
    double planet_years = earth_years / orbital_period;
    
    // Round to 2 decimal places
    return roundf(planet_years * 100) / 100.0f;
}