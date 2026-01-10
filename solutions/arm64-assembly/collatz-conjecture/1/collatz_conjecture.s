.equ INVALID_NUMBER, -1

.text
.globl steps

steps:
    // Input: x0 = number (64-bit)
    // Output: w0 = number of steps to reach 1 (32-bit)
    //         or INVALID_NUMBER if input <= 0
    
    // Check if input is valid (positive integer)
    cmp x0, #1
    b.lt invalid          // if number < 1, invalid
    
    mov w1, #0           // w1 = step counter (32-bit is enough for steps)
    
collatz_loop:
    cmp x0, #1
    b.eq done            // if number == 1, done
    
    // Check if number is even
    tst x0, #1           // test least significant bit
    b.ne odd_case        // if bit is 1, number is odd
    
even_case:
    // number = number / 2
    lsr x0, x0, #1       // right shift for divide by 2
    b increment
    
odd_case:
    // number = 3*number + 1
    // Using: x0 = x0 + (x0 << 1) + 1
    add x0, x0, x0, LSL #1  // x0 = x0 + 2*x0 = 3*x0
    add x0, x0, #1       // x0 = 3*x0 + 1
    
increment:
    add w1, w1, #1       // increment step counter
    b collatz_loop
    
invalid:
    mov w0, INVALID_NUMBER
    ret
    
done:
    mov w0, w1           // return step count
    ret