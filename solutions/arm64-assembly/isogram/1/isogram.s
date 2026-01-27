.text
.global is_isogram

is_isogram:
    // Save registers
    stp x29, x30, [sp, #-48]!
    stp x19, x20, [sp, #16]
    stp x21, x22, [sp, #32]
    mov x29, sp
    
    mov x19, x0          // x19 = string pointer
    mov w20, #0          // w20 = bitmask
    
loop:
    ldrb w21, [x19], #1  // Load character, increment pointer
    cbz w21, success     // If null terminator, success
    
    // Check for space (ASCII 32)
    cmp w21, #32
    b.eq loop
    
    // Check for hyphen (ASCII 45)
    cmp w21, #45
    b.eq loop
    
    // Check if uppercase letter (A-Z: 65-90)
    cmp w21, #65
    b.lt loop
    cmp w21, #90
    b.le uppercase
    
    // Check if lowercase letter (a-z: 97-122)
    cmp w21, #97
    b.lt loop
    cmp w21, #122
    b.gt loop
    
    // Lowercase letter
    sub w21, w21, #97    // Convert to index 0-25
    b check_bit
    
uppercase:
    // Uppercase letter
    sub w21, w21, #65    // Convert to index 0-25
    
check_bit:
    // w21 = letter index (0-25)
    mov w22, #1
    lsl w22, w22, w21    // w22 = 1 << index
    
    and w23, w20, w22    // Check if bit is set
    cbnz w23, failure    // If set, not isogram
    
    orr w20, w20, w22    // Set the bit
    b loop

success:
    mov w0, #1           // Return true
    b cleanup

failure:
    mov w0, #0           // Return false

cleanup:
    // Restore registers
    ldp x21, x22, [sp, #32]
    ldp x19, x20, [sp, #16]
    ldp x29, x30, [sp], #48
    ret