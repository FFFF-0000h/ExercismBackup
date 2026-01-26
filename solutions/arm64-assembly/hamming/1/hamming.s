// hamming.s - Calculate Hamming distance between two DNA strings
.equ UNEQUAL_LENGTHS, -1

.text
.globl distance

// distance(const char *strand_a, const char *strand_b) -> int
// Arguments:
//   x0: pointer to first DNA strand (null-terminated)
//   x1: pointer to second DNA strand (null-terminated)
// Returns:
//   w0: Hamming distance, or UNEQUAL_LENGTHS (-1) if lengths differ
distance:
    // Save callee-saved registers
    stp     x29, x30, [sp, #-32]!
    mov     x29, sp
    stp     x19, x20, [sp, #16]
    
    mov     x19, x0          // Save strand_a pointer
    mov     x20, x1          // Save strand_b pointer
    
    // Calculate length of strand_a
    mov     x0, x19
    bl      strlen
    mov     w21, w0          // w21 = length of strand_a
    
    // Calculate length of strand_b
    mov     x0, x20
    bl      strlen
    mov     w22, w0          // w22 = length of strand_b
    
    // Compare lengths
    cmp     w21, w22
    b.ne    unequal_lengths  // If lengths differ, return -1
    
    // Initialize counter for Hamming distance
    mov     w0, #0           // w0 = hamming distance (counter)
    
    // If both strings are empty, distance is 0
    cbz     w21, done        // If length is 0, we're done
    
    // Loop through characters
    // w21 = remaining characters
    mov     w2, w21          // w2 = loop counter
loop:
    ldrb    w3, [x19], #1    // Load byte from strand_a, increment pointer
    ldrb    w4, [x20], #1    // Load byte from strand_b, increment pointer
    
    cmp     w3, w4           // Compare characters
    cinc    w0, w0, ne       // Increment counter if characters differ
    
    subs    w2, w2, #1       // Decrement counter, set flags
    b.gt    loop             // If more characters, continue loop
    
    b       done

unequal_lengths:
    mov     w0, #UNEQUAL_LENGTHS  // Return -1 for unequal lengths

done:
    // Restore callee-saved registers
    ldp     x19, x20, [sp, #16]
    ldp     x29, x30, [sp], #32
    ret

// Helper function: strlen(const char *str) -> size_t
// Counts characters until null terminator
// Arguments:
//   x0: pointer to null-terminated string
// Returns:
//   w0: length of string (excluding null terminator)
strlen:
    mov     x1, x0           // Save start pointer
    mov     w0, #0           // Initialize length counter
    
strlen_loop:
    ldrb    w2, [x1], #1     // Load byte, increment pointer
    cbz     w2, strlen_done  // If null terminator, done
    add     w0, w0, #1       // Increment length counter
    b       strlen_loop
    
strlen_done:
    ret