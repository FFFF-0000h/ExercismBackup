#include "meetup.h"
#include <stdexcept>

namespace meetup {

scheduler::scheduler(boost::gregorian::greg_month month, boost::gregorian::greg_year year)
    : month_(month), year_(year) {}

boost::gregorian::date scheduler::nth_weekday(boost::gregorian::greg_weekday wd, int n) const {
    using namespace boost::gregorian;
    date first_of_month(year_, month_, 1);
    greg_weekday first_wd = first_of_month.day_of_week();
    int days_until = (wd.as_enum() - first_wd.as_enum() + 7) % 7;
    date first_occ = first_of_month + days(days_until);

    if (n >= 1 && n <= 4) {
        return first_occ + days((n - 1) * 7);
    } else if (n == 0) {          // teenth
        while (first_occ.day() < 13) {
            first_occ += days(7);
        }
        return first_occ;
    } else if (n == -1) {         // last
        date last_day = first_of_month.end_of_month();
        while (last_day.day_of_week() != wd) {
            last_day -= days(1);
        }
        return last_day;
    } else {
        throw std::invalid_argument("Invalid nth");
    }
}

boost::gregorian::date scheduler::monteenth()   const { return nth_weekday(boost::gregorian::Monday,    0); }
boost::gregorian::date scheduler::tuesteenth()   const { return nth_weekday(boost::gregorian::Tuesday,   0); }
boost::gregorian::date scheduler::wednesteenth() const { return nth_weekday(boost::gregorian::Wednesday, 0); }
boost::gregorian::date scheduler::thursteenth()  const { return nth_weekday(boost::gregorian::Thursday,  0); }
boost::gregorian::date scheduler::friteenth()    const { return nth_weekday(boost::gregorian::Friday,    0); }
boost::gregorian::date scheduler::saturteenth()  const { return nth_weekday(boost::gregorian::Saturday,  0); }
boost::gregorian::date scheduler::sunteenth()    const { return nth_weekday(boost::gregorian::Sunday,    0); }

boost::gregorian::date scheduler::first_monday()    const { return nth_weekday(boost::gregorian::Monday,    1); }
boost::gregorian::date scheduler::first_tuesday()   const { return nth_weekday(boost::gregorian::Tuesday,   1); }
boost::gregorian::date scheduler::first_wednesday() const { return nth_weekday(boost::gregorian::Wednesday, 1); }
boost::gregorian::date scheduler::first_thursday()  const { return nth_weekday(boost::gregorian::Thursday,  1); }
boost::gregorian::date scheduler::first_friday()    const { return nth_weekday(boost::gregorian::Friday,    1); }
boost::gregorian::date scheduler::first_saturday()  const { return nth_weekday(boost::gregorian::Saturday,  1); }
boost::gregorian::date scheduler::first_sunday()    const { return nth_weekday(boost::gregorian::Sunday,    1); }

boost::gregorian::date scheduler::second_monday()    const { return nth_weekday(boost::gregorian::Monday,    2); }
boost::gregorian::date scheduler::second_tuesday()   const { return nth_weekday(boost::gregorian::Tuesday,   2); }
boost::gregorian::date scheduler::second_wednesday() const { return nth_weekday(boost::gregorian::Wednesday, 2); }
boost::gregorian::date scheduler::second_thursday()  const { return nth_weekday(boost::gregorian::Thursday,  2); }
boost::gregorian::date scheduler::second_friday()    const { return nth_weekday(boost::gregorian::Friday,    2); }
boost::gregorian::date scheduler::second_saturday()  const { return nth_weekday(boost::gregorian::Saturday,  2); }
boost::gregorian::date scheduler::second_sunday()    const { return nth_weekday(boost::gregorian::Sunday,    2); }

boost::gregorian::date scheduler::third_monday()    const { return nth_weekday(boost::gregorian::Monday,    3); }
boost::gregorian::date scheduler::third_tuesday()   const { return nth_weekday(boost::gregorian::Tuesday,   3); }
boost::gregorian::date scheduler::third_wednesday() const { return nth_weekday(boost::gregorian::Wednesday, 3); }
boost::gregorian::date scheduler::third_thursday()  const { return nth_weekday(boost::gregorian::Thursday,  3); }
boost::gregorian::date scheduler::third_friday()    const { return nth_weekday(boost::gregorian::Friday,    3); }
boost::gregorian::date scheduler::third_saturday()  const { return nth_weekday(boost::gregorian::Saturday,  3); }
boost::gregorian::date scheduler::third_sunday()    const { return nth_weekday(boost::gregorian::Sunday,    3); }

boost::gregorian::date scheduler::fourth_monday()    const { return nth_weekday(boost::gregorian::Monday,    4); }
boost::gregorian::date scheduler::fourth_tuesday()   const { return nth_weekday(boost::gregorian::Tuesday,   4); }
boost::gregorian::date scheduler::fourth_wednesday() const { return nth_weekday(boost::gregorian::Wednesday, 4); }
boost::gregorian::date scheduler::fourth_thursday()  const { return nth_weekday(boost::gregorian::Thursday,  4); }
boost::gregorian::date scheduler::fourth_friday()    const { return nth_weekday(boost::gregorian::Friday,    4); }
boost::gregorian::date scheduler::fourth_saturday()  const { return nth_weekday(boost::gregorian::Saturday,  4); }
boost::gregorian::date scheduler::fourth_sunday()    const { return nth_weekday(boost::gregorian::Sunday,    4); }

boost::gregorian::date scheduler::last_monday()    const { return nth_weekday(boost::gregorian::Monday,    -1); }
boost::gregorian::date scheduler::last_tuesday()   const { return nth_weekday(boost::gregorian::Tuesday,   -1); }
boost::gregorian::date scheduler::last_wednesday() const { return nth_weekday(boost::gregorian::Wednesday, -1); }
boost::gregorian::date scheduler::last_thursday()  const { return nth_weekday(boost::gregorian::Thursday,  -1); }
boost::gregorian::date scheduler::last_friday()    const { return nth_weekday(boost::gregorian::Friday,    -1); }
boost::gregorian::date scheduler::last_saturday()  const { return nth_weekday(boost::gregorian::Saturday,  -1); }
boost::gregorian::date scheduler::last_sunday()    const { return nth_weekday(boost::gregorian::Sunday,    -1); }

} // namespace meetup