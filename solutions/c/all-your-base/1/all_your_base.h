#ifndef ALL_YOUR_BASE_H
#define ALL_YOUR_BASE_H

#include <stddef.h>   // for size_t
#include <stdint.h>   // for int8_t, int16_t

#define DIGITS_ARRAY_SIZE 64

/**
 * Convert a number given as a sequence of digits in one base to the same
 * number represented in another base.
 *
 * @param digits        Array of digits (most significant first) in `input_base`.
 *                      On return, this array will contain the result digits
 *                      (most significant first), provided the result fits.
 * @param input_base    Base of the input number (must be >= 2).
 * @param output_base   Base to convert to (must be >= 2).
 * @param input_length  Number of digits in the input array.
 * @return              Number of digits written to `digits` (the output length),
 *                      or 0 on error (invalid input, buffer too small, etc.).
 */
size_t rebase(int8_t *digits, int16_t input_base, int16_t output_base,
              size_t input_length);

#endif