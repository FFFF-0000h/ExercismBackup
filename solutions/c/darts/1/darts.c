#include "darts.h"
#include <math.h>

uint8_t score(coordinate_t landing_position) {
    // Calculate squared distance from center
    float squared_distance = landing_position.x * landing_position.x 
                           + landing_position.y * landing_position.y;
    
    // Compare squared distances to squared radii
    if (squared_distance <= 1.0f * 1.0f) {      // radius^2 = 1
        return 10;
    } else if (squared_distance <= 5.0f * 5.0f) {  // radius^2 = 25
        return 5;
    } else if (squared_distance <= 10.0f * 10.0f) { // radius^2 = 100
        return 1;
    } else {
        return 0;
    }
}