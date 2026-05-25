.arch armv8-a
.text
.globl rebase
rebase:
    stp     x29, x30, [sp, #-48]!
    mov     x29, sp
    stp     x19, x20, [sp, #16]
    stp     x21, x22, [sp, #32]

    // Arguments:
    //   w0  in_base
    //   x1  in_digits
    //   w2  in_digit_count
    //   w3  out_base
    //   x4  out_digits

    mov     x19, x1                 // x19 = in_digits
    mov     w20, w2                 // w20 = in_digit_count
    mov     x21, x3                 // x21 = out_base (zero‑extended)
    mov     x22, x4                 // x22 = out_digits

    // Validate input base
    cmp     w0, #2
    b.lt    bad_base

    // Validate output base
    cmp     w21, #2
    b.lt    bad_base

    // Handle empty input
    cbz     w20, empty_input

    // Convert input digits to a 64‑bit unsigned value
    mov     x23, #0                 // value = 0
    mov     x5, #0                  // index = 0
    mov     x6, x0                  // x6 = in_base (64 bits)
input_loop:
    // Load digit (sign‑extend 32‑bit to 64‑bit)
    ldrsw   x7, [x19, x5, lsl #2]   // x7 = in_digits[i]
    tbnz    x7, #63, bad_digit       // negative if bit 63 set
    cmp     w7, w6
    b.hs    bad_digit               // digit >= in_base (unsigned)

    // value = value * in_base + digit
    mul     x23, x23, x6
    add     x23, x23, x7

    add     x5, x5, #1
    cmp     w5, w20
    b.lo    input_loop

    b       convert_output

empty_input:
    // Output a single 0
    mov     w0, #0
    str     w0, [x22]
    mov     w0, #1
    b       done

convert_output:
    // value in x23, out_base in x21, out_digits in x22
    mov     x24, #0                 // output count = 0

    cbnz    x23, convert_loop

    // value == 0 -> output single 0
    str     wzr, [x22]
    mov     w0, #1
    b       done

convert_loop:
    // remainder = value % out_base, quotient = value / out_base
    udiv    x9, x23, x21
    msub    x10, x9, x21, x23       // x10 = value - (quotient * out_base) = remainder
    str     w10, [x22, x24, lsl #2]  // store remainder
    add     x24, x24, #1
    mov     x23, x9
    cbnz    x23, convert_loop

    // Reverse output digits in place
    mov     x5, #0                  // left = 0
    sub     x6, x24, #1             // right = count - 1
reverse_loop:
    cmp     x5, x6
    b.hs    reverse_done
    ldr     w7, [x22, x5, lsl #2]
    ldr     w8, [x22, x6, lsl #2]
    str     w8, [x22, x5, lsl #2]
    str     w7, [x22, x6, lsl #2]
    add     x5, x5, #1
    sub     x6, x6, #1
    b       reverse_loop

reverse_done:
    mov     w0, w24
    b       done

bad_base:
    mov     w0, #-1                 // BAD_BASE
    b       done

bad_digit:
    mov     w0, #-2                 // BAD_DIGIT

done:
    ldp     x21, x22, [sp, #32]
    ldp     x19, x20, [sp, #16]
    ldp     x29, x30, [sp], #48
    ret