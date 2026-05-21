fn is_vowel(c: char) -> bool {
    matches!(c, 'a' | 'e' | 'i' | 'o' | 'u')
}

fn pig_latin_word(word: &str) -> String {
    if word.is_empty() {
        return String::new();
    }

    let first_char = word.chars().next().unwrap();
    if is_vowel(first_char) || word.starts_with("xr") || word.starts_with("yt") {
        return format!("{word}ay");
    }

    // Rule 3: zero or more consonants followed by "qu"
    if let Some(qu_pos) = word.find("qu") {
        let prefix = &word[..qu_pos];
        if prefix.chars().all(|c| !is_vowel(c)) {
            let moved = &word[..qu_pos + 2];
            let rest = &word[qu_pos + 2..];
            return format!("{rest}{moved}ay");
        }
    }

    // Rule 4: one or more consonants followed by 'y'
    if let Some(y_pos) = word.find('y') && y_pos > 0 {
        let prefix = &word[..y_pos];
        if prefix.chars().all(|c| !is_vowel(c)) {
            let rest = &word[y_pos..];
            return format!("{rest}{prefix}ay");
        }
    }

    // Rule 2: move initial consonants before the first vowel
    if let Some(vowel_pos) = word.find(is_vowel) {
        let prefix = &word[..vowel_pos];
        let rest = &word[vowel_pos..];
        return format!("{rest}{prefix}ay");
    }

    // Fallback: no vowel found – move the whole word
    format!("{word}ay")
}

pub fn translate(input: &str) -> String {
    input
        .split_whitespace()
        .map(pig_latin_word)
        .collect::<Vec<_>>()
        .join(" ")
}