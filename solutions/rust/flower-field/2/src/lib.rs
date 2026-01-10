pub fn annotate(garden: &[&str]) -> Vec<String> {
    if garden.is_empty() {
        return Vec::new();
    }
    
    let rows = garden.len();
    let cols = garden[0].len();
    let mut result = vec![vec![' '; cols]; rows];
    
    // Pre-process: convert garden to byte slices for faster access
    let garden_bytes: Vec<&[u8]> = garden.iter().map(|s| s.as_bytes()).collect();
    
    // Directions: 8 possible neighbors
    let directions = [
        (-1, -1), (-1, 0), (-1, 1),
        (0, -1),          (0, 1),
        (1, -1),  (1, 0), (1, 1),
    ];
    
    for r in 0..rows {
        for c in 0..cols {
            // Skip if it's a flower
            if garden_bytes[r][c] == b'*' {
                result[r][c] = '*';
                continue;
            }
            
            // Count adjacent flowers
            let mut count = 0;
            for (dr, dc) in &directions {
                let nr = r as isize + dr;
                let nc = c as isize + dc;
                
                // Check bounds and if it's a flower
                if nr >= 0 && nr < rows as isize && nc >= 0 && nc < cols as isize
                    && garden_bytes[nr as usize][nc as usize] == b'*' {
                    count += 1;
                }
            }
            
            // Set the character based on count
            if count > 0 {
                result[r][c] = (b'0' + count) as char;
            }
        }
    }
    
    // Convert result to Vec<String>
    result.into_iter()
        .map(|row| row.into_iter().collect())
        .collect()
}