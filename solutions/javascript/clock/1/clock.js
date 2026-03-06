//
// This is only a SKELETON file for the 'Clock' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class Clock {
  constructor(hour, minute = 0) {
    this.totalMinutes = this._normalize(hour, minute);
  }

  _normalize(hour, minute) {
    const total = hour * 60 + minute;
    const minutesPerDay = 24 * 60;
    return ((total % minutesPerDay) + minutesPerDay) % minutesPerDay;
  }

  toString() {
    const hours = Math.floor(this.totalMinutes / 60);
    const minutes = this.totalMinutes % 60;
    return `${hours.toString().padStart(2, '0')}:${minutes.toString().padStart(2, '0')}`;
  }

  plus(minutes) {
    return new Clock(0, this.totalMinutes + minutes);
  }

  minus(minutes) {
    return this.plus(-minutes);
  }

  equals(other) {
    return this.totalMinutes === other.totalMinutes;
  }
}