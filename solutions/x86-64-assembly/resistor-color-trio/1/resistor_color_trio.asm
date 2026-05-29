default rel

section .rodata
black_str:  db "black", 0
brown_str:  db "brown", 0
red_str:    db "red", 0
orange_str: db "orange", 0
yellow_str: db "yellow", 0
green_str:  db "green", 0
blue_str:   db "blue", 0
violet_str: db "violet", 0
grey_str:   db "grey", 0
white_str:  db "white", 0

ohms_str:   db " ohms", 0
kilo_str:   db " kiloohms", 0
mega_str:   db " megaohms", 0
giga_str:   db " gigaohms", 0

section .text
global label

; int streq(const char *a, const char *b)
streq:
    xor ecx, ecx
.loop:
    mov al, byte [rdi + rcx]
    mov dl, byte [rsi + rcx]
    cmp al, dl
    jne .neq
    test al, al
    jz  .eq
    inc ecx
    jmp .loop
.eq:
    mov eax, 1
    ret
.neq:
    xor eax, eax
    ret

; int color_to_digit(const char *s)
color_to_digit:
    push rbx
    mov rbx, rdi

    lea rsi, [black_str]
    call streq
    test eax, eax
    jnz .ret_0
    lea rsi, [brown_str]
    mov rdi, rbx
    call streq
    test eax, eax
    jnz .ret_1
    lea rsi, [red_str]
    mov rdi, rbx
    call streq
    test eax, eax
    jnz .ret_2
    lea rsi, [orange_str]
    mov rdi, rbx
    call streq
    test eax, eax
    jnz .ret_3
    lea rsi, [yellow_str]
    mov rdi, rbx
    call streq
    test eax, eax
    jnz .ret_4
    lea rsi, [green_str]
    mov rdi, rbx
    call streq
    test eax, eax
    jnz .ret_5
    lea rsi, [blue_str]
    mov rdi, rbx
    call streq
    test eax, eax
    jnz .ret_6
    lea rsi, [violet_str]
    mov rdi, rbx
    call streq
    test eax, eax
    jnz .ret_7
    lea rsi, [grey_str]
    mov rdi, rbx
    call streq
    test eax, eax
    jnz .ret_8
    lea rsi, [white_str]
    mov rdi, rbx
    call streq
    test eax, eax
    jnz .ret_9
    xor eax, eax
    pop rbx
    ret
.ret_0:
    xor eax, eax
    pop rbx
    ret
.ret_1:
    mov eax, 1
    pop rbx
    ret
.ret_2:
    mov eax, 2
    pop rbx
    ret
.ret_3:
    mov eax, 3
    pop rbx
    ret
.ret_4:
    mov eax, 4
    pop rbx
    ret
.ret_5:
    mov eax, 5
    pop rbx
    ret
.ret_6:
    mov eax, 6
    pop rbx
    ret
.ret_7:
    mov eax, 7
    pop rbx
    ret
.ret_8:
    mov eax, 8
    pop rbx
    ret
.ret_9:
    mov eax, 9
    pop rbx
    ret

; Append string from rsi to buffer at rdi, returns new buffer pointer in rdi
append_string:
    push rax
.loop:
    lodsb
    stosb
    test al, al
    jnz .loop
    dec rdi                ; point back to the null terminator
    pop rax
    ret

; Append unsigned integer in rax to buffer at rdi, returns updated rdi
append_uint:
    push rdx
    push rcx
    push rbx
    sub rsp, 24            ; local buffer for digits
    lea rbx, [rsp + 23]
    mov byte [rbx], 0
    test rax, rax
    jnz .nonzero
    ; rax == 0
    mov byte [rdi], '0'
    inc rdi
    jmp .done
.nonzero:
    mov rcx, 10
.l1:
    xor edx, edx
    div rcx
    add dl, '0'
    dec rbx
    mov [rbx], dl
    test rax, rax
    jnz .l1
    ; copy from rbx to rdi
    mov rsi, rbx
    call append_string
.done:
    add rsp, 24
    pop rbx
    pop rcx
    pop rdx
    ret

; void label(char *buffer, const char **colors)
label:
    push r12
    push r13
    push r14
    push r15
    push rbx

    mov r12, rdi            ; buffer
    mov r13, rsi            ; colors

    ; color 1
    mov rdi, [r13]
    call color_to_digit
    mov ebx, eax            ; d1

    ; color 2
    mov rdi, [r13 + 8]
    call color_to_digit
    mov r14d, eax           ; d2

    ; color 3
    mov rdi, [r13 + 16]
    call color_to_digit
    mov r15d, eax           ; exponent

    ; base = d1*10 + d2
    imul ebx, ebx, 10
    add ebx, r14d
    ; total = base * 10^exponent
    mov eax, ebx            ; zero-extend to rax
    mov ecx, r15d
    test ecx, ecx
    jz .pow_done
.pow_loop:
    imul rax, rax, 10
    dec ecx
    jnz .pow_loop
.pow_done:
    mov rbx, rax            ; rbx = total

    ; Determine prefix and divisor
    mov r8, 1000000000      ; giga
    cmp rbx, r8
    jb .try_mega
    lea r9, [giga_str]
    mov r10, r8
    jmp .format
.try_mega:
    mov r8, 1000000
    cmp rbx, r8
    jb .try_kilo
    lea r9, [mega_str]
    mov r10, r8
    jmp .format
.try_kilo:
    mov r8, 1000
    cmp rbx, r8
    jb .use_ohms
    lea r9, [kilo_str]
    mov r10, r8
    jmp .format
.use_ohms:
    mov r10, 1
    lea r9, [ohms_str]

.format:
    xor edx, edx
    mov rax, rbx
    div r10                  ; rax = quotient, rdx = remainder
    mov r14, rax             ; integer part
    mov r15, rdx             ; remainder

    ; Append integer part
    mov rdi, r12
    mov rax, r14
    call append_uint
    mov r12, rdi             ; update buffer pointer

    ; If remainder != 0, append '.X'
    test r15, r15
    jz .append_suffix
    ; decimal digit = remainder * 10 / divisor
    mov rax, r15
    imul rax, 10
    xor edx, edx
    div r10
    add al, '0'
    mov byte [r12], '.'
    inc r12
    mov [r12], al
    inc r12

.append_suffix:
    ; Append prefix string
    mov rdi, r12
    mov rsi, r9
    call append_string
    ; buffer already null-terminated by append_string

    pop rbx
    pop r15
    pop r14
    pop r13
    pop r12
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif