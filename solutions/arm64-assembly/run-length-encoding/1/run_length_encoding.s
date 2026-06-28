.text
.globl encode
.globl decode

// void encode(char *buffer, const char *string);
// x0 = buffer (output), x1 = string (input)
encode:
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp
    stp     x19, x20, [sp, #-16]!

    mov     x19, x1              // input string
    mov     x20, x0              // output buffer

    ldrb    w2, [x19]            // current character
    cbz     w2, .Lenc_empty

    mov     w3, #1               // count
    add     x19, x19, #1

.Lenc_loop:
    ldrb    w4, [x19]            // next character
    cmp     w4, w2
    b.ne    .Lenc_flush

    add     w3, w3, #1
    add     x19, x19, #1
    b       .Lenc_loop

.Lenc_flush:
    cmp     w3, #1
    b.le    .Lenc_single

    // Write count
    mov     w5, w3
    sub     sp, sp, #16
    mov     x6, sp               // use x6 for comparison
    mov     x7, sp
.Lenc_count_loop:
    mov     w8, #10
    udiv    w9, w5, w8
    msub    w10, w9, w8, w5
    add     w10, w10, #'0'
    strb    w10, [x7], #1
    mov     w5, w9
    cbnz    w5, .Lenc_count_loop

    sub     x7, x7, #1
.Lenc_write_digits:
    ldrb    w10, [x7], #-1
    strb    w10, [x20], #1
    cmp     x7, x6
    b.ge    .Lenc_write_digits
    add     sp, sp, #16

.Lenc_single:
    strb    w2, [x20], #1
    cbz     w4, .Lenc_terminate
    mov     w2, w4
    mov     w3, #1
    add     x19, x19, #1
    b       .Lenc_loop

.Lenc_terminate:
    strb    wzr, [x20]
    b       .Lenc_exit

.Lenc_empty:
    strb    wzr, [x20]

.Lenc_exit:
    ldp     x19, x20, [sp], #16
    ldp     x29, x30, [sp], #16
    ret


// void decode(char *buffer, const char *string);
// x0 = buffer (output), x1 = string (input)
decode:
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp
    stp     x19, x20, [sp, #-16]!

    mov     x19, x1              // input string
    mov     x20, x0              // output buffer
    mov     w2, #0               // current count

.Ldec_loop:
    ldrb    w3, [x19]
    cbz     w3, .Ldec_done

    cmp     w3, #'0'
    b.lt    .Ldec_letter
    cmp     w3, #'9'
    b.gt    .Ldec_letter

    sub     w3, w3, #'0'
    mov     w4, #10
    mul     w2, w2, w4
    add     w2, w2, w3
    add     x19, x19, #1
    b       .Ldec_loop

.Ldec_letter:
    cmp     w2, #0
    b.ne    .Ldec_write
    mov     w2, #1

.Ldec_write:
    strb    w3, [x20], #1
    sub     w2, w2, #1
    cbnz    w2, .Ldec_write

    mov     w2, #0
    add     x19, x19, #1
    b       .Ldec_loop

.Ldec_done:
    strb    wzr, [x20]

    ldp     x19, x20, [sp], #16
    ldp     x29, x30, [sp], #16
    ret