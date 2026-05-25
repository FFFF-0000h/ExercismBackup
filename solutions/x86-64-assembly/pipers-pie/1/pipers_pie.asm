; Everything that comes after a semicolon (;) is a comment

section .text

; Pre-defined function: factorial(n) -> rax
factorial:
    mov rax, 1
factorial_helper:
    cmp rdi, 1
    jle .base_case
    imul rax, rdi
    dec rdi
    jmp factorial_helper
.base_case:
    ret

global largest_portion
largest_portion:
    ; rdi = a, rsi = b
    test rsi, rsi
    jz   .base
    mov  rax, rdi
    xor  rdx, rdx
    div  rsi                  ; rax = quotient, rdx = remainder
    mov  rdi, rsi
    mov  rsi, rdx
    jmp  largest_portion      ; tail‑call (loop)
.base:
    mov  rax, rdi
    ret


global double_factorial
double_factorial:
    ; 32‑bit unsigned n in edi -> return 64‑bit result in rax
    mov  rax, 1
.loop:
    cmp  edi, 1
    jbe  .done                ; n <= 1 → return accumulator
    imul rax, rdi             ; rax *= n  (zero‑extended rdi)
    sub  edi, 2
    jmp  .loop
.done:
    ret


global pipers_pi
pipers_pi:
    ; 32‑bit unsigned n in edi -> return double approximation of π in xmm0
    push r12                  ; callee‑saved registers we will use
    push r13

    mov  r12d, edi            ; r12 = n
    xor  r13d, r13d           ; r13 = k (loop counter)
    pxor xmm2, xmm2           ; sum = 0.0

.loop_sum:
    cmp  r13d, r12d
    ja   .done_sum            ; k > n → finish

    ; compute k!
    mov  edi, r13d
    call factorial            ; rax = k!
    cvtsi2sd xmm0, rax

    ; compute (2*k + 1)!!
    lea  edi, [r13*2 + 1]
    call double_factorial     ; rax = (2k+1)!!
    cvtsi2sd xmm1, rax

    divsd xmm0, xmm1          ; term = k! / (2k+1)!!
    addsd xmm2, xmm0          ; sum += term

    inc  r13d
    jmp  .loop_sum

.done_sum:
    movsd xmm0, xmm2
    addsd xmm0, xmm0          ; π = 2 * sum
    pop  r13
    pop  r12
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif