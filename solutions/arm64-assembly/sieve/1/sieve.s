.text
.globl sieve

// ARM64 version
sieve:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    stp x19, x20, [sp, #-16]!
    stp x21, x22, [sp, #-16]!
    stp x23, x24, [sp, #-16]!
    
    mov x19, x0         // x19 = primes array
    mov x20, x1         // x20 = limit
    
    cmp x20, #2
    b.lo .no_primes
    
    add x21, x20, #1    // x21 = limit + 1
    sub sp, sp, x21     // allocate boolean array
    
    // Initialize array (2 to limit) as 1
    mov x0, #1
    add x1, sp, #2
    mov x2, x20
    sub x2, x2, #1
    
.init_loop:
    strb w0, [x1]
    add x1, x1, #1
    sub x2, x2, #1
    cbnz x2, .init_loop
    
    mov x22, #2         // x22 = current number
    
.sieve_loop:
    mul x0, x22, x22
    cmp x0, x20
    b.hi .collect_primes
    
    ldrb w0, [sp, x22]
    cmp w0, #1
    b.ne .next_number
    
    mov x23, x22
    add x23, x23, x22   // x23 = 2 * x22
    
.mark_loop:
    cmp x23, x20
    b.hi .next_number
    
    mov w0, #0
    strb w0, [sp, x23]
    add x23, x23, x22
    b .mark_loop
    
.next_number:
    add x22, x22, #1
    cmp x22, x20
    b.ls .sieve_loop
    
.collect_primes:
    mov x24, #0         // x24 = prime counter
    mov x22, #2
    
.collect_loop:
    cmp x22, x20
    b.hi .done
    
    ldrb w0, [sp, x22]
    cmp w0, #1
    b.ne .skip_collect
    
    str x22, [x19, x24, lsl #3]
    add x24, x24, #1
    
.skip_collect:
    add x22, x22, #1
    b .collect_loop
    
.done:
    mov x0, x24
    add sp, sp, x21
    ldp x23, x24, [sp], #16
    ldp x21, x22, [sp], #16
    ldp x19, x20, [sp], #16
    ldp x29, x30, [sp], #16
    ret
    
.no_primes:
    mov x0, #0
    ldp x23, x24, [sp], #16
    ldp x21, x22, [sp], #16
    ldp x19, x20, [sp], #16
    ldp x29, x30, [sp], #16
    ret