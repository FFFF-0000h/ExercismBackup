pub fn factors(n: u64) -> Vec<u64> {
    let mut result = Vec::new();
    let mut num = n;
    let mut divisor = 2;
    
    // Special case for 0 and 1
    if n <= 1 {
        return result;
    }
    
    // While num is greater than 1
    while num > 1 {
        // Try to divide by current divisor
        while num % divisor == 0 {
            result.push(divisor);
            num /= divisor;
        }
        // Move to next divisor
        divisor += 1;
        
        // Optimization: we only need to check up to sqrt(num)
        // If divisor * divisor > num and num > 1, then num is prime
        if divisor * divisor > num && num > 1 {
            result.push(num);
            break;
        }
    }
    
    result
}