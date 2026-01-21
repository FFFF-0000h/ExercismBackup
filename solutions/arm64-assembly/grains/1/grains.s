.text
.globl square
.globl total

// Function: square
// Input: w0 = square number (1-64)
// Output: x0 = number of grains on that square (2^(square-1))
square:
        // Handle edge cases
        cmp     w0, #0
        ble     .Lreturn_zero
        cmp     w0, #64
        bgt     .Lreturn_zero  // Beyond chessboard
        
        // Compute 2^(square-1)
        // square-1 must be in range 0-63
        sub     w1, w0, #1
        
        // Shift 1 left by (square-1) bits
        mov     x0, #1
        lsl     x0, x0, x1
        
        ret

.Lreturn_zero:
        mov     x0, #0
        ret

// Function: total
// Output: x0 = total grains on all 64 squares = 2^64 - 1
total:
        // 2^64 - 1 = 0xFFFFFFFFFFFFFFFF
        // We can get this by: -1 (in two's complement)
        mov     x0, #-1
        ret