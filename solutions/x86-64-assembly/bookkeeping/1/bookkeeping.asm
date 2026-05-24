section .bss
    saved_transaction resq 1

section .text
global remember_transaction
remember_transaction:
    ; store the function address in memory
    mov [rel saved_transaction], rdi
    ret

global apply_remembered
apply_remembered:
    ; rdi already contains the balance – tail‑call the saved transaction
    jmp qword [rel saved_transaction]

global register_transaction
register_transaction:
    ; rdi = dispatch table, rsi = index, rdx = transaction
    mov [rdi + rsi*8], rdx
    ret

global select_transaction
select_transaction:
    ; rdi = table, rsi = index, rdx = balance
    mov rax, [rdi + rsi*8]   ; load transaction address
    mov rdi, rdx              ; balance becomes the argument
    jmp rax                   ; tail‑call the transaction

global process_statement
process_statement:
    ; align stack to 16 bytes – 4 pushes = 32 bytes
    push rbp
    push r14
    push r13
    push r12
    mov r12, rsi               ; array pointer
    mov r13, rdx               ; transaction count
    test r13, r13
    jz .done
.loop:
    ; rdi contains the running balance
    call qword [r12]           ; apply transaction
    mov rdi, rax               ; result becomes next balance
    add r12, 8
    dec r13
    jnz .loop
.done:
    mov rax, rdi               ; final balance
    pop r12
    pop r13
    pop r14
    pop rbp
    ret

global process_with_guard
process_with_guard:
    ; align stack to 16 bytes – 6 pushes = 48 bytes
    push rbp
    push r15
    push r14
    push r13
    push r12
    push rbx
    mov rbx, rdi               ; running balance
    mov r12, rsi               ; array pointer
    mov r13, rdx               ; transaction count
    mov r14, rcx               ; guard function
    xor r15d, r15d             ; approved = 0
    test r13, r13
    jz .done
.loop:
    mov rdi, rbx               ; argument for transaction
    call qword [r12]           ; tentative = transaction(balance)
    mov rbp, rax               ; save tentative in callee‑saved rbp
    mov rdi, rax               ; argument for guard
    call r14                   ; guard(tentative)
    test rax, rax
    jz .skip                   ; guard returned 0 → reject
    mov rbx, rbp               ; accept: update running balance
    inc r15                    ; count approved
.skip:
    add r12, 8
    dec r13
    jnz .loop
.done:
    mov rax, rbx               ; final balance
    mov rdx, r15               ; number of approved transactions
    pop rbx
    pop r12
    pop r13
    pop r14
    pop r15
    pop rbp
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif