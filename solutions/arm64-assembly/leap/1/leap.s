.text
.global leap_year

// Function: leap_year
// Parameters: w0 = year (32-bit integer)
// Returns:    w0 = 1 if leap year, 0 if not
// Leap year rules:
// 1. If year % 400 == 0 => leap year
// 2. Else if year % 100 == 0 => NOT leap year  
// 3. Else if year % 4 == 0 => leap year
// 4. Else => NOT leap year

leap_year:
    // Save year in w1
    mov w1, w0
    
    // Check if divisible by 400
    mov w2, #400
    udiv w3, w0, w2     // w3 = year / 400
    msub w3, w3, w2, w0 // w3 = year - (year/400)*400 = year % 400
    cbz w3, .is_leap    // if year % 400 == 0, it's leap
    
    // Check if divisible by 100
    mov w0, w1          // Restore year
    mov w2, #100
    udiv w3, w0, w2     // w3 = year / 100
    msub w3, w3, w2, w0 // w3 = year % 100
    cbz w3, .not_leap   // if year % 100 == 0, NOT leap
    
    // Check if divisible by 4
    mov w0, w1          // Restore year
    mov w2, #4
    udiv w3, w0, w2     // w3 = year / 4
    msub w3, w3, w2, w0 // w3 = year % 4
    cbz w3, .is_leap    // if year % 4 == 0, leap
    
.not_leap:
    mov w0, #0          // Return 0 (false)
    ret
    
.is_leap:
    mov w0, #1          // Return 1 (true)
    ret