namespace hellmath {

// Task 1 - Define enumerations
enum class AccountStatus {
    troll,
    guest, 
    user,
    mod
};

enum class Action {
    read,
    write,
    remove
};

// Task 2 - Implement display_post function
bool display_post(AccountStatus poster, AccountStatus viewer) {
    // Trolls can only see posts from other trolls
    if (poster == AccountStatus::troll) {
        return viewer == AccountStatus::troll;
    }
    // Everyone else can see non-troll posts
    return true;
}

// Task 3 - Implement permission_check function
bool permission_check(Action action, AccountStatus account) {
    switch (account) {
        case AccountStatus::guest:
            // Guests can only read
            return action == Action::read;
            
        case AccountStatus::user:
        case AccountStatus::troll:
            // Users and trolls can read and write
            return action == Action::read || action == Action::write;
            
        case AccountStatus::mod:
            // Moderators can do everything
            return true;
            
        default:
            return false;
    }
}

// Task 4 - Implement valid_player_combination function
bool valid_player_combination(AccountStatus player1, AccountStatus player2) {
    // Guests cannot play
    if (player1 == AccountStatus::guest || player2 == AccountStatus::guest) {
        return false;
    }
    
    // Trolls can only play with other trolls
    if (player1 == AccountStatus::troll || player2 == AccountStatus::troll) {
        return player1 == AccountStatus::troll && player2 == AccountStatus::troll;
    }
    
    // All other combinations are valid
    return true;
}

// Task 5 - Implement has_priority function
bool has_priority(AccountStatus account1, AccountStatus account2) {
    // Priority order: mod > user > guest > troll
    // Convert to integers for comparison
    auto priority = [](AccountStatus status) -> int {
        switch (status) {
            case AccountStatus::mod: return 3;
            case AccountStatus::user: return 2;
            case AccountStatus::guest: return 1;
            case AccountStatus::troll: return 0;
            default: return -1;
        }
    };
    
    return priority(account1) > priority(account2);
}

}  // namespace hellmath