UNEQUAL equ 0
EQUAL equ 1
SUBLIST equ 2
SUPERLIST equ 3

section .text
global sublist

; relation_t sublist(const int64_t *list_one, size_t list_one_count,
;                     const int64_t *list_two, size_t list_two_count);
; rdi = list_a, rsi = len_a, rdx = list_b, rcx = len_b
sublist:
    push r12
    push r13
    push r14
    push r15

    mov r12, rdi            ; list_a (can be NULL)
    mov r13, rsi            ; len_a
    mov r14, rdx            ; list_b (can be NULL)
    mov r15, rcx            ; len_b

    ; Check if equal (same length)
    cmp r13, r15
    jne .check_sublist

    ; Both empty?
    test r13, r13
    jz .equal

    ; Compare element by element
    xor eax, eax
.compare_equal:
    cmp rax, r13
    jge .equal
    mov r8, [r12 + rax*8]
    cmp r8, [r14 + rax*8]
    jne .check_sublist
    inc rax
    jmp .compare_equal

.check_sublist:
    ; Check if A is a sublist of B (A smaller, contained in B)
    cmp r13, r15
    jg .check_superlist

    ; If A is empty, it's a sublist of B
    test r13, r13
    jz .sublist

    ; Search for A in B
    xor r8, r8               ; i = start index in B
.search_sublist:
    mov r9, r15
    sub r9, r13
    cmp r8, r9
    jg .check_superlist

    xor r9, r9               ; j = 0
.compare_sublist:
    cmp r9, r13
    jge .sublist
    mov r10, [r12 + r9*8]
    mov r11, r8
    add r11, r9
    cmp r10, [r14 + r11*8]
    jne .next_sublist_pos
    inc r9
    jmp .compare_sublist

.next_sublist_pos:
    inc r8
    jmp .search_sublist

.check_superlist:
    ; Check if A is a superlist of B (B contained in A)
    cmp r13, r15
    jl .unequal

    ; If B is empty, A is a superlist of B
    test r15, r15
    jz .superlist

    ; Search for B in A
    xor r8, r8               ; i = start index in A
.search_superlist:
    mov r9, r13
    sub r9, r15
    cmp r8, r9
    jg .unequal

    xor r9, r9               ; j = 0
.compare_superlist:
    cmp r9, r15
    jge .superlist
    mov r10, [r14 + r9*8]
    mov r11, r8
    add r11, r9
    cmp r10, [r12 + r11*8]
    jne .next_superlist_pos
    inc r9
    jmp .compare_superlist

.next_superlist_pos:
    inc r8
    jmp .search_superlist

.equal:
    mov eax, EQUAL
    pop r15
    pop r14
    pop r13
    pop r12
    ret

.sublist:
    mov eax, SUBLIST
    pop r15
    pop r14
    pop r13
    pop r12
    ret

.superlist:
    mov eax, SUPERLIST
    pop r15
    pop r14
    pop r13
    pop r12
    ret

.unequal:
    mov eax, UNEQUAL
    pop r15
    pop r14
    pop r13
    pop r12
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif