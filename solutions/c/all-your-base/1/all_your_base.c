#include "all_your_base.h"
#include <stdlib.h>   // for malloc, free

size_t rebase(int8_t *digits, int16_t input_base, int16_t output_base,
              size_t input_length)
{
    // Validate bases
    if (input_base < 2 || output_base < 2)
        return 0;

    // Input must contain at least one digit
    if (input_length == 0)
        return 0;

    // Validate each digit
    for (size_t i = 0; i < input_length; i++) {
        if (digits[i] < 0 || digits[i] >= input_base)
            return 0;
    }

    // Special case: the number is zero
    int all_zero = 1;
    for (size_t i = 0; i < input_length; i++) {
        if (digits[i] != 0) {
            all_zero = 0;
            break;
        }
    }
    if (all_zero) {
        digits[0] = 0;
        return 1;
    }

    // Create a working copy of the input digits (as plain ints for arithmetic)
    int *work = malloc(input_length * sizeof(int));
    if (work == NULL)
        return 0;   // allocation failure

    for (size_t i = 0; i < input_length; i++) {
        work[i] = digits[i];
    }
    size_t work_len = input_length;

    // Buffer for the result digits (least significant first)
    int8_t result[DIGITS_ARRAY_SIZE];
    size_t out_idx = 0;

    // Repeatedly divide the number by output_base to obtain the new digits
    while (work_len > 0) {
        int remainder = 0;

        // Perform one division step on the whole big number
        for (size_t i = 0; i < work_len; i++) {
            int current = remainder * input_base + work[i];
            work[i] = current / output_base;
            remainder = current % output_base;
        }

        // The remainder is the next output digit (least significant)
        if (out_idx >= DIGITS_ARRAY_SIZE) {
            free(work);
            return 0;   // output buffer too small
        }
        result[out_idx++] = (int8_t)remainder;

        // Remove leading zeros from the quotient to get the new length
        size_t new_start = 0;
        while (new_start < work_len && work[new_start] == 0) {
            new_start++;
        }
        if (new_start < work_len) {
            // Shift the remaining digits to the front
            for (size_t i = new_start; i < work_len; i++) {
                work[i - new_start] = work[i];
            }
            work_len -= new_start;
        } else {
            // The quotient became zero
            work_len = 0;
        }
    }

    free(work);

    // The digits we collected are in reverse order (least significant first).
    // Reverse them to get the correct most‑significant‑first order.
    for (size_t i = 0; i < out_idx / 2; i++) {
        int8_t tmp = result[i];
        result[i] = result[out_idx - 1 - i];
        result[out_idx - 1 - i] = tmp;
    }

    // Copy the result back into the input/output array
    for (size_t i = 0; i < out_idx; i++) {
        digits[i] = result[i];
    }

    return out_idx;
}