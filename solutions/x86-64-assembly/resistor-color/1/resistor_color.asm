default rel

section .rodata
    ; Color strings (null-terminated) – read-only
    color0: db "black", 0
    color1: db "brown", 0
    color2: db "red", 0
    color3: db "orange", 0
    color4: db "yellow", 0
    color5: db "green", 0
    color6: db "blue", 0
    color7: db "violet", 0
    color8: db "grey", 0
    color9: db "white", 0

section .data
    align 8
    ; Table of pointers to color strings – must be writable to avoid
    ; text relocations in position‑independent code.
    color_table:
        dq color0, color1, color2, color3, color4
        dq color5, color6, color7, color8, color9
        dq 0                     ; sentinel NULL for the colors() function

section .text
global color_code
color_code:
    ; rdi: pointer to color name (null-terminated string)
    push rbx
    mov rbx, rdi                 ; save input string pointer
    lea r8, [color_table]        ; base address of pointer table
    xor ecx, ecx                 ; index = 0
.loop:
    cmp ecx, 10
    jge .not_found               ; index >= 10 -> invalid color
    mov rsi, [r8 + rcx*8]        ; candidate color string
    mov rdi, rbx                 ; restore original input
    call compare_strings
    test eax, eax
    jnz .found
    inc ecx
    jmp .loop
.found:
    mov eax, ecx                 ; return index (0..9)
    pop rbx
    ret
.not_found:
    mov eax, -1                  ; return -1 for invalid color
    pop rbx
    ret

; Helper: compare two null-terminated strings
; Input: rdi, rsi
; Output: eax = 1 if equal, 0 otherwise
compare_strings:
.loop:
    mov al, byte [rdi]
    cmp al, byte [rsi]
    jne .not_equal
    test al, al
    jz .equal
    inc rdi
    inc rsi
    jmp .loop
.equal:
    mov eax, 1
    ret
.not_equal:
    xor eax, eax
    ret

global colors
colors:
    lea rax, [color_table]       ; pointer to NULL-terminated array of string pointers
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif