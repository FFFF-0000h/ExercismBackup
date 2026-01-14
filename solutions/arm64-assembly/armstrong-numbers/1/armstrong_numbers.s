.text
.globl is_armstrong_number

// Function: is_armstrong_number
// Input: w0 = unsigned number
// Output: w0 = 1 if true, 0 if false

is_armstrong_number:
        // Save registers (preserve callee-saved registers)
        stp     x29, x30, [sp, #-64]!
        stp     x19, x20, [sp, #16]
        stp     x21, x22, [sp, #32]
        stp     x23, x24, [sp, #48]
        
        // Check if number is 0 (special case)
        cbz     w0, return_true
        
        // w19 = original number
        mov     w19, w0
        
        // w20 = digit count (initialize to 0)
        mov     w20, #0
        
        // w21 = copy for counting digits
        mov     w21, w19
        
count_digits:
        // Increment digit count
        add     w20, w20, #1
        
        // Divide by 10 to get next digit
        mov     w0, w21
        mov     w1, #10
        udiv    w22, w0, w1         // w22 = quotient
        msub    w23, w22, w1, w0    // w23 = remainder
        
        // Move quotient back to w21
        mov     w21, w22
        
        // If quotient is not 0, continue counting
        cbnz    w22, count_digits
        
        // Now w20 contains digit count
        // Reset sum to 0
        mov     w22, #0             // w22 = sum
        
        // w21 = number for processing digits
        mov     w21, w19
        
process_digits:
        // Divide by 10 to get digit
        mov     w0, w21
        mov     w1, #10
        udiv    w23, w0, w1         // w23 = quotient
        msub    w24, w23, w1, w0    // w24 = digit (remainder)
        
        // Save quotient for next iteration
        mov     w21, w23
        
        // Compute digit^digit_count
        // If digit is 0, skip power calculation (0^anything = 0)
        cbz     w24, add_to_sum
        
        // w0 = digit^digit_count (start with digit)
        mov     w0, w24
        
        // Need to multiply digit by itself (digit_count - 1) times
        mov     w1, w20
        sub     w1, w1, #1
        
        // If digit_count is 1, we're done
        cbz     w1, power_done
        
        // w2 = digit for multiplication
        mov     w2, w24
        
power_loop:
        // Multiply w0 by w2
        mul     w0, w0, w2
        
        // Decrement counter
        sub     w1, w1, #1
        
        // If counter > 0, continue
        cbnz    w1, power_loop
        
power_done:
        // w0 now contains digit^digit_count
        b       add_power
        
add_to_sum:
        // digit is 0, so power is 0
        mov     w0, #0
        
add_power:
        // Add to sum
        add     w22, w22, w0
        
        // Check if we've processed all digits (quotient is 0)
        cbz     w21, check_sum
        
        // More digits to process
        b       process_digits
        
check_sum:
        // All digits processed, compare sum to original number
        cmp     w22, w19
        b.ne    return_false
        
return_true:
        mov     w0, #1
        b       cleanup
        
return_false:
        mov     w0, #0
        
cleanup:
        // Restore registers
        ldp     x23, x24, [sp, #48]
        ldp     x21, x22, [sp, #32]
        ldp     x19, x20, [sp, #16]
        ldp     x29, x30, [sp], #64
        
        ret