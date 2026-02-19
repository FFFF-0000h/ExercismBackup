#pragma once

namespace space_age {
    class space_age {
      private:
        long int secs{};
      public:
        space_age(long int seconds);
        long int seconds() const; 
        float on_earth() const;
        float on_mercury() const;
        float on_venus() const;
        float on_mars() const;
        float on_jupiter() const;
        float on_saturn() const;
        float on_uranus() const;
        float on_neptune() const;
        
    };
}  // namespace space_age
