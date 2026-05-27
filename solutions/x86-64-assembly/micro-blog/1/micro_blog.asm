section .text
global truncate

; void truncate(char *output, const char *input);
; Truncates the UTF-8 input to at most 5 Unicode codepoints.
; rdi = output buffer, rsi = input string (null-terminated UTF-8)
truncate:
    push   rbx
    mov    r8, rdi          ; output pointer
    mov    r9, rsi          ; input pointer
    mov    ecx, 5           ; remaining codepoints to copy

.loop:
    movzx  eax, byte [r9]   ; load first byte of potential sequence
    test   al, al
    jz     .done            ; null terminator → finish

    ; ----- determine sequence length in bytes (edx) -----
    cmp    al, 0x80
    jb     .len1            ; 0xxxxxxx → 1-byte (ASCII)
    cmp    al, 0xC0
    jb     .invalid         ; 10xxxxxx → continuation byte (invalid at start)
    cmp    al, 0xE0
    jb     .len2            ; 110xxxxx → 2-byte
    cmp    al, 0xF0
    jb     .len3            ; 1110xxxx → 3-byte
    ; must be 11110xxx → 4-byte (F0–F7)
.len4:
    mov    edx, 4
    jmp    .check
.len1:
    mov    edx, 1
    jmp    .check
.len2:
    mov    edx, 2
    jmp    .check
.len3:
    mov    edx, 3
    jmp    .check
.invalid:
    ; Invalid leading byte – treat as single byte to avoid infinite loops
    mov    edx, 1

.check:
    ; Stop copying if we already have 5 codepoints
    test   ecx, ecx
    jz     .done

    ; Copy the whole sequence (edx bytes) from input to output
    mov    r10d, edx         ; byte counter
.copy_loop:
    mov    bl, [r9]
    mov    [r8], bl
    inc    r9
    inc    r8
    dec    r10d
    jnz    .copy_loop

    dec    ecx               ; one complete codepoint copied
    jmp    .loop

.done:
    mov    byte [r8], 0      ; null-terminate the output
    pop    rbx
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif