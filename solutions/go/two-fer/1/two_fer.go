// Package twofer provides a function to share a cookie.
package twofer

import "fmt"

// ShareWith returns a string saying "One for X, one for me."
// If the name is empty, X is "you".
func ShareWith(name string) string {
	if name == "" {
		name = "you"
	}
	return fmt.Sprintf("One for %s, one for me.", name)
}