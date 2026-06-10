class NeedForSpeed {
    private int speed;
    private int batteryDrain;
    private int distanceDriven;

    NeedForSpeed(int speed, int batteryDrain) {
        this.speed = speed;
        this.batteryDrain = batteryDrain;
        this.distanceDriven = 0;
    }

    public boolean batteryDrained() {
        int drivesDone = distanceDriven / speed;
        return 100 - drivesDone * batteryDrain < batteryDrain;
    }

    public int distanceDriven() {
        return distanceDriven;
    }

    public void drive() {
        int drivesDone = distanceDriven / speed;
        if (100 - drivesDone * batteryDrain >= batteryDrain) {
            distanceDriven += speed;
        }
    }

    public static NeedForSpeed nitro() {
        return new NeedForSpeed(50, 4);
    }

    public int getSpeed() {
        return speed;
    }

    public int getBatteryDrain() {
        return batteryDrain;
    }
}

class RaceTrack {
    private int distance;

    RaceTrack(int distance) {
        this.distance = distance;
    }

    public boolean canFinishRace(NeedForSpeed car) {
        int remaining = distance - car.distanceDriven();
        if (remaining <= 0) {
            return true;
        }
        int drivesNeeded = (remaining + car.getSpeed() - 1) / car.getSpeed();
        int totalDrives = car.distanceDriven() / car.getSpeed() + drivesNeeded;
        return totalDrives * car.getBatteryDrain() <= 100;
    }
}