namespace targets {

class Alien {
private:
    int health;
    
public:
    int x_coordinate;
    int y_coordinate;
    
    // Constructor - initialization list order must match declaration order
    Alien(int x, int y) : health(3), x_coordinate(x), y_coordinate(y) {}
    
    // Get health
    int get_health() const {
        return health;
    }
    
    // Hit method
    bool hit() {
        if (health > 0) {
            health--;
        }
        return true;
    }
    
    // Check if alive
    bool is_alive() const {
        return health > 0;
    }
    
    // Teleport method
    bool teleport(int x_new, int y_new) {
        x_coordinate = x_new;
        y_coordinate = y_new;
        return true;
    }
    
    // Collision detection
    bool collision_detection(const Alien& other) const {
        return (x_coordinate == other.x_coordinate) && 
               (y_coordinate == other.y_coordinate);
    }
};

}  // namespace targets