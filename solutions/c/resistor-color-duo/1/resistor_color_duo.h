#ifndef RESISTOR_COLOR_DUO_H
#define RESISTOR_COLOR_DUO_H

#include <stdint.h>

// Define the resistor band colors enum
typedef enum {
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
} resistor_band_t;

// Function to calculate the resistance value from colors
uint16_t color_code(resistor_band_t* colors);

#endif