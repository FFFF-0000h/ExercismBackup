section .text

; Constants
PRIVATE_KEY equ 0b1011001100111100

; Function 1: extract_higher_bits
global extract_higher_bits
extract_higher_bits:
    mov ax, di
    shr ax, 8
    movzx rax, al
    ret

; Function 2: extract_lower_bits
global extract_lower_bits
extract_lower_bits:
    movzx rax, dil
    ret

; Function 3: extract_redundant_bits
global extract_redundant_bits
extract_redundant_bits:
    push rbx
    mov ax, di
    shr ax, 8
    mov bl, al
    mov al, dil
    and al, bl
    movzx rax, al
    pop rbx
    ret

; Function 4: set_message_bits
global set_message_bits
set_message_bits:
    push rbx
    mov ax, di
    shr ax, 8
    mov bl, al
    mov al, dil
    or al, bl
    movzx rax, al
    pop rbx
    ret

; Function 5: rotate_private_key
global rotate_private_key
rotate_private_key:
    push rbx
    push rcx
    
    mov bx, di
    call extract_redundant_bits
    movzx cx, al
    popcnt cx, cx
    
    mov ax, PRIVATE_KEY
    rol ax, cl
    
    pop rcx
    pop rbx
    ret

; Function 6: format_private_key (CORRECTED)
global format_private_key
format_private_key:
    push rbx
    push rcx
    
    ; Save argument
    mov bx, di
    
    ; Get rotated private key
    call rotate_private_key
    
    ; ax now contains rotated private key
    ; al = low byte (base value)
    ; ah = high byte (mask)
    
    ; XOR base value with mask (flip bits where mask is 1)
    xor al, ah
    
    ; NOT all bits in result
    not al
    
    movzx rax, al
    pop rcx
    pop rbx
    ret

; Function 7: decrypt_message
global decrypt_message
decrypt_message:
    push rbx
    push rcx
    
    mov bx, di
    
    ; Get formatted private key (high byte)
    call format_private_key
    mov ch, al
    
    ; Get message with bits set (low byte)
    mov di, bx
    call set_message_bits
    mov cl, al
    
    ; Combine into 16-bit result
    mov ah, ch
    mov al, cl
    
    movzx rax, ax
    pop rcx
    pop rbx
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif