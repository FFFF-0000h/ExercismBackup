.equ INVALID_CHARACTER, -1
.equ NEGATIVE_SPAN, -2
.equ INSUFFICIENT_DIGITS, -3

.text
.globl largest_product

// int64_t largest_product(int span, const char *digits);
// w0 = span, x1 = digits string
largest_product:
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp
    stp     x19, x20, [sp, #-16]!
    stp     x21, x22, [sp, #-16]!
    stp     x23, x24, [sp, #-16]!

    mov     w19, w0               // span
    mov     x20, x1               // digits string

    // Check for negative span
    cmp     w19, #0
    b.lt    .Lnegative_span

    // Compute length of digits
    mov     x0, x20
    bl      strlen_asm
    mov     w21, w0               // length

    // If span == 0, return 1 (empty product)
    cbz     w19, .Lempty_product

    // If span > length, insufficient digits
    cmp     w19, w21
    b.gt    .Linsufficient_digits

    // Check for invalid characters
    mov     w22, #0               // i = 0
.Lvalidate_loop:
    cmp     w22, w21
    b.ge    .Lcompute
    ldrb    w23, [x20, w22, uxtw]
    cmp     w23, #'0'
    b.lt    .Linvalid_char
    cmp     w23, #'9'
    b.gt    .Linvalid_char
    add     w22, w22, #1
    b       .Lvalidate_loop

.Lcompute:
    mov     x22, #0               // max product = 0
    mov     w23, #0               // i = 0

.Louter_loop:
    sub     w24, w21, w19          // length - span
    cmp     w23, w24
    b.gt    .Ldone

    mov     x25, #1               // current product = 1
    mov     w26, #0               // j = 0

.Linner_loop:
    cmp     w26, w19
    b.ge    .Lcheck_max

    add     x27, x20, x23
    ldrb    w28, [x27, w26, uxtw]
    sub     w28, w28, #'0'
    mul     x25, x25, x28

    add     w26, w26, #1
    b       .Linner_loop

.Lcheck_max:
    cmp     x25, x22
    csel    x22, x25, x22, gt

    add     w23, w23, #1
    b       .Louter_loop

.Ldone:
    mov     x0, x22
    b       .Lexit

.Lempty_product:
    mov     x0, #1
    b       .Lexit

.Linvalid_char:
    mov     x0, #INVALID_CHARACTER
    b       .Lexit

.Lnegative_span:
    mov     x0, #NEGATIVE_SPAN
    b       .Lexit

.Linsufficient_digits:
    mov     x0, #INSUFFICIENT_DIGITS

.Lexit:
    ldp     x23, x24, [sp], #16
    ldp     x21, x22, [sp], #16
    ldp     x19, x20, [sp], #16
    ldp     x29, x30, [sp], #16
    ret

// Simple strlen implementation
strlen_asm:
    mov     x1, x0
.Lstrlen_loop:
    ldrb    w2, [x1], #1
    cbnz    w2, .Lstrlen_loop
    sub     x0, x1, x0
    sub     x0, x0, #1
    ret