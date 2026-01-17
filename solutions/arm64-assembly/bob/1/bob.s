.text
.globl response

response:
    // Save registers
    stp x19, x20, [sp, #-16]!
    stp x21, x22, [sp, #-16]!
    stp x23, x24, [sp, #-16]!
    stp x29, x30, [sp, #-16]!
    
    mov x19, x0          // x19 = string pointer
    mov w20, #0          // w20 = is_question flag
    mov w21, #0          // w21 = has_letters flag  
    mov w22, #1          // w22 = is_yelling flag (starts true)
    mov w23, #1          // w23 = is_silence flag (starts true)
    
    // First, find the last non-whitespace character
    mov x24, xzr         // x24 = last non-whitespace position
    
    // Reset pointer for scanning
    mov x0, x19
    
find_last_char_loop:
    ldrb w1, [x0], #1    // Load character
    cbz w1, find_last_done // End of string
    
    // Check if whitespace
    cmp w1, #' '
    beq find_last_char_loop
    cmp w1, #'\t'
    beq find_last_char_loop
    cmp w1, #'\n'
    beq find_last_char_loop
    cmp w1, #'\r'
    beq find_last_char_loop
    
    // Not whitespace
    sub x24, x0, #1      // Save position of last non-whitespace
    
    b find_last_char_loop
    
find_last_done:
    // Check if we found any non-whitespace
    cbz x24, check_if_empty
    
    // Check if last non-whitespace is '?'
    ldrb w1, [x24]       // Load last non-whitespace character
    cmp w1, #'?'
    bne not_a_question
    
    mov w20, #1          // It's a question
    
not_a_question:
    // Now scan the whole string to check for letters and case
    mov x0, x19          // Reset to start
    
scan_string_loop:
    ldrb w1, [x0], #1
    cbz w1, scan_done
    
    // Check if whitespace (update silence flag)
    cmp w1, #' '
    beq scan_string_loop
    cmp w1, #'\t'
    beq scan_string_loop
    cmp w1, #'\n'
    beq scan_string_loop
    cmp w1, #'\r'
    beq scan_string_loop
    
    mov w23, #0          // Not silence (found non-whitespace)
    
    // Check if it's a letter
    // Check A-Z
    cmp w1, #'A'
    blt not_a_letter
    cmp w1, #'Z'
    ble is_letter
    
    // Check a-z  
    cmp w1, #'a'
    blt not_a_letter
    cmp w1, #'z'
    bgt not_a_letter
    
is_letter:
    mov w21, #1          // Has letters
    
    // Check if lowercase
    cmp w1, #'a'
    blt scan_string_loop  // Already checked it's >= 'A', so if < 'a' it's uppercase
    
    // It's lowercase (a-z)
    mov w22, #0          // Not all uppercase (yelling)
    
    b scan_string_loop
    
not_a_letter:
    // Check other characters (numbers, punctuation, etc.)
    b scan_string_loop
    
scan_done:
    // Determine response
    cmp w23, #1
    beq return_silence
    
    // Check if has letters
    cmp w21, #1
    bne no_letters
    
    // Has letters, check if yelling
    cmp w22, #1
    bne not_yelling
    
    // Has letters and is yelling
    cmp w20, #1
    beq return_yell_question
    
    b return_yell
    
not_yelling:
    // Has letters but not yelling
    cmp w20, #1
    beq return_question
    
    b return_whatever
    
no_letters:
    // No letters in the string
    cmp w20, #1
    beq return_question
    
    b return_whatever
    
check_if_empty:
    // Check if the string is empty or only whitespace
    mov x0, x19
    
check_empty_loop:
    ldrb w1, [x0], #1
    cbz w1, return_silence  // End of string, it's silent
    
    // Check if whitespace
    cmp w1, #' '
    beq check_empty_loop
    cmp w1, #'\t'
    beq check_empty_loop
    cmp w1, #'\n'
    beq check_empty_loop
    cmp w1, #'\r'
    beq check_empty_loop
    
    // Found non-whitespace
    b not_a_question      // Process normally

return_silence:
    ldr x0, =silence_str
    b cleanup

return_question:
    ldr x0, =sure_str
    b cleanup

return_yell:
    ldr x0, =chill_str
    b cleanup

return_yell_question:
    ldr x0, =calm_str
    b cleanup

return_whatever:
    ldr x0, =whatever_str

cleanup:
    ldp x29, x30, [sp], #16
    ldp x23, x24, [sp], #16
    ldp x21, x22, [sp], #16
    ldp x19, x20, [sp], #16
    ret

.section .rodata
silence_str:    .asciz "Fine. Be that way!"
sure_str:       .asciz "Sure."
chill_str:      .asciz "Whoa, chill out!"
calm_str:       .asciz "Calm down, I know what I'm doing!"
whatever_str:   .asciz "Whatever."