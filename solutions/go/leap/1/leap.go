// Package leap provides a function to determine if a given year is a leap year.
package leap

// IsLeapYear returns true if the given year is a leap year according to the Gregorian calendar rules.
func IsLeapYear(year int) bool {
	return year%400 == 0 || (year%4 == 0 && year%100 != 0)
}