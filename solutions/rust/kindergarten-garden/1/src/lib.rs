pub fn plants(diagram: &str, student: &str) -> Vec<&'static str> {
    // List of students in alphabetical order
    let students = [
        "Alice", "Bob", "Charlie", "David", 
        "Eve", "Fred", "Ginny", "Harriet", 
        "Ileana", "Joseph", "Kincaid", "Larry"
    ];
    
    // Find the index of the student
    let student_index = students.iter()
        .position(|&s| s == student)
        .unwrap();
    
    // Split diagram into rows
    let rows: Vec<&str> = diagram.split('\n').collect();
    let row1 = rows[0];
    let row2 = rows[1];
    
    // Each student gets 2 plants from each row
    // Starting position for this student: student_index * 2
    let start = student_index * 2;
    
    // Collect plants from both rows
    let mut result = Vec::new();
    
    // Get plants from first row
    for i in 0..2 {
        let plant_char = row1.chars().nth(start + i).unwrap();
        result.push(match plant_char {
            'G' => "grass",
            'C' => "clover",
            'R' => "radishes",
            'V' => "violets",
            _ => panic!("Invalid plant character"),
        });
    }
    
    // Get plants from second row
    for i in 0..2 {
        let plant_char = row2.chars().nth(start + i).unwrap();
        result.push(match plant_char {
            'G' => "grass",
            'C' => "clover",
            'R' => "radishes",
            'V' => "violets",
            _ => panic!("Invalid plant character"),
        });
    }
    
    result
}