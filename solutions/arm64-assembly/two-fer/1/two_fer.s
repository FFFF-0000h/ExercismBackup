.text
.globl two_fer

two_fer:
    // x0 = output buffer (pre-allocated by caller)
    // x1 = name pointer (can be NULL)
    
    // Save registers we'll modify
    stp x29, x30, [sp, #-32]!
    stp x19, x20, [sp, #16]
    
    mov x19, x0  // Save output buffer
    mov x20, x1  // Save name pointer
    
    // Check if name is NULL or empty
    cbz x20, .use_you
    
    ldrb w0, [x20]
    cbz w0, .use_you
    
    // We have a valid name - copy "One for " prefix
    adr x0, .prefix
    mov x1, x19
    bl .copy_string
    
    // Append the name
    mov x0, x20
    add x1, x19, #8  // After "One for "
    bl .copy_string
    
    // Append the suffix ", one for me."
    adr x0, .suffix
    add x1, x19, #8
    // Need to find end of current string to append
    mov x2, x19
.find_end:
    ldrb w3, [x2]
    cbz w3, .found_end
    add x2, x2, #1
    b .find_end
.found_end:
    mov x1, x2
    bl .copy_string
    
    b .done
    
.use_you:
    // Copy "One for you, one for me."
    adr x0, .default
    mov x1, x19
    bl .copy_string
    
.done:
    mov x0, x19  // Return the buffer pointer
    ldp x19, x20, [sp, #16]
    ldp x29, x30, [sp], #32
    ret

// Helper function to copy string
.copy_string:
    // x0 = source string
    // x1 = destination buffer
.copy_loop:
    ldrb w2, [x0], #1
    strb w2, [x1], #1
    cbnz w2, .copy_loop
    ret

.prefix:
    .asciz "One for "
.suffix:
    .asciz ", one for me."
.default:
    .asciz "One for you, one for me."