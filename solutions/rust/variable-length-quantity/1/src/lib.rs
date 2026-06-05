#[derive(Debug, PartialEq, Eq)]
pub enum Error {
    IncompleteNumber,
}

/// Convert a list of numbers to a stream of bytes encoded with variable length encoding.
pub fn to_bytes(values: &[u32]) -> Vec<u8> {
    let mut result = Vec::new();

    for &value in values {
        let mut bytes = Vec::new();
        let mut remaining = value;

        // The first byte (least significant 7 bits) has the high bit clear
        bytes.push((remaining & 0x7F) as u8);
        remaining >>= 7;

        // Subsequent bytes have the high bit set
        while remaining > 0 {
            bytes.push(((remaining & 0x7F) | 0x80) as u8);
            remaining >>= 7;
        }

        // Bytes are in reverse order (most significant first)
        bytes.reverse();
        result.extend(bytes);
    }

    result
}

/// Given a stream of bytes, extract all numbers which are encoded in there.
pub fn from_bytes(bytes: &[u8]) -> Result<Vec<u32>, Error> {
    if bytes.is_empty() {
        return Ok(Vec::new());
    }

    // Check if the last byte has high bit set (incomplete sequence)
    if let Some(&last) = bytes.last() {
        if last & 0x80 != 0 {
            return Err(Error::IncompleteNumber);
        }
    }

    let mut result = Vec::new();
    let mut current: u32 = 0;
    let mut started = false;

    for &byte in bytes {
        current = (current << 7) | (byte & 0x7F) as u32;
        started = true;

        if byte & 0x80 == 0 {
            // This is the last byte of the current number
            result.push(current);
            current = 0;
            started = false;
        }
    }

    Ok(result)
}