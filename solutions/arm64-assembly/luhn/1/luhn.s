.text
.globl valid

// int valid(const char *str);
// x0 = input string
// Returns 1 if valid Luhn, 0 otherwise
valid:
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp
    stp     x19, x20, [sp, #-16]!
    stp     x21, x22, [sp, #-16]!

    mov     x19, x0               // input string
    mov     x20, #0               // digit count
    mov     x21, #0               // total sum

    // First pass: count digits and compute length
    mov     x0, x19
    bl      strlen
    mov     x22, x0               // total characters

    // Process from right to left
    mov     x0, x19
    add     x0, x0, x22
    sub     x0, x0, #1            // point to last character
    mov     x1, #0                // position from right (0-based)

.loop:
    cmp     x0, x19
    b.lt    .done                  // passed the start

    ldrb    w2, [x0]              // current character

    // If space, skip it
    cmp     w2, #' '
    b.eq    .next_char

    // Check if digit
    cmp     w2, #'0'
    b.lt    .invalid
    cmp     w2, #'9'
    b.gt    .invalid

    sub     w2, w2, #'0'          // convert to integer
    add     x20, x20, #1          // increment digit count

    // If position is odd (1, 3, 5, ...), double it
    tst     x1, #1
    b.eq    .add_to_sum

    lsl     w2, w2, #1             // double
    cmp     w2, #9
    b.le    .add_to_sum
    sub     w2, w2, #9            // subtract 9 if > 9

.add_to_sum:
    add     x21, x21, x2

    add     x1, x1, #1            // next position
.next_char:
    sub     x0, x0, #1            // move left
    b       .loop

.done:
    // Must have at least 2 digits
    cmp     x20, #2
    b.lt    .invalid

    // Sum must be divisible by 10
    mov     w0, #10
    sdiv    w1, w21, w0
    msub    w2, w1, w0, w21       // remainder = w21 % 10
    cmp     w2, #0
    b.ne    .invalid

    mov     w0, #1                // valid
    b       .exit

.invalid:
    mov     w0, #0                // invalid

.exit:
    ldp     x21, x22, [sp], #16
    ldp     x19, x20, [sp], #16
    ldp     x29, x30, [sp], #16
    ret

// Simple strlen
strlen:
    mov     x1, x0
.strlen_loop:
    ldrb    w2, [x1], #1
    cbnz    w2, .strlen_loop
    sub     x0, x1, x0
    sub     x0, x0, #1
    ret