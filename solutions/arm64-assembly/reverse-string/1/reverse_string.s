.text
.globl reverse

reverse:
    // x0: pointer to the string (input/output)
    
    // Handle empty string case first
    ldrb w1, [x0]              // Load first byte
    cbz w1, done               // If it's zero (empty string), return immediately
    
    // Find end of string
    mov x1, x0                 // x1 = pointer to find end
find_end:
    ldrb w2, [x1], #1          // Load byte, increment pointer
    cbnz w2, find_end          // Continue until null terminator
    
    // x1 now points one past null terminator
    sub x2, x1, #2             // x2 = end pointer (last character before null)
    
    // x0 = start pointer, x2 = end pointer
swap_loop:
    cmp x0, x2                 // Compare start and end pointers
    b.ge done                  // If start >= end, we're done
    
    // Swap characters at x0 and x2
    ldrb w3, [x0]              // Load char from start
    ldrb w4, [x2]              // Load char from end
    strb w4, [x0], #1          // Store end char at start, increment start
    strb w3, [x2], #-1         // Store start char at end, decrement end
    
    b swap_loop                // Repeat

done:
    ret