#include <cmath>

// interest_rate returns the interest rate for the provided balance.
double interest_rate(double balance) {
    if (balance < 0.0) {
        return 3.213;  // 3.213% for negative balance
    } else if (balance < 1000.0) {
        return 0.5;    // 0.5% for balance 0 to 999.99
    } else if (balance < 5000.0) {
        return 1.621;  // 1.621% for balance 1000 to 4999.99
    } else {
        return 2.475;  // 2.475% for balance 5000+
    }
}

// yearly_interest calculates the yearly interest for the provided balance.
double yearly_interest(double balance) {
    double rate = interest_rate(balance);
    return balance * (rate / 100.0);
}

// annual_balance_update calculates the annual balance update, taking into
// account the interest rate.
double annual_balance_update(double balance) {
    return balance + yearly_interest(balance);
}

// years_until_desired_balance calculates the minimum number of years required
// to reach the desired balance.
int years_until_desired_balance(double balance, double target_balance) {
    if (balance >= target_balance) {
        return 0;
    }
    
    int years = 0;
    double current_balance = balance;
    
    while (current_balance < target_balance) {
        current_balance = annual_balance_update(current_balance);
        years++;
    }
    
    return years;
}