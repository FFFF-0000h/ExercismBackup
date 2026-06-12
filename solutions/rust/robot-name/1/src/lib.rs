use rand::Rng;
use rand::RngExt;
use rand::distr::Uniform;
use std::cell::RefCell;
use std::collections::HashSet;
use std::rc::Rc;

pub struct RobotFactory {
    used_names: Rc<RefCell<HashSet<String>>>,
}

pub struct Robot {
    name: String,
    used_names: Rc<RefCell<HashSet<String>>>,
}

impl RobotFactory {
    pub fn new() -> Self {
        RobotFactory {
            used_names: Rc::new(RefCell::new(HashSet::new())),
        }
    }

    pub fn new_robot<R: Rng>(&mut self, rng: &mut R) -> Robot {
        let name = Self::generate_unique_name(&self.used_names, rng);
        Robot {
            name,
            used_names: Rc::clone(&self.used_names),
        }
    }

    fn generate_unique_name<R: Rng>(
        used_names: &Rc<RefCell<HashSet<String>>>,
        rng: &mut R,
    ) -> String {
        let letter_dist = Uniform::new_inclusive(b'A', b'Z').unwrap();
        let digit_dist = Uniform::new_inclusive(0, 9).unwrap();
        loop {
            let name = format!(
                "{}{}{}{}{}",
                rng.sample(&letter_dist) as char,
                rng.sample(&letter_dist) as char,
                rng.sample(&digit_dist),
                rng.sample(&digit_dist),
                rng.sample(&digit_dist),
            );
            if used_names.borrow_mut().insert(name.clone()) {
                return name;
            }
        }
    }
}

impl Robot {
    pub fn name(&self) -> &str {
        &self.name
    }

    pub fn reset<R: Rng>(&mut self, rng: &mut R) {
        self.used_names.borrow_mut().remove(&self.name);
        self.name = RobotFactory::generate_unique_name(&self.used_names, rng);
    }
}