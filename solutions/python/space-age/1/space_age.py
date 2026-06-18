"""Calculate age on various planets in the Solar System given seconds."""


class SpaceAge:
    """A class to compute a person's age on different planets."""

    _seconds_per_earth_year = 31557600.0

    _orbital_periods = {
        "mercury": 0.2408467,
        "venus": 0.61519726,
        "earth": 1.0,
        "mars": 1.8808158,
        "jupiter": 11.862615,
        "saturn": 29.447498,
        "uranus": 84.016846,
        "neptune": 164.79132,
    }

    def __init__(self, seconds: int) -> None:
        """Initialize with an age in seconds."""
        self.seconds = seconds

    def _on_planet(self, planet_name: str) -> float:
        """Return age in years for a given planet, rounded to 2 decimal places."""
        earth_years = self.seconds / self._seconds_per_earth_year
        planet_years = earth_years / self._orbital_periods[planet_name]
        return round(planet_years, 2)

    def on_mercury(self) -> float:
        """Return age on Mercury."""
        return self._on_planet("mercury")

    def on_venus(self) -> float:
        """Return age on Venus."""
        return self._on_planet("venus")

    def on_earth(self) -> float:
        """Return age on Earth."""
        return self._on_planet("earth")

    def on_mars(self) -> float:
        """Return age on Mars."""
        return self._on_planet("mars")

    def on_jupiter(self) -> float:
        """Return age on Jupiter."""
        return self._on_planet("jupiter")

    def on_saturn(self) -> float:
        """Return age on Saturn."""
        return self._on_planet("saturn")

    def on_uranus(self) -> float:
        """Return age on Uranus."""
        return self._on_planet("uranus")

    def on_neptune(self) -> float:
        """Return age on Neptune."""
        return self._on_planet("neptune")