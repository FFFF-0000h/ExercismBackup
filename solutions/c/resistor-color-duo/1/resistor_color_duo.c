#include "resistor_color_duo.h"

uint16_t color_code(resistor_band_t* colors) {
    // Take only the first two colors and ignore the rest
    // First color is tens digit, second color is ones digit
    
    uint16_t tens = colors[0];  // First color value
    uint16_t ones = colors[1];  // Second color value
    
    return tens * 10 + ones;
}