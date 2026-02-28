use std::collections::{HashMap, HashSet, BTreeSet};

pub struct School {
    roster: HashMap<u32, BTreeSet<String>>,
    all_students: HashSet<String>,
}

impl School {
    pub fn new() -> School {
        School {
            roster: HashMap::new(),
            all_students: HashSet::new(),
        }
    }

    pub fn add(&mut self, grade: u32, student: &str) {
        let student_string = student.to_string();
        // If the student is already in the school, do nothing (ignore duplicate)
        if self.all_students.contains(&student_string) {
            return;
        }
        self.all_students.insert(student_string.clone());
        self.roster
            .entry(grade)
            .or_default()
            .insert(student_string);
    }

    pub fn grades(&self) -> Vec<u32> {
        let mut grades: Vec<u32> = self.roster.keys().cloned().collect();
        grades.sort();
        grades
    }

    pub fn grade(&self, grade: u32) -> Vec<String> {
        self.roster
            .get(&grade)
            .map(|set| set.iter().cloned().collect())
            .unwrap_or_default()
    }
}