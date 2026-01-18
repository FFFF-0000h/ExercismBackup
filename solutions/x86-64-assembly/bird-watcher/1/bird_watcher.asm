; Everything that comes after a semicolon (;) is a comment

section .text

; You should implement functions in the .text section
global last_week_counts
global current_week_counts
global save_count
global today_count
global update_today_count
global update_week_counts

section .data
; Initial values
initial_last_week: dq 0x0004080703050200  ; 0, 2, 5, 3, 7, 8, 4, 0

section .bss
last_week:      resb 8    ; Last week counts
current_week:   resb 8    ; Current week counts  
days_filled:    resb 1    ; Days filled in current week
initialized:    resb 1    ; Flag to track if we've initialized

section .text

; Initialize once
_init_once:
    cmp byte [rel initialized], 1
    je .done
    
    ; Copy initial last week
    mov rax, [rel initial_last_week]
    mov [rel last_week], rax
    
    ; Zero current week and days_filled
    mov qword [rel current_week], 0
    mov byte [rel days_filled], 0
    
    ; Mark as initialized
    mov byte [rel initialized], 1
.done:
    ret

last_week_counts:
    call _init_once
    mov rax, [rel last_week]
    ret

current_week_counts:
    call _init_once
    mov rax, [rel current_week]
    movzx rdx, byte [rel days_filled]
    ret

save_count:
    call _init_once
    
    ; Check if current week is full
    mov al, byte [rel days_filled]
    cmp al, 7
    jne .add_to_current
    
    ; Week is full, move current to last
    mov rax, [rel current_week]
    mov [rel last_week], rax
    
    ; Clear current week
    mov qword [rel current_week], 0
    mov byte [rel days_filled], 0
    xor al, al
    
.add_to_current:
    lea rsi, [rel current_week]
    movzx rcx, al
    mov [rsi + rcx], dil
    inc byte [rel days_filled]
    ret

today_count:
    call _init_once
    movzx rax, byte [rel days_filled]
    test rax, rax
    jz .return_zero
    dec rax
    lea rsi, [rel current_week]
    mov al, [rsi + rax]
    ret
.return_zero:
    xor eax, eax
    ret

update_today_count:
    call _init_once
    movzx rcx, byte [rel days_filled]
    test rcx, rcx
    jz .done
    dec rcx
    lea rsi, [rel current_week]
    add [rsi + rcx], dil
.done:
    ret

update_week_counts:
    call _init_once
    mov rax, [rel current_week]
    mov [rel last_week], rax
    mov [rel current_week], rdi
    mov byte [rel days_filled], 7
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif