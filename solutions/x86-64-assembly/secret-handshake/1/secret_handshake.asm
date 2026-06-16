default rel

section .rodata
    wink_str: db "wink", 0
    double_blink_str: db "double blink", 0
    close_eyes_str: db "close your eyes", 0
    jump_str: db "jump", 0

section .text
global commands

; void commands(char *buffer, int number);
; rdi = buffer, esi = number
commands:
    push r12
    push r13
    push r14
    push rbx
    sub rsp, 32

    mov r12, rdi            ; buffer pointer
    mov r13d, esi           ; number (using esi since second arg is int)

    ; Handle 0 case: output empty string
    test r13d, r13d
    jz .empty_output

    xor r14d, r14d          ; count = 0

    ; Check bits 0 through 3
    mov ecx, 0              ; bit position
.check_bits:
    cmp ecx, 4
    jge .check_reverse

    mov eax, 1
    shl eax, cl
    test r13d, eax
    jz .next_bit

    ; Store action index
    mov [rsp + r14*4], ecx
    inc r14d

.next_bit:
    inc ecx
    jmp .check_bits

.check_reverse:
    ; Check bit 4 (value 16)
    test r13d, 16
    jz .output

    ; Reverse stored indices
    cmp r14d, 2
    jl .output
    xor ecx, ecx
    lea r9d, [r14d - 1]
.reverse_loop:
    cmp ecx, r9d
    jge .output
    mov eax, [rsp + rcx*4]
    mov edx, [rsp + r9*4]
    mov [rsp + rcx*4], edx
    mov [rsp + r9*4], eax
    inc ecx
    dec r9d
    jmp .reverse_loop

.output:
    xor ebx, ebx            ; i = 0

.output_loop:
    cmp ebx, r14d
    jge .terminate

    mov eax, [rsp + rbx*4]

    ; Select string based on index
    cmp eax, 0
    je .use_wink
    cmp eax, 1
    je .use_double
    cmp eax, 2
    je .use_close
    lea rdi, [rel jump_str]
    jmp .copy_str

.use_wink:
    lea rdi, [rel wink_str]
    jmp .copy_str
.use_double:
    lea rdi, [rel double_blink_str]
    jmp .copy_str
.use_close:
    lea rdi, [rel close_eyes_str]

.copy_str:
    call strcpy_append

    ; Add separator if not last
    lea eax, [ebx + 1]
    cmp eax, r14d
    jge .no_sep
    mov byte [r12], ','
    inc r12
    mov byte [r12], ' '
    inc r12

.no_sep:
    inc ebx
    jmp .output_loop

.terminate:
    mov byte [r12], 0
    add rsp, 32
    pop rbx
    pop r14
    pop r13
    pop r12
    ret

.empty_output:
    mov byte [r12], 0
    add rsp, 32
    pop rbx
    pop r14
    pop r13
    pop r12
    ret

; Copy null-terminated string from rdi to r12, advance r12
strcpy_append:
    mov al, [rdi]
    test al, al
    jz .done
    mov [r12], al
    inc rdi
    inc r12
    jmp strcpy_append
.done:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif