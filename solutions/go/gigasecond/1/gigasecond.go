// Package gigasecond calculates the moment one gigasecond after a given time.
package gigasecond

import "time"

// AddGigasecond returns the time one gigasecond (10^9 seconds) after t.
func AddGigasecond(t time.Time) time.Time {
	return t.Add(1_000_000_000 * time.Second)
}