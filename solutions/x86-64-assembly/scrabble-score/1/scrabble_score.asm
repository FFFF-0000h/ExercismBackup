default rel

section .rodata
table:  db 1,3,3,2,1,4,2,4,1,8,5,1,3,1,1,3,10,1,1,1,1,4,4,8,4,10

section .text
global score
score:
    xor     eax, eax                  ; sum = 0
    lea     r8, [rel table]           ; load address of score table
.loop:
    movzx   ecx, byte [rdi]           ; next character
    test    cl, cl
    jz      .done                     ; end of string
    inc     rdi                       ; advance pointer

    ; Convert to uppercase if needed
    cmp     cl, 'a'
    jb      .check_upper
    cmp     cl, 'z'
    ja      .check_upper
    sub     cl, 32                    ; 'a' - 'A'
.check_upper:
    cmp     cl, 'A'
    jb      .loop                     ; ignore non‑letters
    cmp     cl, 'Z'
    ja      .loop                     ; ignore non‑letters

    sub     cl, 'A'                   ; map to 0‑25
    movzx   ecx, cl                   ; zero‑extend index
    movzx   ecx, byte [r8 + rcx]      ; lookup score
    add     eax, ecx                  ; accumulate
    jmp     .loop

.done:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif