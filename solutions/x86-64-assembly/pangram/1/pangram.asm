section .text
global is_pangram

is_pangram:
    xor eax, eax          ; clear mask (bits for letters seen)
    xor ecx, ecx          ; not necessary but safe

.loop:
    movzx ecx, byte [rdi] ; load next character
    test cl, cl
    jz .done              ; end of string

    ; Check if uppercase letter
    cmp cl, 'A'
    jl .next
    cmp cl, 'Z'
    jle .upper

    ; Check if lowercase letter
    cmp cl, 'a'
    jl .next
    cmp cl, 'z'
    jle .lower
    jmp .next

.upper:
    sub cl, 'A'           ; convert to index 0-25
    jmp .set_bit

.lower:
    sub cl, 'a'           ; convert to index 0-25

.set_bit:
    mov edx, 1
    shl edx, cl           ; create bit mask
    or eax, edx           ; set the bit in the mask

.next:
    inc rdi
    jmp .loop

.done:
    ; Check if all 26 bits are set (mask == (1<<26)-1)
    cmp eax, 0x03FFFFFF   ; 2^26 - 1 = 67,108,863
    sete al               ; al = 1 if equal, else 0
    movzx eax, al         ; zero-extend to 32-bit return value
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif