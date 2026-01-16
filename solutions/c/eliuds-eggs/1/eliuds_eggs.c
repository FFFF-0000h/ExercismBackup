#include "eliuds_eggs.h"

int egg_count(int number) {
    int count = 0;
    unsigned int num = (unsigned int)number;
    
    // Brian Kernighan's algorithm
    while (num) {
        num &= (num - 1);
        count++;
    }
    
    return count;
}