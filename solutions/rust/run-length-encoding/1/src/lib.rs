pub fn encode(source: &str) -> String {
    let mut encoded = String::new();
    let mut chars = source.chars().peekable();
    while let Some(c) = chars.next() {
        let mut count = 1;
        while chars.peek() == Some(&c) {
            chars.next();
            count += 1;
        }
        if count > 1 {
            encoded.push_str(&count.to_string());
        }
        encoded.push(c);
    }
    encoded
}

pub fn decode(source: &str) -> String {
    let mut decoded = String::new();
    let mut count_str = String::new();
    for c in source.chars() {
        if c.is_ascii_digit() {
            count_str.push(c);
        } else {
            let count: usize = if count_str.is_empty() {
                1
            } else {
                count_str.parse().unwrap()
            };
            decoded.push_str(&c.to_string().repeat(count));
            count_str.clear();
        }
    }
    decoded
}