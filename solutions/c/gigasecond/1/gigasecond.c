#include "gigasecond.h"
#include <stdio.h>
#include <string.h>

void gigasecond(time_t input, char *output, size_t size) {
    // One gigasecond = 1,000,000,000 seconds
    const time_t GIGASECOND = 1000000000L;
    
    // Add one gigasecond to the input time
    time_t result_time = input + GIGASECOND;
    
    // Convert to UTC time using gmtime (not localtime)
    struct tm *utc_time = gmtime(&result_time);
    
    // Format the result as "YYYY-MM-DD HH:MM:SS"
    // Using strftime to ensure proper formatting
    strftime(output, size, "%Y-%m-%d %H:%M:%S", utc_time);
}