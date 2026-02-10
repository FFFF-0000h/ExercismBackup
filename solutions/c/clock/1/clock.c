#include "clock.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

// Helper function to normalize time to 24-hour format
static void normalize_time(int *hour, int *minute) {
    // Handle minutes first
    *hour += *minute / 60;
    *minute = *minute % 60;
    
    // Handle negative minutes
    if (*minute < 0) {
        *hour -= 1;
        *minute += 60;
    }
    
    // Handle hours (wrap around 24)
    *hour = *hour % 24;
    
    // Handle negative hours
    if (*hour < 0) {
        *hour += 24;
    }
}

clock_t clock_create(int hour, int minute) {
    clock_t clock;
    
    // Normalize the input time
    normalize_time(&hour, &minute);
    
    // Format the time as "HH:MM"
    snprintf(clock.text, MAX_STR_LEN, "%02d:%02d", hour, minute);
    
    return clock;
}

clock_t clock_add(clock_t clock, int minute_add) {
    // Parse current time from clock.text
    int hour, minute;
    sscanf(clock.text, "%d:%d", &hour, &minute);
    
    // Add minutes and normalize
    minute += minute_add;
    normalize_time(&hour, &minute);
    
    // Create and return new clock
    return clock_create(hour, minute);
}

clock_t clock_subtract(clock_t clock, int minute_subtract) {
    // Parse current time from clock.text
    int hour, minute;
    sscanf(clock.text, "%d:%d", &hour, &minute);
    
    // Subtract minutes and normalize
    minute -= minute_subtract;
    normalize_time(&hour, &minute);
    
    // Create and return new clock
    return clock_create(hour, minute);
}

bool clock_is_equal(clock_t a, clock_t b) {
    // Compare the text representations
    return strcmp(a.text, b.text) == 0;
}