#[derive(Debug, PartialEq, Eq)]
pub enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

pub fn sublist(first_list: &[i32], second_list: &[i32]) -> Comparison {
    // Handle empty list cases
    match (first_list.is_empty(), second_list.is_empty()) {
        (true, true) => return Comparison::Equal,      // Both empty
        (true, false) => return Comparison::Sublist,   // Empty is sublist of any non-empty
        (false, true) => return Comparison::Superlist, // Non-empty is superlist of empty
        _ => (), // Continue to check non-empty cases
    }
    
    // Check if lists are equal
    if first_list == second_list {
        return Comparison::Equal;
    }
    
    // Check if first_list is a sublist of second_list
    // (first_list is contained within second_list)
    if is_sublist(first_list, second_list) {
        return Comparison::Sublist;
    }
    
    // Check if first_list is a superlist of second_list
    // (second_list is contained within first_list)
    if is_sublist(second_list, first_list) {
        return Comparison::Superlist;
    }
    
    // None of the above conditions are true
    Comparison::Unequal
}

// Helper function to check if `needle` is a contiguous sublist of `haystack`
fn is_sublist(needle: &[i32], haystack: &[i32]) -> bool {
    // If needle is longer than haystack, it can't be a sublist
    if needle.len() > haystack.len() {
        return false;
    }
    
    // If needle is empty, it's always a sublist
    if needle.is_empty() {
        return true;
    }
    
    // Check all possible starting positions in haystack
    for start in 0..=(haystack.len() - needle.len()) {
        // Check if the slice matches the needle
        if haystack[start..start + needle.len()] == *needle {
            return true;
        }
    }
    
    false
}