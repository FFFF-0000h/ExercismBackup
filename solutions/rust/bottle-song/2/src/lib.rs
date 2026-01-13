pub fn recite(start_bottles: u32, take_down: u32) -> String {
    // Store both capitalized and lowercase versions
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
        
        let next = current - 1;
        
        // Get the word forms
        let (_current_lower, current_caps) = number_words[current as usize];
        let (next_lower, _next_caps) = if next > 0 { 
            number_words[next as usize]
        } else { 
            ("no", "no")  // lowercase in final line
        };
        
        let bottle_s = if current == 1 { "bottle" } else { "bottles" };
        let next_bottle_s = if next == 1 { "bottle" } else { "bottles" };
        
        let verse = format!(
            "{current_caps} green {bottle_s} hanging on the wall,\n\
             {current_caps} green {bottle_s} hanging on the wall,\n\
             And if one green bottle should accidentally fall,\n\
             There'll be {next_lower} green {next_bottle_s} hanging on the wall."
        );
        
        verses.push(verse);
    }
    
    verses.join("\n\n")
}