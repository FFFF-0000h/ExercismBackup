#include "robot_simulator.h"
#include <string.h>

robot_status_t robot_create(robot_direction_t direction, int x, int y) {
    robot_status_t robot;
    
    // Validate direction - use default if invalid
    if (direction >= DIRECTION_NORTH && direction < DIRECTION_MAX) {
        robot.direction = direction;
    } else {
        robot.direction = DIRECTION_DEFAULT;
    }
    
    // Set position
    robot.position.x = x;
    robot.position.y = y;
    
    return robot;
}

void robot_move(robot_status_t *robot, const char *commands) {
    if (!robot || !commands) return;
    
    // Process each command character
    for (size_t i = 0; commands[i] != '\0'; i++) {
        char command = commands[i];
        
        switch (command) {
            case 'R': // Turn right
                robot->direction = (robot->direction + 1) % DIRECTION_MAX;
                break;
                
            case 'L': // Turn left
                // +3 is equivalent to -1 modulo 4
                robot->direction = (robot->direction + 3) % DIRECTION_MAX;
                break;
                
            case 'A': // Advance (move forward)
                switch (robot->direction) {
                    case DIRECTION_NORTH:
                        robot->position.y++;
                        break;
                    case DIRECTION_EAST:
                        robot->position.x++;
                        break;
                    case DIRECTION_SOUTH:
                        robot->position.y--;
                        break;
                    case DIRECTION_WEST:
                        robot->position.x--;
                        break;
                    default:
                        // Should not happen if direction is valid
                        break;
                }
                break;
                
            default:
                // Ignore invalid commands
                break;
        }
    }
}