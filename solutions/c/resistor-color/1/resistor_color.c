#include "resistor_color.h"

int color_code(resistor_band_t color) {
    // Since the enum values match their numeric codes,
    // we can just return the color value directly
    return color;
}

const resistor_band_t* colors(void) {
    // Create and return a static array of all colors
    static const resistor_band_t all_colors[] = {
        BLACK,
        BROWN,
        RED,
        ORANGE,
        YELLOW,
        GREEN,
        BLUE,
        VIOLET,
        GREY,
        WHITE
    };
    
    return all_colors;
}