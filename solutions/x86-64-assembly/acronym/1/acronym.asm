section .text
global abbreviate

; void abbreviate(const char *in, char *out);
; rdi = input string, rsi = output buffer
abbreviate:
    push r12
    push r13
    push r14

    mov r12, rdi            ; input pointer
    mov r13, rsi            ; output pointer
    xor r14d, r14d          ; start_of_word flag (1 = expecting new word)

    ; Check if input is empty
    cmp byte [r12], 0
    je .done

    mov r14d, 1             ; first character starts a word

.loop:
    movzx eax, byte [r12]   ; current character
    test al, al
    jz .done

    ; Check for word separators: space, hyphen, underscore
    cmp al, ' '
    je .separator
    cmp al, '-'
    je .separator
    cmp al, '_'
    je .separator

    ; Check if it's a letter
    cmp al, 'A'
    jb .not_letter
    cmp al, 'Z'
    jbe .is_upper
    cmp al, 'a'
    jb .not_letter
    cmp al, 'z'
    ja .not_letter

    ; Lowercase letter - convert to uppercase
    sub al, 32

.is_upper:
    ; It's a letter. If start_of_word, add to output
    cmp r14d, 1
    jne .skip_char
    mov [r13], al
    inc r13
    xor r14d, r14d          ; reset word start flag

.skip_char:
    inc r12
    jmp .loop

.separator:
    mov r14d, 1             ; next letter starts a new word
    inc r12
    jmp .loop

.not_letter:
    inc r12
    jmp .loop

.done:
    mov byte [r13], 0       ; null terminate output

    pop r14
    pop r13
    pop r12
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif