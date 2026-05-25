.text
.globl commands

// void commands(char *buffer, int number);
// x0 = destination buffer
// w1 = number (0..31)

commands:
        // Save callee-saved registers and the buffer pointer
        stp     x19, x20, [sp, #-16]!
        stp     x21, x22, [sp, #-16]!
        stp     x23, x24, [sp, #-16]!
        mov     x19, x0                 // x19 = buffer pointer (save)
        mov     w20, w1                 // w20 = number

        // We'll use x21 as write pointer into the buffer
        mov     x21, x0
        mov     w22, #0                 // w22 = action count (number of actions added)
        
        // Scan bits 0..3, collect action indices in a small array on the stack
        sub     sp, sp, #16             // room for up to 4 word indices
        mov     x23, sp                 // x23 = temporary array
        
        mov     w24, #0                 // bit index 0..3
.Lscan_bits:
        cmp     w24, #4
        b.ge    .Lbits_done
        mov     w25, #1
        lsl     w25, w25, w24           // bit mask
        tst     w20, w25
        b.eq    .Lbit_not_set
        str     w24, [x23, w22, uxtw #2] // store action index
        add     w22, w22, #1
.Lbit_not_set:
        add     w24, w24, #1
        b       .Lscan_bits
.Lbits_done:
        // Check reverse bit (bit 4 = 16)
        tbz     w20, #4, .Lno_reverse
        // Reverse array in place
        cmp     w22, #2
        b.lt    .Lno_reverse
        mov     w24, #0
        sub     w25, w22, #1
.Lreverse_loop:
        cmp     w24, w25
        b.ge    .Lno_reverse
        ldr     w26, [x23, w24, uxtw #2]
        ldr     w27, [x23, w25, uxtw #2]
        str     w27, [x23, w24, uxtw #2]
        str     w26, [x23, w25, uxtw #2]
        add     w24, w24, #1
        sub     w25, w25, #1
        b       .Lreverse_loop
.Lno_reverse:
        // Build output string into the buffer
        mov     w24, #0                 // loop counter over collected actions
        cbz     w22, .Ldone_string      // no actions -> just null terminator

.Lbuild_loop:
        ldr     w25, [x23, w24, uxtw #2] // action index (0..3)
        // Get pointer to the corresponding string
        adr     x0, action_table
        ldr     x0, [x0, w25, uxtw #3]
        // Copy action string to buffer
.Lcopy_action:
        ldrb    w26, [x0], #1
        cbz     w26, .Lcopy_done
        strb    w26, [x21], #1
        b       .Lcopy_action
.Lcopy_done:
        add     w24, w24, #1
        cmp     w24, w22
        b.ge    .Ldone_string
        // Append separator ", "
        mov     w26, #','
        strb    w26, [x21], #1
        mov     w26, #' '
        strb    w26, [x21], #1
        b       .Lbuild_loop
.Ldone_string:
        strb    wzr, [x21]              // null terminate
        add     sp, sp, #16
        ldp     x23, x24, [sp], #16
        ldp     x21, x22, [sp], #16
        ldp     x19, x20, [sp], #16
        ret

.data
action_table:
        .quad   action_wink
        .quad   action_double_blink
        .quad   action_close_eyes
        .quad   action_jump

action_wink:            .asciz "wink"
action_double_blink:    .asciz "double blink"
action_close_eyes:      .asciz "close your eyes"
action_jump:            .asciz "jump"