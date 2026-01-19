pub fn is_leap_year(year: u64) -> bool {
    // Leap year rules:
    // 1. Divisible by 4
    // 2. But not divisible by 100, unless also divisible by 400
    
    match (year % 4, year % 100, year % 400) {
        (0, 0, 0) => true,    // Divisible by 400
        (0, 0, _) => false,   // Divisible by 100 but not 400
        (0, _, _) => true,    // Divisible by 4 but not 100
        _ => false,           // Not divisible by 4
    }
}