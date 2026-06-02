use std::collections::HashMap;

pub fn tally(match_results: &str) -> String {
    let mut teams: HashMap<&str, TeamStats> = HashMap::new();

    for line in match_results.lines() {
        if line.is_empty() {
            continue;
        }
        let parts: Vec<&str> = line.split(';').collect();
        if parts.len() != 3 {
            continue;
        }
        let team1 = parts[0];
        let team2 = parts[1];
        let result = parts[2];

        teams.entry(team1).or_default();
        teams.entry(team2).or_default();

        match result {
            "win" => {
                teams.get_mut(team1).unwrap().add_win();
                teams.get_mut(team2).unwrap().add_loss();
            }
            "loss" => {
                teams.get_mut(team2).unwrap().add_win();
                teams.get_mut(team1).unwrap().add_loss();
            }
            "draw" => {
                teams.get_mut(team1).unwrap().add_draw();
                teams.get_mut(team2).unwrap().add_draw();
            }
            _ => {}
        }
    }

    let mut team_vec: Vec<(&&str, &TeamStats)> = teams.iter().collect();
    // Sort by points descending, then by name ascending
    team_vec.sort_by(|a, b| {
        b.1.points()
            .cmp(&a.1.points())
            .then_with(|| a.0.cmp(b.0))
    });

    let mut output = format!(
        "{:30} | {:>2} | {:>2} | {:>2} | {:>2} | {:>2}",
        "Team", "MP", "W", "D", "L", "P"
    );

    for (name, stats) in team_vec {
        output.push_str(&format!(
            "\n{:30} | {:>2} | {:>2} | {:>2} | {:>2} | {:>2}",
            name,
            stats.mp,
            stats.wins,
            stats.draws,
            stats.losses,
            stats.points()
        ));
    }

    output
}

#[derive(Default)]
struct TeamStats {
    mp: u32,
    wins: u32,
    draws: u32,
    losses: u32,
}

impl TeamStats {
    fn add_win(&mut self) {
        self.mp += 1;
        self.wins += 1;
    }

    fn add_loss(&mut self) {
        self.mp += 1;
        self.losses += 1;
    }

    fn add_draw(&mut self) {
        self.mp += 1;
        self.draws += 1;
    }

    fn points(&self) -> u32 {
        self.wins * 3 + self.draws
    }
}