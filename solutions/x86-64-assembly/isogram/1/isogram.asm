section .text
global is_isogram

; int is_isogram(const char *str);
; Returns non‑zero (1) if str is an isogram, zero otherwise.
; Only letters are considered; case is ignored. Spaces, hyphens, and
; all other non‑letter characters are skipped.
is_isogram:
        xor     eax, eax                ; bitmask of seen letters (26 bits)
.loop:
        movzx   edx, byte [rdi]        ; load next byte
        test    dl, dl                  ; null terminator?
        jz      .true                   ; reached end -> isogram

        ; Convert lowercase to uppercase for case‑insensitive comparison
        cmp     dl, 'a'
        jl      .check_upper
        cmp     dl, 'z'
        jg      .next                   ; not a letter, skip
        sub     dl, 32                  ; 'a'‑'z' -> 'A'‑'Z'
        jmp     .check_letter

.check_upper:
        cmp     dl, 'A'
        jl      .next                   ; not a letter
        cmp     dl, 'Z'
        jg      .next

.check_letter:
        sub     dl, 'A'                 ; index 0..25
        mov     ecx, edx                ; shift count must be in cl
        mov     edx, 1
        shl     edx, cl                 ; 1 << index
        test    eax, edx               ; letter already seen?
        jnz     .false                  ; yes -> not an isogram
        or      eax, edx               ; mark as seen

.next:
        inc     rdi
        jmp     .loop

.false:
        xor     eax, eax                ; return 0
        ret

.true:
        mov     eax, 1                  ; return non‑zero
        ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif