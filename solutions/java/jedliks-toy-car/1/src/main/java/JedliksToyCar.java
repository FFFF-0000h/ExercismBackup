public class JedliksToyCar {
    private int distance;
    private int battery;

    public JedliksToyCar() {
        this.distance = 0;
        this.battery = 100;
    }

    public static JedliksToyCar buy() {
        return new JedliksToyCar();
    }

    public String distanceDisplay() {
        return "Driven " + distance + " meters";
    }

    public String batteryDisplay() {
        if (battery == 0) {
            return "Battery empty";
        }
        return "Battery at " + battery + "%";
    }

    public void drive() {
        if (battery > 0) {
            distance += 20;
            battery--;
        }
    }
}