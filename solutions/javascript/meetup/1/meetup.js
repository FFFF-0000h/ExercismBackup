export const meetup = (year, month, descriptor, weekday) => {
  const days = {
    'Sunday': 0,
    'Monday': 1,
    'Tuesday': 2,
    'Wednesday': 3,
    'Thursday': 4,
    'Friday': 5,
    'Saturday': 6
  };

  const targetWeekday = days[weekday];
  const firstOfMonth = new Date(year, month - 1, 1);
  const firstDay = firstOfMonth.getDay(); // 0 = Sunday

  // Calculate the date of the first occurrence of the target weekday
  let firstDate = 1 + (targetWeekday - firstDay + 7) % 7;

  switch (descriptor) {
    case 'first':
      return new Date(year, month - 1, firstDate);
    case 'second':
      return new Date(year, month - 1, firstDate + 7);
    case 'third':
      return new Date(year, month - 1, firstDate + 14);
    case 'fourth':
      return new Date(year, month - 1, firstDate + 21);
    case 'last': {
      const lastDayOfMonth = new Date(year, month, 0).getDate();
      let lastDate = firstDate;
      while (lastDate + 7 <= lastDayOfMonth) {
        lastDate += 7;
      }
      return new Date(year, month - 1, lastDate);
    }
    case 'teenth': {
      for (let date = 13; date <= 19; date++) {
        if (new Date(year, month - 1, date).getDay() === targetWeekday) {
          return new Date(year, month - 1, date);
        }
      }
    }
  }
};