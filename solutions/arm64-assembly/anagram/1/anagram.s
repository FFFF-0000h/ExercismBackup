.text
.globl find_anagrams

//----------------------------------------------------------------------
// Macro: convert register wchr (a 32-bit register holding a char)
// to lowercase if it is 'A'-'Z'.
// Modifies wchr.
//----------------------------------------------------------------------
.macro tolower wchr
    cmp   \wchr, #'A'
    b.lt  1f
    cmp   \wchr, #'Z'
    b.gt  1f
    add   \wchr, \wchr, #('a' - 'A')
1:
.endm

//----------------------------------------------------------------------
// find_anagrams(int *is_anagram, const char *candidates[],
//               size_t num_candidates, const char *subject)
//----------------------------------------------------------------------
find_anagrams:
    stp   x29, x30, [sp, #-16]!
    mov   x29, sp

    // Save callee-saved registers we will use
    stp   x19, x20, [sp, #-16]!
    stp   x21, x22, [sp, #-16]!
    stp   x23, x24, [sp, #-16]!
    str   x25, [sp, #-16]!

    // Arguments
    mov   x19, x0            // x19 = is_anagram array
    mov   x20, x1            // x20 = candidates array
    mov   x21, x2            // x21 = num_candidates
    mov   x22, x3            // x22 = subject string

    // Allocate 208 bytes for two frequency arrays (26 ints each)
    sub   sp, sp, #208
    // subject freq at sp+0, candidate freq at sp+104

    // Compute subject length
    mov   x0, x22
    bl    strlen_asm
    mov   w23, w0            // w23 = subject length

    // Zero subject frequency array
    mov   x0, sp
    mov   w1, #26
    bl    zero_int_array

    // Fill subject frequency array
    mov   x0, sp
    mov   x1, x22
    bl    freq_count

    // Loop over candidates
    mov   x24, #0            // i = 0
    cbz   x21, .Ldone        // if num_candidates == 0, skip loop

.Lloop_start:
    ldr   x25, [x20, x24, lsl #3]   // candidate = candidates[i]

    // 1) Length check
    mov   x0, x25
    bl    strlen_asm
    cmp   w0, w23
    b.ne  .Lmark_false

    // 2) Identity check (case-insensitive)
    mov   x0, x25
    mov   x1, x22
    mov   w2, w23
    bl    strieq
    cmp   w0, #1
    b.eq  .Lmark_false

    // 3) Compute candidate frequency
    add   x0, sp, #104       // candidate freq array
    mov   w1, #26
    bl    zero_int_array

    add   x0, sp, #104
    mov   x1, x25
    bl    freq_count

    // Compare frequency arrays
    add   x0, sp, #104       // candidate freq
    mov   x1, sp             // subject freq
    mov   w2, #26
    bl    memcmp_eq
    cmp   w0, #1
    b.eq  .Lmark_true

.Lmark_false:
    str   wzr, [x19, x24, lsl #2]
    b     .Lnext

.Lmark_true:
    mov   w0, #1
    str   w0, [x19, x24, lsl #2]

.Lnext:
    add   x24, x24, #1
    cmp   x24, x21
    b.lo  .Lloop_start

.Ldone:
    // Restore stack and registers
    add   sp, sp, #208
    ldr   x25, [sp], #16
    ldp   x23, x24, [sp], #16
    ldp   x21, x22, [sp], #16
    ldp   x19, x20, [sp], #16
    ldp   x29, x30, [sp], #16
    ret

//----------------------------------------------------------------------
// strlen_asm: length of null-terminated string
// Input:  x0 = string
// Output: w0 = length
//----------------------------------------------------------------------
strlen_asm:
    mov   x1, x0
.Lstrlen_loop:
    ldrb  w2, [x0], #1
    cbnz  w2, .Lstrlen_loop
    sub   x0, x0, x1
    sub   w0, w0, #1        // exclude null terminator
    ret

//----------------------------------------------------------------------
// zero_int_array: fill array of 32-bit ints with zero
// Input:  x0 = pointer, w1 = count
//----------------------------------------------------------------------
zero_int_array:
    mov   w2, #0
.Lzero_loop:
    str   w2, [x0], #4
    subs  w1, w1, #1
    b.ne  .Lzero_loop
    ret

//----------------------------------------------------------------------
// freq_count: tally letter frequencies (a-z) of a string
// Input:  x0 = pointer to 26 zeroed ints, x1 = string
//----------------------------------------------------------------------
freq_count:
    ldrb  w2, [x1], #1
    cbz   w2, .Lfreq_done
    tolower w2
    sub   w2, w2, #'a'
    cmp   w2, #0
    b.lt  1f
    cmp   w2, #25
    b.gt  1f
    ldr   w3, [x0, x2, lsl #2]
    add   w3, w3, #1
    str   w3, [x0, x2, lsl #2]
1:  b     freq_count
.Lfreq_done:
    ret

//----------------------------------------------------------------------
// strieq: case-insensitive string equality for given length
// Input:  x0 = s1, x1 = s2, w2 = length
// Output: w0 = 1 if equal, 0 otherwise
//----------------------------------------------------------------------
strieq:
    mov   w3, w2
    cbz   w3, .Lseq_true
.Lseq_loop:
    ldrb  w4, [x0], #1
    ldrb  w5, [x1], #1
    tolower w4
    tolower w5
    cmp   w4, w5
    b.ne  .Lseq_false
    subs  w3, w3, #1
    b.ne  .Lseq_loop
.Lseq_true:
    mov   w0, #1
    ret
.Lseq_false:
    mov   w0, #0
    ret

//----------------------------------------------------------------------
// memcmp_eq: compare two arrays of 32-bit words
// Input:  x0 = array1, x1 = array2, w2 = number of words
// Output: w0 = 1 if equal, 0 otherwise
//----------------------------------------------------------------------
memcmp_eq:
    mov   w3, w2
    cbz   w3, .Lm_true
.Lm_loop:
    ldr   w4, [x0], #4
    ldr   w5, [x1], #4
    cmp   w4, w5
    b.ne  .Lm_false
    subs  w3, w3, #1
    b.ne  .Lm_loop
.Lm_true:
    mov   w0, #1
    ret
.Lm_false:
    mov   w0, #0
    ret