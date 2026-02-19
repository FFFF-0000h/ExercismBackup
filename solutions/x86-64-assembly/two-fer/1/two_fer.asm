default rel

section .rodata
prefix: db "One for ", 0
suffix: db ", one for me.", 0
you_str: db "you", 0

section .text
global two_fer
two_fer:
    ; Copy prefix "One for "
    lea rcx, [rel prefix]
.prefix_loop:
    mov al, [rcx]
    test al, al
    jz .prefix_done
    mov [rsi], al
    inc rsi
    inc rcx
    jmp .prefix_loop
.prefix_done:

    ; Decide between name and "you"
    test rdi, rdi
    jz .use_you

    ; Copy name from rdi
    mov rcx, rdi
.name_loop:
    mov al, [rcx]
    test al, al
    jz .after_name
    mov [rsi], al
    inc rsi
    inc rcx
    jmp .name_loop

.use_you:
    lea rcx, [rel you_str]
.you_loop:
    mov al, [rcx]
    test al, al
    jz .after_name
    mov [rsi], al
    inc rsi
    inc rcx
    jmp .you_loop

.after_name:
    ; Copy suffix ", one for me."
    lea rcx, [rel suffix]
.suffix_loop:
    mov al, [rcx]
    test al, al
    jz .suffix_done
    mov [rsi], al
    inc rsi
    inc rcx
    jmp .suffix_loop
.suffix_done:
    ; Null terminate the whole string
    mov byte [rsi], 0
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif