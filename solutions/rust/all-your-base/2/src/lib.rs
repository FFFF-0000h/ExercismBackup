#[derive(Debug, PartialEq, Eq)]
pub enum Error {
    InvalidInputBase,
    InvalidOutputBase,
    InvalidDigit(u32),
}

pub fn convert(number: &[u32], from_base: u32, to_base: u32) -> Result<Vec<u32>, Error> {
    // Validate bases
    if from_base < 2 {
        return Err(Error::InvalidInputBase);
    }
    if to_base < 2 {
        return Err(Error::InvalidOutputBase);
    }
    
    // Handle special case: empty slice means 0
    if number.is_empty() {
        return Ok(vec![0]);
    }
    
    // Validate all digits are valid for the input base
    for &digit in number {
        if digit >= from_base {
            return Err(Error::InvalidDigit(digit));
        }
    }
    
    // Convert from input base to decimal (u64 to avoid overflow)
    let mut decimal_value: u64 = 0;
    for &digit in number {
        // Check for multiplication and addition overflow
        decimal_value = decimal_value
            .checked_mul(from_base as u64)
            .and_then(|v| v.checked_add(digit as u64))
            .ok_or(Error::InvalidDigit(digit))?;
    }
    
    // Handle special case: if decimal value is 0, return [0]
    if decimal_value == 0 {
        return Ok(vec![0]);
    }
    
    // Convert from decimal to output base
    let mut result = Vec::new();
    let mut remaining = decimal_value;
    
    while remaining > 0 {
        let digit = (remaining % to_base as u64) as u32;
        result.push(digit);
        remaining /= to_base as u64;
    }
    
    // Reverse to get correct order (most significant digit first)
    result.reverse();
    
    Ok(result)
}