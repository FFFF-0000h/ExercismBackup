// @ts-check

export class ArgumentError extends Error {}

export class OverheatingError extends Error {
  constructor(temperature) {
    super(`The temperature is ${temperature} ! Overheating !`);
    this.temperature = temperature;
  }
}

/**
 * Check if the humidity level is not too high.
 *
 * @param {number} humidityPercentage
 * @throws {Error}
 */
export function checkHumidityLevel(humidityPercentage) {
  if (humidityPercentage > 70) {
    throw new Error('Humidity level is too high!');
  }
  // If humidity is within acceptable range, do nothing (implicitly returns undefined)
}

/**
 * Check if the temperature is not too high.
 *
 * @param {number|null} temperature
 * @throws {ArgumentError|OverheatingError}
 */
export function reportOverheating(temperature) {
  if (temperature === null) {
    throw new ArgumentError('Sensor is broken!');
  }
  
  if (temperature > 500) {
    throw new OverheatingError(temperature);
  }
  
  // If temperature is valid and within acceptable range, do nothing
}

/**
 *  Triggers the needed action depending on the result of the machine check.
 *
 * @param {{
 * check: function,
 * alertDeadSensor: function,
 * alertOverheating: function,
 * shutdown: function
 * }} actions
 * @throws {ArgumentError|OverheatingError|Error}
 */
export function monitorTheMachine(actions) {
  try {
    // Call the check function which may throw errors
    actions.check();
  } catch (error) {
    // Handle ArgumentError (sensor broken)
    if (error instanceof ArgumentError) {
      actions.alertDeadSensor();
      return; // Return without rethrowing
    }
    
    // Handle OverheatingError
    if (error instanceof OverheatingError) {
      // Check temperature from the error object
      if (error.temperature > 600) {
        actions.shutdown();
      } else {
        actions.alertOverheating();
      }
      return; // Return without rethrowing
    }
    
    // For any other error, rethrow it
    throw error;
  }
  
  // If check() passes without throwing, function returns undefined
}