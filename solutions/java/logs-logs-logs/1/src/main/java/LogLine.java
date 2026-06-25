// LogLine.java
public class LogLine {
    private final String logLine;

    public LogLine(String logLine) {
        this.logLine = logLine;
    }

    public LogLevel getLogLevel() {
        int start = logLine.indexOf('[');
        int end = logLine.indexOf(']');
        if (start == -1 || end == -1) {
            return LogLevel.UNKNOWN;
        }

        String levelStr = logLine.substring(start + 1, end);
        switch (levelStr) {
            case "TRC": return LogLevel.TRACE;
            case "DBG": return LogLevel.DEBUG;
            case "INF": return LogLevel.INFO;
            case "WRN": return LogLevel.WARNING;
            case "ERR": return LogLevel.ERROR;
            case "FTL": return LogLevel.FATAL;
            default: return LogLevel.UNKNOWN;
        }
    }

    public String getOutputForShortLog() {
        LogLevel level = getLogLevel();
        int colonIndex = logLine.indexOf("]:");
        String message = "";
        if (colonIndex != -1) {
            // Skip "]: " (3 characters) to get the message without leading space
            message = logLine.substring(colonIndex + 3);
        }
        return level.getShortCode() + ":" + message;
    }
}