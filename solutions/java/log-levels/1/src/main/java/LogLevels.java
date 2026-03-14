public class LogLevels {

    public static String message(String logLine) {
        int colonIndex = logLine.indexOf(":");
        // Extract after the colon and trim whitespace (including \r, \n, etc.)
        return logLine.substring(colonIndex + 1).trim();
    }

    public static String logLevel(String logLine) {
        int start = logLine.indexOf("[") + 1;
        int end = logLine.indexOf("]");
        // Extract the level and convert to lowercase
        return logLine.substring(start, end).toLowerCase();
    }

    public static String reformat(String logLine) {
        String msg = message(logLine);
        String lvl = logLevel(logLine);
        return msg + " (" + lvl + ")";
    }
}