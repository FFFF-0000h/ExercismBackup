module space_age
  implicit none
contains

  double precision function age_in_years(planet, seconds)
    character(len=*), intent(in) :: planet
    double precision, intent(in) :: seconds

    double precision :: orbital_period
    double precision, parameter :: seconds_per_earth_year = 31557600.0d0

    select case(trim(planet))
    case("Mercury")
      orbital_period = 0.2408467d0
    case("Venus")
      orbital_period = 0.61519726d0
    case("Earth")
      orbital_period = 1.0d0
    case("Mars")
      orbital_period = 1.8808158d0
    case("Jupiter")
      orbital_period = 11.862615d0
    case("Saturn")
      orbital_period = 29.447498d0
    case("Uranus")
      orbital_period = 84.016846d0
    case("Neptune")
      orbital_period = 164.79132d0
    case default
      ! If an unknown planet is passed, return 0.0 (or you could raise an error)
      orbital_period = 1.0d0  ! fallback, though shouldn't happen
    end select

    age_in_years = seconds / (seconds_per_earth_year * orbital_period)

  end function age_in_years

end module space_age