.text
.globl egg_count

egg_count:
    // Input: x0 = number
    // Output: x0 = number of 1 bits (population count)
    
    // Handle edge case: x0 = 0
    cbz x0, return_zero
    
    mov x1, x0          // Copy of input
    mov x0, #0          // Initialize count to 0
    
count_loop:
    // Count while x1 != 0
    cbz x1, done
    
    // x2 = x1 & -x1 (isolates rightmost 1 bit)
    neg x2, x1
    and x2, x1, x2
    
    // x1 = x1 & (x1 - 1) (clears rightmost 1 bit)
    sub x3, x1, #1
    and x1, x1, x3
    
    // Increment count
    add x0, x0, #1
    
    b count_loop

return_zero:
    mov x0, #0
    ret

done:
    ret