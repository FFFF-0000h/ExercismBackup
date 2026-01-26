section .text

; All functions must be declared global
global time_to_make_juice
global time_to_prepare
global limes_to_cut
global remaining_orders

time_to_make_juice:
    ; edi = juice ID
    cmp edi, 1
    je .time1
    cmp edi, 2
    je .time3
    cmp edi, 3
    je .time3
    cmp edi, 4
    je .time4
    cmp edi, 5
    je .time5
    cmp edi, 6
    je .time4
    cmp edi, 7
    je .time7
    cmp edi, 8
    je .time10
    
    ; Default (shouldn't happen)
    mov eax, 0
    ret
    
.time1:
    mov eax, 1
    ret
.time3:
    mov eax, 3
    ret
.time4:
    mov eax, 4
    ret
.time5:
    mov eax, 5
    ret
.time7:
    mov eax, 7
    ret
.time10:
    mov eax, 10
    ret

time_to_prepare:
    ; rdi = array pointer, esi = count
    xor eax, eax          ; total = 0
    test esi, esi
    jz .done
    
    ; Save callee-saved registers
    push rbx
    push r12
    push r13
    
    mov ebx, esi          ; ebx = count
    mov r12, rdi          ; r12 = array pointer
    xor r13d, r13d        ; r13d = total time
    xor rcx, rcx          ; rcx = index (64-bit for addressing)
    
.loop:
    ; Get juice ID - use 64-bit register for indexing
    mov edi, [r12 + rcx*4]
    
    ; Save registers before call
    push rcx
    push rbx
    push r12
    push r13
    
    ; Call time_to_make_juice
    call time_to_make_juice
    
    ; Restore registers and add to total
    pop r13
    add r13d, eax         ; Add preparation time to total
    pop r12
    pop rbx
    pop rcx
    
    ; Next element
    inc rcx
    cmp ecx, ebx          ; Compare 32-bit parts
    jl .loop
    
    ; Return total
    mov eax, r13d
    
    ; Restore callee-saved registers
    pop r13
    pop r12
    pop rbx
    
.done:
    ret

limes_to_cut:
    ; edi = wedges needed, rsi = array pointer, edx = count
    xor eax, eax          ; limes cut = 0
    xor ecx, ecx          ; wedges obtained = 0
    xor r8, r8            ; r8 = index (64-bit for addressing)
    mov r9d, edx          ; r9d = count
    
    ; Check if count is 0
    test r9d, r9d
    jz .done_limes
    
.loop_limes:
    ; Check if we have enough wedges
    cmp ecx, edi
    jge .done_limes
    
    ; Check if we've processed all limes
    cmp r8d, r9d          ; Compare 32-bit parts
    jge .done_limes
    
    ; Get lime size - use 64-bit register for addressing
    movzx r10d, byte [rsi + r8]
    
    ; Add wedges based on size
    cmp r10d, 83  ; 'S'
    je .small
    cmp r10d, 77  ; 'M'
    je .medium
    cmp r10d, 76  ; 'L'
    je .large
    jmp .next_lime  ; Unknown size
    
.small:
    add ecx, 6
    inc eax
    jmp .next_lime
    
.medium:
    add ecx, 8
    inc eax
    jmp .next_lime
    
.large:
    add ecx, 10
    inc eax
    
.next_lime:
    inc r8
    jmp .loop_limes
    
.done_limes:
    ret

remaining_orders:
    ; edi = time left, rsi = array pointer
    push rbx
    push r12
    push r13
    
    xor eax, eax          ; eax = juices made (initialize to 0)
    mov ebx, edi          ; ebx = remaining time
    mov r12, rsi          ; r12 = array pointer
    xor r13, r13          ; r13 = index (64-bit for addressing)
    
.loop_orders:
    ; Check if we have time left to START a juice
    ; We need at least 1 minute to start any juice
    cmp ebx, 1
    jl .done_orders       ; If time < 1, can't start any more juices
    
    ; Get juice ID - use 64-bit register for indexing
    mov edi, [r12 + r13*4]
    
    ; Save registers before call
    push rax              ; save juices made count
    push rbx              ; save remaining time
    push r12              ; save array pointer
    push r13              ; save index
    
    ; Get preparation time
    call time_to_make_juice
    mov ecx, eax          ; ecx = preparation time
    
    ; Restore registers
    pop r13
    pop r12
    pop rbx
    pop rax               ; rax = juices made count
    
    ; She starts and finishes this juice
    inc eax               ; increment juices made count
    
    ; Subtract preparation time from remaining time
    sub ebx, ecx
    
    ; Next juice
    inc r13
    jmp .loop_orders
    
.done_orders:
    ; eax already contains the correct return value (juices made count)
    pop r13
    pop r12
    pop rbx
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif