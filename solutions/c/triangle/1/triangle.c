#include "triangle.h"

bool is_legit(triangle_t sides) {
    if (sides.a == 0 || sides.b == 0 || sides.c == 0) return false;
    if (sides.a + sides.b < sides.c) return false;
    if (sides.b + sides.c < sides.a) return false;
    if (sides.c + sides.a < sides.b) return false;

    return true;
}

bool is_equilateral(triangle_t sides) {
    if (!is_legit(sides)) return false;

    if (sides.a == sides.b && sides.b == sides.c) return true;
    else return false;
}

bool is_isosceles(triangle_t sides) {
    if (!is_legit(sides)) return false;

    if (sides.a == sides.b || sides.b == sides.c || sides.c == sides.a) return true;
    else return false;
}

bool is_scalene(triangle_t sides) {
    if (!is_legit(sides)) return false;
    
    if (is_isosceles(sides)) return false;
    return true;
}