#include "leap.h"

bool leap_year(int year) {
    // A year is a leap year if:
    // 1. It is divisible by 4
    // 2. But not divisible by 100, unless also divisible by 400
    return (year % 4 == 0) && (year % 100 != 0 || year % 400 == 0);
}