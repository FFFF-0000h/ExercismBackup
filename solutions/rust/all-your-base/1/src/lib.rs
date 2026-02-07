#[derive(Debug, PartialEq, Eq)]
pub enum Error {
    InvalidInputBase,
    InvalidOutputBase,
    InvalidDigit(u32),
}

///
/// Convert a number between two bases.
///
/// A number is any slice of digits.
/// A digit is any unsigned integer (e.g. u8, u16, u32, u64, or usize).
/// Bases are specified as unsigned integers.
///
/// Return the corresponding Error enum if the conversion is impossible.
///
///
/// You are allowed to change the function signature as long as all test still pass.
///
///
/// Example:
/// Input
///   number: &[4, 2]
///   from_base: 10
///   to_base: 2
/// Result
///   Ok(vec![1, 0, 1, 0, 1, 0])
///
/// The example corresponds to converting the number 42 from decimal
/// which is equivalent to 101010 in binary.
///
///
/// Notes:
///  * The empty slice ( "[]" ) is equal to the number 0.
///  * Never output leading 0 digits, unless the input number is 0, in which the output must be `[0]`.
///    However, your function must be able to process input with leading 0 digits.
///
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
        // Check for multiplication overflow
        decimal_value = decimal_value
            .checked_mul(from_base as u64)
            .and_then(|v| v.checked_add(digit as u64))
            .ok_or_else(|| Error::InvalidDigit(digit))?;
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