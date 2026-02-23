section .text
global square
square:
    ; Provide your implementation here
    mov rax, 0    
    mov rbx, 1
loop_square:
    cmp rdi, 0
    jle done_square
    cmp rdi, 64
    jg done_square
    mov rax, rbx
    add rbx, rbx ; multiply by 2
    dec rdi
    jmp loop_square
done_square:
    ret

global total
total:
    ; Provide your implementation here
    mov rax, 0    
    mov rbx, 1
    mov rcx, 64
loop_total:
    cmp rcx, 0
    jle done_total
    add rax, rbx
    add rbx, rbx ; multiply by 2
    dec rcx
    jmp loop_total
done_total:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
