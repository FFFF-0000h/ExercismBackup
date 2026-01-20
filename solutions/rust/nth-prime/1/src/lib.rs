pub fn nth(n: u32) -> u32 {
    if n == 0 {
        return 2;
    }
    
    let mut count = 1; // We already have 2
    let mut candidate = 3;
    
    while count <= n {
        if is_prime(candidate) {
            if count == n {
                return candidate;
            }
            count += 1;
        }
        candidate += 2; // Check only odd numbers after 2
    }
    
    // This should never be reached
    0
}

fn is_prime(num: u32) -> bool {
    if num < 2 {
        return false;
    }
    if num == 2 {
        return true;
    }
    if num % 2 == 0 {
        return false;
    }
    
    let limit = (num as f64).sqrt() as u32;
    
    // Check divisibility by odd numbers up to sqrt(num)
    let mut divisor = 3;
    while divisor <= limit {
        if num % divisor == 0 {
            return false;
        }
        divisor += 2;
    }
    
    true
}