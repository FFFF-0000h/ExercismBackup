pub fn find(array: &[i32], key: i32) -> Option<usize> {
    let mut left = 0;
    let mut right = array.len().checked_sub(1)?; // if empty, return None

    while left <= right {
        let mid = left + (right - left) / 2;
        match array[mid].cmp(&key) {
            std::cmp::Ordering::Equal => return Some(mid),
            std::cmp::Ordering::Less => left = mid + 1,
            std::cmp::Ordering::Greater => right = mid.checked_sub(1)?,
        }
    }
    None
}