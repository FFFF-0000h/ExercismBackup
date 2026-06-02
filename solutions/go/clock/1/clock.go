package clock

import "fmt"

// Clock represents a time without dates, as minutes since midnight.
type Clock struct {
	minutes int
}

// New creates a new Clock set to the given hour and minute.
func New(h, m int) Clock {
	totalMinutes := (h*60 + m) % (24 * 60)
	if totalMinutes < 0 {
		totalMinutes += 24 * 60
	}
	return Clock{minutes: totalMinutes}
}

// Add adds the given number of minutes and returns a new Clock.
func (c Clock) Add(m int) Clock {
	return New(0, c.minutes+m)
}

// Subtract subtracts the given number of minutes and returns a new Clock.
func (c Clock) Subtract(m int) Clock {
	return New(0, c.minutes-m)
}

// String returns a string representation of the Clock in "HH:MM" format.
func (c Clock) String() string {
	h := c.minutes / 60
	m := c.minutes % 60
	return fmt.Sprintf("%02d:%02d", h, m)
}