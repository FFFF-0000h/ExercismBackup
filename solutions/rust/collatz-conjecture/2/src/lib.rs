pub fn collatz(n: u64) -> Option<u64> {
    if n == 0 {
        return None; // Invalid input (should be positive)
    }
    
    let mut steps = 0;
    let mut current = n;
    
    while current != 1 {
        if current.is_multiple_of(2) {
            // Even: n = n / 2
            current /= 2;
        } else {
            // Odd: n = 3n + 1
            // Check for potential overflow
            current = current.checked_mul(3)?.checked_add(1)?;
        }
        steps += 1;
    }
    
    Some(steps)
}