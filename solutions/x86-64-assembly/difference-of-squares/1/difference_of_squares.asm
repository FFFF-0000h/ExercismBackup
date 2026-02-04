section .text
global square_of_sum
global sum_of_squares
global difference_of_squares

square_of_sum:
    mov     rax, rdi        ; get input
    mov     rcx, rdi        ; copy input
    add     rcx, 1          ; increment
    imul    rax, rcx        ; multiply both n * (n + 1)
    shr     rax, 1          ; div by 2
    mov     rcx, rax        ; move
    imul    rax, rcx        ; square
    ret
sum_of_squares:
    mov     rax, rdi        ; get input
    mov     rcx, rdi        ; copy input
    add     rcx, 1          ; increment
    imul    rax, rcx        ; multiply both n * (n + 1)
    mov     rcx, rdi
    shl     rcx, 1          ; multiply by 2
    add     rcx, 1          ; increment
    imul    rax, rcx        ; multiply both prod * (2n + 1)
    mov     rcx, 6
    xor     rdx, rdx        ; clear for division
    div     rcx             ; div rax by 6
    ret
difference_of_squares:
    push    rdi             ; save n on stack
    call    square_of_sum
    mov     rbx, rax        ; save result in rbx
    pop     rdi             ; restore n
    push    rbx             ; save square_of_sum for later
    call    sum_of_squares
    pop     rbx             ; get square_of_sum
    sub     rbx, rax        ; difference
    mov     rax, rbx        ; move to result
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
