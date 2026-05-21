// variable_length_quantity.c
#include "variable_length_quantity.h"
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

int encode(const uint32_t *integers, size_t integers_len, uint8_t *output)
{
    size_t out_pos = 0;
    for (size_t i = 0; i < integers_len; i++) {
        uint32_t num = integers[i];
        if (num == 0) {
            output[out_pos++] = 0;
            continue;
        }
        // Extract 7-bit groups (least significant first)
        uint8_t temp[5];
        int temp_len = 0;
        while (num > 0) {
            temp[temp_len++] = num & 0x7F;
            num >>= 7;
        }
        // Write in reverse (most significant first) with continuation bits
        for (int j = temp_len - 1; j >= 0; j--) {
            if (j == 0) {
                output[out_pos++] = temp[j];          // high bit 0
            } else {
                output[out_pos++] = temp[j] | 0x80;   // high bit 1
            }
        }
    }
    return (int)out_pos;
}

int decode(const uint8_t *bytes, size_t buffer_len, uint32_t *output)
{
    size_t out_pos = 0;
    bool in_progress = false;
    uint32_t value = 0;
    int bytes_used = 0;

    for (size_t i = 0; i < buffer_len; i++) {
        uint8_t byte = bytes[i];

        if (!in_progress) {
            value = 0;
            bytes_used = 0;
            in_progress = true;
        }

        // Overflow: more than 5 bytes for a single 32-bit value
        if (bytes_used >= 5) {
            return -1;
        }

        // Overflow: shifting left 7 bits would lose data
        if (value > (0xFFFFFFFF >> 7)) {
            return -1;
        }

        value = (value << 7) | (byte & 0x7F);
        bytes_used++;

        if (!(byte & 0x80)) {
            // Final byte of the current integer
            output[out_pos++] = value;
            in_progress = false;
        }
    }

    // Incomplete sequence at the end of input
    if (in_progress) {
        return -1;
    }

    return (int)out_pos;
}