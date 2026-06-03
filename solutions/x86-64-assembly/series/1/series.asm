EMPTY_SERIES equ -1
ZERO_LENGTH equ -2
NEGATIVE_LENGTH equ -3
EXCESSIVE_LENGTH equ -4

section .text
global slices

; int64_t slices(char buffer[][SLICE_SIZE], const char *series, size_t slice_length);
; rdi = buffer, rsi = series, rdx = slice_length
slices:
    push r12
    push r13
    push r14
    push r15
    push rbx

    mov r12, rdi            ; buffer
    mov r13, rsi            ; series
    mov r14, rdx            ; slice_length

    ; Validate slice_length
    cmp r14, 0
    jl  .negative_length
    je  .zero_length

    ; Compute length of series
    mov rdi, r13
    call strlen
    mov r15, rax            ; series length

    ; If series is empty, return EMPTY_SERIES
    cmp r15, 0
    je  .empty_series

    ; If slice_length > series length, EXCESSIVE_LENGTH
    cmp r14, r15
    ja  .excessive_length

    ; Number of slices = length - slice_length + 1
    mov rax, r15
    sub rax, r14
    inc rax
    mov rbx, rax            ; rbx = count

    xor r8d, r8d            ; i = 0

.loop:
    cmp r8, rbx
    jae .done

    ; Compute row offset: i * SLICE_SIZE (SLICE_SIZE = 20)
    mov rax, r8
    imul rax, 20
    add rax, r12            ; buffer[i]

    ; Copy slice_length bytes from series + i to buffer[i]
    mov rdi, rax            ; destination
    lea rsi, [r13 + r8]     ; source = series + i
    mov rcx, r14            ; count = slice_length
    rep movsb
    mov byte [rdi], 0       ; null terminate

    inc r8
    jmp .loop

.done:
    mov rax, rbx            ; return count
    pop rbx
    pop r15
    pop r14
    pop r13
    pop r12
    ret

.empty_series:
    mov rax, EMPTY_SERIES
    pop rbx
    pop r15
    pop r14
    pop r13
    pop r12
    ret

.zero_length:
    mov rax, ZERO_LENGTH
    pop rbx
    pop r15
    pop r14
    pop r13
    pop r12
    ret

.negative_length:
    mov rax, NEGATIVE_LENGTH
    pop rbx
    pop r15
    pop r14
    pop r13
    pop r12
    ret

.excessive_length:
    mov rax, EXCESSIVE_LENGTH
    pop rbx
    pop r15
    pop r14
    pop r13
    pop r12
    ret

; Simple strlen
strlen:
    mov rax, rdi
.strlen_loop:
    cmp byte [rax], 0
    je .strlen_done
    inc rax
    jmp .strlen_loop
.strlen_done:
    sub rax, rdi
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif