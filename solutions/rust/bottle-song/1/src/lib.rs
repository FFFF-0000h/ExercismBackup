pub fn recite(start_bottles: u32, take_down: u32) -> String {
    let number_words = [
        ("no", "No"),
        ("one", "One"),
        ("two", "Two"),
        ("three", "Three"),
        ("four", "Four"),
        ("five", "Five"),
        ("six", "Six"),
        ("seven", "Seven"),
        ("eight", "Eight"),
        ("nine", "Nine"),
        ("ten", "Ten"),
    ];
    
    let mut verses = Vec::new();
    
    for i in 0..take_down {
        let current = start_bottles - i;
        if current == 0 {
            break;
        }
        
        let next = if current > 0 { current - 1 } else { 0 };
        
        // Get the capitalized version for the first word of each line
        let (current_lower, current_caps) = number_words[current as usize];
        let (next_lower, next_caps) = if next > 0 { 
            number_words[next as usize] 
        } else { 
            ("no", "no")  // "no" is not capitalized in the last line
        };
        
        let bottle_s = if current == 1 { "bottle" } else { "bottles" };
        let next_bottle_s = if next == 1 { "bottle" } else { "bottles" };
        
        let verse = format!(
            "{current_caps} green {bottle_s} hanging on the wall,\n\
             {current_caps} green {bottle_s} hanging on the wall,\n\
             And if one green bottle should accidentally fall,\n\
             There'll be {next_lower} green {next_bottle_s} hanging on the wall.",
            current_caps = current_caps,
            bottle_s = bottle_s,
            next_lower = next_lower,
            next_bottle_s = next_bottle_s
        );
        
        verses.push(verse);
    }
    
    verses.join("\n\n")
}