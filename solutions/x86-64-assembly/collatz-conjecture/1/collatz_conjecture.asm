ERROR_VALUE equ -1

section .text
global steps
steps:
    ; int steps(int number)
    ; Input: edi = number (System V AMD64 ABI)
    ; Output: eax = number of steps, or -1 for invalid input
    
    ; Check if input is positive (<= 0 is invalid)
    test edi, edi
    jle .invalid_input
    
    xor eax, eax        ; step counter = 0
    
.collatz_loop:
    cmp edi, 1
    je .done            ; Reached 1, done
    
    ; Check if even (n % 2 == 0)
    test edi, 1
    jnz .odd
    
    ; Even: n = n / 2
    shr edi, 1          ; Divide by 2 (faster than div)
    jmp .increment
    
.odd:
    ; Odd: n = 3n + 1
    ; Calculate 3*n + 1
    mov ecx, edi        ; Save n
    add edi, edi        ; n*2
    add edi, ecx        ; n*3
    add edi, 1          ; n*3 + 1
    
.increment:
    inc eax             ; Increment step counter
    jmp .collatz_loop   ; Continue loop
    
.invalid_input:
    mov eax, ERROR_VALUE
    ret
    
.done:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif