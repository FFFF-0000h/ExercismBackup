.text
.globl find

// int16_t value in x0, array pointer in x1, size_t count in x2
// returns index (ptrdiff_t) in x0, or -1 if not found
find:
    cbz     x2, .not_found          // count == 0 -> return -1

    // Sign-extend value from 16-bit
    sxth    w0, w0                  // ensure value is proper 16-bit signed

    mov     w3, #0                  // left = 0
    sub     w4, w2, #1              // right = count - 1

.Lloop:
    cmp     w3, w4
    bgt     .not_found              // if left > right, exit

    add     w5, w3, w4
    lsr     w5, w5, #1              // mid = (left + right) / 2   (unsigned shift, fine)

    // Load array[mid] as a sign-extended word
    ldrsh   w6, [x1, x5, lsl #1]    // w6 = array[mid]

    cmp     w6, w0
    b.eq    .found                  // equal -> return mid
    b.lt    .go_right               // array[mid] < value

    // array[mid] > value
    sub     w4, w5, #1              // right = mid - 1
    b       .Lloop

.go_right:
    add     w3, w5, #1              // left = mid + 1
    b       .Lloop

.found:
    mov     x0, x5                  // return mid (zero-extend to 64-bit)
    ret

.not_found:
    mov     x0, #-1                 // return -1
    ret