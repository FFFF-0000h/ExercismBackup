section .text
global is_armstrong_number

; Function: is_armstrong_number
; Input:
;   rdi - integer to check
; Output:
;   rax - 1 if Armstrong number, 0 otherwise
is_armstrong_number:
    push rbp
    mov rbp, rsp
    push rbx
    push r12
    push r13
    push r14
    
    mov r12, rdi        ; r12 = original number (n)
    
    ; Handle n = 0 (0 is an Armstrong number: 0^1 = 0)
    test r12, r12
    jnz .not_zero
    mov rax, 1
    jmp .done
    
.not_zero:
    ; Step 1: Count number of digits
    mov r13, r12        ; r13 = temp copy for counting digits
    xor r14, r14        ; r14 = digit count
    
.count_digits:
    test r13, r13
    jz .digits_counted
    inc r14
    mov rax, r13
    xor rdx, rdx
    mov rbx, 10
    div rbx             ; rax = r13 / 10, rdx = r13 % 10
    mov r13, rax
    jmp .count_digits
    
.digits_counted:
    ; r14 = number of digits (power)
    
    ; Step 2: Compute sum of digits^power
    mov r13, r12        ; r13 = temp copy of n for digit extraction
    xor rbx, rbx        ; rbx = sum
    
.sum_loop:
    test r13, r13
    jz .check_result
    
    ; Extract digit: r13 % 10
    mov rax, r13
    xor rdx, rdx
    mov rcx, 10
    div rcx             ; rax = r13 / 10, rdx = r13 % 10 (digit)
    mov r13, rax        ; Update r13 for next iteration
    mov rcx, rdx        ; rcx = current digit
    
    ; Compute digit^power
    push r14            ; Save digit count (power)
    mov rax, 1          ; Start with 1
    
.power_loop:
    test r14, r14
    jz .power_done
    mul rcx             ; rax = rax * digit
    dec r14
    jmp .power_loop
    
.power_done:
    pop r14             ; Restore digit count
    add rbx, rax        ; Add to sum
    jmp .sum_loop
    
.check_result:
    cmp r12, rbx        ; Compare original number with sum
    sete al
    movzx rax, al
    
.done:
    pop r14
    pop r13
    pop r12
    pop rbx
    pop rbp
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif