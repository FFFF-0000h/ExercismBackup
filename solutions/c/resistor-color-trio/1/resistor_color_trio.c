#include "resistor_color_trio.h"
#include <math.h>

resistor_value_t color_code(resistor_band_t colors[]) {
    resistor_value_t result;
    int value = 0;
    
    // First two bands form the main value
    // First band: tens digit
    // Second band: ones digit
    value = colors[0] * 10 + colors[1];
    
    // Third band is the multiplier (number of zeros)
    int multiplier = colors[2];
    
    // Calculate the resistance value by adding zeros
    // Instead of actually concatenating zeros, we multiply by 10^multiplier
    long total_value = value;
    
    // Apply the multiplier
    if (multiplier > 0) {
        // Using pow function for exponentiation
        for (int i = 0; i < multiplier; i++) {
            total_value *= 10;
        }
    }
    
    // Determine the appropriate unit and adjust value
    if (total_value >= 1000000000) {
        // Gigaohms
        result.value = total_value / 1000000000;
        result.unit = GIGAOHMS;
    } else if (total_value >= 1000000) {
        // Megaohms
        result.value = total_value / 1000000;
        result.unit = MEGAOHMS;
    } else if (total_value >= 1000) {
        // Kiloohms
        result.value = total_value / 1000;
        result.unit = KILOOHMS;
    } else {
        // Ohms
        result.value = total_value;
        result.unit = OHMS;
    }
    
    return result;
}