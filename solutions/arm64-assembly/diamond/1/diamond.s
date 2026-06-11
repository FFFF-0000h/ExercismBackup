.text
.globl rows

rows:
    // Save frame and callee-saved registers
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp
    stp     x19, x20, [sp, #-16]!
    stp     x21, x22, [sp, #-16]!
    stp     x23, x24, [sp, #-16]!

    // x0 = buffer, w1 = letter
    mov     x19, x0                 // buffer pointer
    sub     w20, w1, #'A'           // n = letter - 'A'
    cbz     w20, .Lsingle_a

    // width = 2*n + 1 = number of rows
    mov     w21, #2
    mul     w21, w20, w21
    add     w21, w21, #1            // w21 = rows = width
    mov     w22, w21                // w22 = width

    // Allocate temporary row buffer on stack (64 bytes, sufficient for up to 51 chars)
    sub     sp, sp, #64
    mov     x9, sp                  // x9 = row buffer

    mov     w23, #0                 // i = 0
.Lloop:
    cmp     w23, w21
    b.ge    .Ldone

    // dist = i <= n ? i : 2*n - i
    cmp     w23, w20
    b.le    .Ldist_i
    mov     w24, #2
    mul     w24, w20, w24           // 2*n
    sub     w24, w24, w23           // dist = 2*n - i
    b       .Ldist_done
.Ldist_i:
    mov     w24, w23                // dist = i
.Ldist_done:

    add     w25, w24, #'A'          // character for this row
    sub     w26, w20, w24           // left  = n - dist
    add     w27, w20, w24           // right = n + dist

    // Fill row buffer with spaces
    mov     w10, #' '
    mov     x11, x9
    mov     w12, w22
    mov     w13, #0
.Lfill:
    cmp     w13, w12
    b.ge    .Lfill_done
    strb    w10, [x11, w13, uxtw #0]
    add     w13, w13, #1
    b       .Lfill
.Lfill_done:

    // Place the letter(s)
    strb    w25, [x9, w26, uxtw #0]   // left letter
    cmp     w26, w27
    b.eq    .Lskip_right
    strb    w25, [x9, w27, uxtw #0]   // right letter
.Lskip_right:

    // Copy row to output buffer and append newline
    mov     x10, x19               // destination
    mov     x11, x9                // source
    mov     w12, w22               // count
    mov     w13, #0
.Lcopy:
    cmp     w13, w12
    b.ge    .Lcopy_done
    ldrb    w14, [x11, w13, uxtw #0]
    strb    w14, [x10, w13, uxtw #0]
    add     w13, w13, #1
    b       .Lcopy
.Lcopy_done:

    add     x19, x19, w22, uxtw    // advance output pointer by width
    mov     w14, #'\n'
    strb    w14, [x19], #1         // add newline

    add     w23, w23, #1
    b       .Lloop

.Ldone:
    mov     w10, #0
    strb    w10, [x19]              // null-terminate
    add     sp, sp, #64             // free row buffer

    ldp     x23, x24, [sp], #16
    ldp     x21, x22, [sp], #16
    ldp     x19, x20, [sp], #16
    ldp     x29, x30, [sp], #16
    ret

.Lsingle_a:
    mov     w10, #'A'
    strb    w10, [x19]
    mov     w10, #'\n'
    strb    w10, [x19, #1]
    mov     w10, #0
    strb    w10, [x19, #2]

    ldp     x23, x24, [sp], #16
    ldp     x21, x22, [sp], #16
    ldp     x19, x20, [sp], #16
    ldp     x29, x30, [sp], #16
    ret