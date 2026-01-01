// INFO: Headers from the standard library should be inserted at the top via
// #include <LIBRARY_NAME>
#include <cmath> 

// daily_rate calculates the daily rate given an hourly rate
double daily_rate(double hourly_rate) {
     return hourly_rate * 8.0;
}

// apply_discount calculates the price after a discount
double apply_discount(double before_discount, double discount) {
    return before_discount * (1.0 - discount / 100.0);
}

// monthly_rate calculates the monthly rate, given an hourly rate and a discount
// The returned monthly rate is rounded up to the nearest integer.
int monthly_rate(double hourly_rate, double discount) {
    double daily = daily_rate(hourly_rate);
    double discounted_daily = apply_discount(daily, discount);
    double monthly = discounted_daily * 22.0;
    return static_cast<int>(std::ceil(monthly));
}

// days_in_budget calculates the number of workdays given a budget, hourly rate,
// and discount The returned number of days is rounded down (take the floor) to
// the next integer.
int days_in_budget(int budget, double hourly_rate, double discount) {
    double daily = daily_rate(hourly_rate);
    double discounted_daily = apply_discount(daily, discount);
    double days = static_cast<double>(budget) / discounted_daily;
    return static_cast<int>(std::floor(days));
}
