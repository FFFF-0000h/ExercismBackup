#include "eliuds_eggs.h"

namespace chicken_coop {

    int positions_to_quantity(int number) {
        int count = 0;
        
        // Handle negative numbers by converting to unsigned
        unsigned int num = static_cast<unsigned int>(number);
        
        // Brian Kernighan's algorithm:
        // Subtracting 1 from a number flips all the bits after the rightmost 1
        // (including the rightmost 1). So num & (num-1) will remove the rightmost 1.
        while (num) {
            num &= (num - 1);
            count++;
        }
        
        return count;
    }

}  // namespace chicken_coop