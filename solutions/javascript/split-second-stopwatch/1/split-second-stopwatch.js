export class SplitSecondStopwatch {
  constructor() {
    this._status = 'ready';
    this._currentLapSecs = 0;
    this._completedLapsSecs = [];
  }

  get state() {
    return this._status;
  }

  get currentLap() {
    return this.#toTimeString(this._currentLapSecs);
  }

  get total() {
    const totalSecs = this._completedLapsSecs.reduce((sum, lap) => sum + lap, 0) + this._currentLapSecs;
    return this.#toTimeString(totalSecs);
  }

  get previousLaps() {
    return this._completedLapsSecs.map(lapSecs => this.#toTimeString(lapSecs));
  }

  start() {
    if (this._status === 'running') {
      throw new Error('cannot start an already running stopwatch');
    }
    this._status = 'running';
  }

  stop() {
    if (this._status !== 'running') {
      throw new Error('cannot stop a stopwatch that is not running');
    }
    this._status = 'stopped';
  }

  lap() {
    if (this._status !== 'running') {
      throw new Error('cannot lap a stopwatch that is not running');
    }
    this._completedLapsSecs.push(this._currentLapSecs);
    this._currentLapSecs = 0;
  }

  reset() {
    if (this._status !== 'stopped') {
      throw new Error('cannot reset a stopwatch that is not stopped');
    }
    this._status = 'ready';
    this._currentLapSecs = 0;
    this._completedLapsSecs = [];
  }

  advanceTime(duration) {
    if (this._status !== 'running') {
      return;
    }
    const secondsToAdd = this.#fromTimeString(duration);
    this._currentLapSecs += secondsToAdd;
  }

  #fromTimeString(timeString) {
    const [hours, minutes, seconds] = timeString.split(':').map(Number);
    return hours * 3600 + minutes * 60 + seconds;
  }

  #toTimeString(totalSeconds) {
    const hrs = Math.floor(totalSeconds / 3600);
    const mins = Math.floor((totalSeconds % 3600) / 60);
    const secs = totalSeconds % 60;
    return [hrs, mins, secs].map(part => String(part).padStart(2, '0')).join(':');
  }
}