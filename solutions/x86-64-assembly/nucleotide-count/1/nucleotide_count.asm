section .text
global nucleotide_counts
nucleotide_counts:
    xor rax, rax
    mov [rsi], rax
    mov [rsi + 8], rax
    mov [rsi + 16], rax
    mov [rsi + 24], rax
iteration:
    mov al, [rdi]
    cmp rax, 0
    je return
    inc rdi
    cmp al, 'A'
    je adenine
    cmp al, 'C'
    je cytosine
    cmp al, 'G'
    je guanine
    cmp al, 'T'
    je thymine
    jmp invalid
    jmp iteration
adenine:
    inc qword [rsi]
    ; inc [rsi]
    jmp iteration
cytosine:
    inc qword [rsi + 8]
    jmp iteration
guanine:
    inc qword [rsi + 16]
    jmp iteration
thymine:
    inc qword [rsi + 24]
    jmp iteration
invalid:
    mov rax, -1
    mov [rsi], rax
    mov [rsi + 8], rax
    mov [rsi + 16], rax
    mov [rsi + 24], rax
return:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif