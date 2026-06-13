section .text
global find_anagrams

; Function: find_anagrams
; Input:
;   rdi - int *is_anagram (output array of 0/1 flags)
;   rsi - const char *candidates[] (array of string pointers)
;   rdx - size_t num_candidates
;   rcx - const char *subject (target word)
find_anagrams:
    push rbp
    mov rbp, rsp
    push rbx
    push r12
    push r13
    push r14
    push r15
    sub rsp, 64         ; Space for two frequency maps (32 bytes each)
    
    ; Save parameters in callee-saved registers
    mov r12, rdi        ; r12 = is_anagram output array
    mov r13, rsi        ; r13 = candidates array
    mov r14, rdx        ; r14 = num_candidates
    mov r15, rcx        ; r15 = subject
    
    ; Initialize output array to all zeros
    xor eax, eax
    mov rcx, r14
    mov rdi, r12
    rep stosd           ; Fill is_anagram with zeros
    
    ; Check for empty subject
    cmp byte [r15], 0
    je .done
    
    ; Build frequency map for subject
    mov rdi, r15
    mov rsi, rsp        ; Subject freq map at rsp
    call build_freq_map
    
    ; Loop through each candidate
    xor ebx, ebx        ; ebx = loop counter
    
.candidate_loop:
    cmp rbx, r14
    jae .done
    
    ; Get candidate pointer
    mov rdi, [r13 + rbx * 8]
    
    ; Check if candidate is same word as subject (case-insensitive)
    mov rsi, r15
    call is_same_word
    test al, al
    jnz .not_anagram
    
    ; Build frequency map for candidate
    mov rdi, [r13 + rbx * 8]
    lea rsi, [rsp + 32]  ; Candidate freq map
    call build_freq_map
    
    ; Compare frequency maps
    mov rdi, rsp         ; Subject freq map
    lea rsi, [rsp + 32]  ; Candidate freq map
    call compare_freq_maps
    test al, al
    jz .not_anagram
    
    ; It's an anagram! Mark it
    mov dword [r12 + rbx * 4], 1
    
.not_anagram:
    inc rbx
    jmp .candidate_loop
    
.done:
    add rsp, 64
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    pop rbp
    ret

; Function: build_freq_map
; Input:
;   rdi - pointer to word (null-terminated)
;   rsi - pointer to 32-byte buffer for frequency map
; Output:
;   fills buffer with character frequencies (a-z only, case-insensitive)
build_freq_map:
    push rbx
    
    ; Clear frequency map (32 bytes)
    xor eax, eax
    mov [rsi], rax
    mov [rsi + 8], rax
    mov [rsi + 16], rax
    mov [rsi + 24], rax
    
.char_loop:
    movzx eax, byte [rdi]
    test al, al
    jz .done
    
    ; Convert to lowercase if uppercase
    cmp al, 'A'
    jb .next_char
    cmp al, 'Z'
    ja .check_lower
    add al, 32          ; Convert to lowercase
    jmp .increment
.check_lower:
    cmp al, 'a'
    jb .next_char
    cmp al, 'z'
    ja .next_char
    
.increment:
    sub al, 'a'
    movzx ebx, al
    inc byte [rsi + rbx]
    
.next_char:
    inc rdi
    jmp .char_loop
    
.done:
    pop rbx
    ret

; Function: compare_freq_maps
; Input:
;   rdi - pointer to first frequency map (32 bytes)
;   rsi - pointer to second frequency map (32 bytes)
; Output:
;   al - 1 if maps are identical, 0 otherwise
compare_freq_maps:
    xor eax, eax
    xor ecx, ecx
    
.loop:
    cmp ecx, 26
    jge .equal
    
    mov al, [rdi + rcx]
    cmp al, [rsi + rcx]
    jne .not_equal
    
    inc ecx
    jmp .loop
    
.equal:
    mov al, 1
    ret
    
.not_equal:
    xor al, al
    ret

; Function: is_same_word
; Input:
;   rdi - first word
;   rsi - second word
; Output:
;   al - 1 if words are identical (case-insensitive), 0 otherwise
is_same_word:
    push rbx
    
.char_loop:
    mov al, [rdi]
    mov bl, [rsi]
    
    ; Convert al to lowercase
    cmp al, 'A'
    jb .convert_bl
    cmp al, 'Z'
    ja .convert_bl
    add al, 32
    
.convert_bl:
    cmp bl, 'A'
    jb .compare
    cmp bl, 'Z'
    ja .compare
    add bl, 32
    
.compare:
    cmp al, bl
    jne .not_same
    
    ; Both at end of string?
    test al, al
    jz .same
    
    inc rdi
    inc rsi
    jmp .char_loop
    
.same:
    mov al, 1
    pop rbx
    ret
    
.not_same:
    xor al, al
    pop rbx
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif