// Package weather provides tools to forecast and report current weather conditions for various cities.
package weather

// CurrentCondition stores the last reported weather condition (e.g., sunny, rainy).
var CurrentCondition string

// CurrentLocation stores the city name for which the weather was last forecasted.
var CurrentLocation string

// Forecast records the current weather condition for a given city and returns a string
// summarizing the weather in that city.
func Forecast(city, condition string) string {
	CurrentLocation, CurrentCondition = city, condition
	return CurrentLocation + " - current weather condition: " + CurrentCondition
}