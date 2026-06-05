section .text

global add_bonus
add_bonus:
    lea  rax, [rdi + rsi]      ; sum = total + bonus
    mov  rcx, 999999
    cmp  rax, rcx
    cmovg rax, rcx             ; if sum > 999999, rax = 999999
    ret

global compare_scores
compare_scores:
    xor  eax, eax
    xor  ecx, ecx
    cmp  rdi, rsi              ; compare first and second score
    setg al                    ; al = 1 if rdi > rsi
    setl cl                    ; cl = 1 if rdi < rsi
    sub  al, cl                ; al = 1, 0, or -1
    movsx rax, al              ; sign‑extend to 64‑bit
    ret

global validate_score
validate_score:
    mov  rax, rdi              ; rax = score
    cmp  rax, rsi              ; score vs min
    cmovl rax, rsi             ; if score < min, rax = min
    cmp  rax, rdx              ; rax vs max
    cmovg rax, rdx             ; if rax > max, rax = max
    ret

global top_two
top_two:
    ; Initialisation – keep exactly as supplied
    xor  r8d, r8d              ; first  = 0
    xor  r9d, r9d              ; second = 0
    xor  ecx, ecx              ; index  = 0
    test rdx, rdx
    jz   .done

.loop:
    mov  rax, [rsi + rcx*8]    ; candidate = array[index]
    inc  rcx                   ; ++index

    ; new_first = max(candidate, first)
    mov  r10, r8
    cmp  rax, r10
    cmovg r10, rax

    ; min_candidate_first = min(candidate, first)
    mov  r11, rax
    cmp  r11, r8
    cmovge r11, r8

    ; new_second = max(min_candidate_first, second)
    cmp  r11, r9
    cmovl r11, r9

    ; commit updates
    mov  r8, r10
    mov  r9, r11

    cmp  rcx, rdx
    jb   .loop                 ; only permitted jump inside loop

.done:
    mov  [rdi], r8             ; store first
    mov  [rdi + 8], r9         ; store second
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif