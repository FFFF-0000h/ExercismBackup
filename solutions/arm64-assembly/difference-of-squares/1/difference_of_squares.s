.text
.globl square_of_sum
.globl sum_of_squares
.globl difference_of_squares

// x0 = N
square_of_sum:
    // sum = N*(N+1)/2
    add     x1, x0, #1          // x1 = N+1
    mul     x1, x0, x1          // x1 = N*(N+1)
    lsr     x1, x1, #1          // x1 = N*(N+1)/2
    mul     x0, x1, x1          // x0 = [N*(N+1)/2]^2
    ret

// x0 = N
sum_of_squares:
    // N*(N+1)*(2N+1)/6
    add     x1, x0, #1          // x1 = N+1
    mul     x1, x0, x1          // x1 = N*(N+1)
    lsl     x2, x0, #1          // x2 = 2N
    add     x2, x2, #1          // x2 = 2N+1
    mul     x1, x1, x2          // x1 = N*(N+1)*(2N+1)
    
    // Divide by 6
    mov     x2, #6
    udiv    x0, x1, x2          // x0 = N*(N+1)*(2N+1)/6
    ret

// x0 = N
difference_of_squares:
    stp     x29, x30, [sp, #-16]!  // Save frame pointer and link register
    mov     x29, sp
    
    // Save N in callee-saved register
    mov     x19, x0
    
    bl      square_of_sum       // x0 = square_of_sum(N)
    mov     x20, x0             // Save result in x20
    
    mov     x0, x19             // Restore N
    bl      sum_of_squares      // x0 = sum_of_squares(N)
    
    sub     x0, x20, x0         // difference = square_of_sum - sum_of_squares
    
    ldp     x29, x30, [sp], #16    // Restore frame pointer and link register
    ret