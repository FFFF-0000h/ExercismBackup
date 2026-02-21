section .text
global distance
distance:
    ; Input: RDI = pointer to first string (NUL-terminated)
    ;        RSI = pointer to second string (NUL-terminated)
    ; Output: EAX = Hamming distance if strings are equal length,
    ;              otherwise -1 (0xFFFFFFFF)

    xor eax, eax        ; distance counter = 0

.loop:
    movzx ecx, byte [rdi]   ; load next character from strand1
    movzx edx, byte [rsi]   ; load next character from strand2

    test cl, cl             ; end of strand1?
    jz .check_end           ; yes, go see if strand2 also ended

    test dl, dl             ; end of strand2?
    jz .diff_len            ; strand2 ended early -> unequal lengths

    ; both characters are non-null
    cmp cl, dl
    je .next                ; same character -> no increment
    inc eax                 ; different character -> increase distance

.next:
    inc rdi                 ; advance pointers
    inc rsi
    jmp .loop

.check_end:
    ; strand1 ended, now check strand2
    test dl, dl
    jnz .diff_len           ; strand2 still has characters -> unequal lengths

    ; both strings ended at the same time -> success
    ret

.diff_len:
    mov eax, -1             ; indicate error (different lengths)
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif