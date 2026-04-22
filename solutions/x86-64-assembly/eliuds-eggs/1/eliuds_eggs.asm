section .text
global egg_count

; int egg_count(int number)
; Counts the number of set bits (1s) in the binary representation of the argument.
; Uses Brian Kernighan's algorithm: repeatedly clears the lowest set bit.
egg_count:
    xor eax, eax                ; initialize counter to 0
.loop:
    test edi, edi               ; is number == 0?
    jz .done                    ; if yes, we're done
    inc eax                     ; increment count
    lea edx, [rdi - 1]          ; compute number - 1
    and edi, edx                ; clear the lowest set bit
    jmp .loop                   ; repeat
.done:
    ret                         ; return count in eax

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif