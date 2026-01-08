// @ts-check

/**
 * Create an appointment
 *
 * @param {number} days
 * @param {number} [now] (ms since the epoch, or undefined)
 *
 * @returns {Date} the appointment
 */
export function createAppointment(days, now = undefined) {
  // If now is provided, use it. Otherwise, get current time in ms
  const currentTime = now !== undefined ? now : Date.now();
  
  // Create date from the time in ms
  const appointmentTime = currentTime + (days * 24 * 60 * 60 * 1000);
  
  return new Date(appointmentTime);
}

/**
 * Generate the appointment timestamp
 *
 * @param {Date} appointmentDate
 *
 * @returns {string} timestamp
 */
export function getAppointmentTimestamp(appointmentDate) {
  return appointmentDate.toISOString();
}

/**
 * Get details of an appointment
 *
 * @param {string} timestamp (ISO 8601)
 *
 * @returns {Record<'year' | 'month' | 'date' | 'hour' | 'minute', number>} the appointment details
 */
export function getAppointmentDetails(timestamp) {
  const date = new Date(timestamp);
  
  return {
    year: date.getUTCFullYear(),
    month: date.getUTCMonth(),  // 0-indexed
    date: date.getUTCDate(),
    hour: date.getUTCHours(),
    minute: date.getUTCMinutes()
  };
}

/**
 * Update an appointment with given options
 *
 * @param {string} timestamp (ISO 8601)
 * @param {Partial<Record<'year' | 'month' | 'date' | 'hour' | 'minute', number>>} options
 *
 * @returns {Record<'year' | 'month' | 'date' | 'hour' | 'minute', number>} the appointment details
 */
export function updateAppointment(timestamp, options) {
  const date = new Date(timestamp);
  
  // Update with UTC methods to avoid timezone issues
  if (options.year !== undefined) {
    date.setUTCFullYear(options.year);
  }
  if (options.month !== undefined) {
    date.setUTCMonth(options.month);
  }
  if (options.date !== undefined) {
    date.setUTCDate(options.date);
  }
  if (options.hour !== undefined) {
    date.setUTCHours(options.hour);
  }
  if (options.minute !== undefined) {
    date.setUTCMinutes(options.minute);
  }
  
  return {
    year: date.getUTCFullYear(),
    month: date.getUTCMonth(),
    date: date.getUTCDate(),
    hour: date.getUTCHours(),
    minute: date.getUTCMinutes()
  };
}

/**
 * Get available time in seconds (rounded) between two appointments
 *
 * @param {string} timestampA (ISO 8601)
 * @param {string} timestampB (ISO 8601)
 *
 * @returns {number} amount of seconds (rounded)
 */
export function timeBetween(timestampA, timestampB) {
  const dateA = new Date(timestampA);
  const dateB = new Date(timestampB);
  
  const diffMs = Math.abs(dateB.getTime() - dateA.getTime());
  return Math.round(diffMs / 1000);
}

/**
 * Get available times between two appointment
 *
 * @param {string} appointmentTimestamp (ISO 8601)
 * @param {string} currentTimestamp (ISO 8601)
 */
export function isValid(appointmentTimestamp, currentTimestamp) {
  const appointmentDate = new Date(appointmentTimestamp);
  const currentDate = new Date(currentTimestamp);
  
  return appointmentDate > currentDate;
}