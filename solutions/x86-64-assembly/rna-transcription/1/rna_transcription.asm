section .text
global to_rna
to_rna:
    ; Input: RDI = const char* strand (DNA string, null-terminated)
    ;        RSI = char* buffer (output buffer for RNA string)
    ; Return: void (buffer contains converted RNA string)
    
    ; Check for null pointers
    test rdi, rdi
    jz .done
    test rsi, rsi
    jz .done
    
.loop:
    ; Load current character from DNA strand
    mov al, [rdi]
    
    ; Check for null terminator
    test al, al
    jz .end_string
    
    ; Convert DNA to RNA based on nucleotide
    cmp al, 'G'
    je .convert_G
    cmp al, 'C'
    je .convert_C
    cmp al, 'T'
    je .convert_T
    cmp al, 'A'
    je .convert_A
    
    ; For invalid characters, just copy as-is
    ; (or you could handle error differently)
    jmp .store_char
    
.convert_G:
    mov al, 'C'    ; G -> C
    jmp .store_char
    
.convert_C:
    mov al, 'G'    ; C -> G
    jmp .store_char
    
.convert_T:
    mov al, 'A'    ; T -> A
    jmp .store_char
    
.convert_A:
    mov al, 'U'    ; A -> U
    jmp .store_char
    
.store_char:
    ; Store converted character in buffer
    mov [rsi], al
    
    ; Move to next character
    inc rdi
    inc rsi
    
    ; Continue loop
    jmp .loop
    
.end_string:
    ; Null-terminate the output buffer
    mov byte [rsi], 0
    
.done:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif