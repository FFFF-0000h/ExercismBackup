section .text
global reverse
reverse:
    ; Input: rdi = pointer to null-terminated string
    
    ; First, find the length of the string and locate the end
    mov rsi, rdi      ; rsi will be start pointer
    mov rdx, rdi      ; rdx will be end pointer
    
    ; Find null terminator
find_end:
    mov al, [rdx]
    test al, al       ; Check if byte is zero (null terminator)
    jz found_end
    inc rdx
    jmp find_end

found_end:
    ; rdx now points to null terminator
    dec rdx           ; Move back to last character (before null)
    
    ; If string is empty or single character, nothing to do
    cmp rsi, rdx
    jge done
    
    ; Swap characters from both ends towards the middle
swap_loop:
    cmp rsi, rdx      ; Compare start and end pointers
    jge done          ; If start >= end, we're done
    
    ; Swap [rsi] and [rdx]
    mov al, [rsi]     ; Load char from start
    mov bl, [rdx]     ; Load char from end
    
    mov [rsi], bl     ; Store end char at start
    mov [rdx], al     ; Store start char at end
    
    ; Move pointers
    inc rsi           ; Move start pointer forward
    dec rdx           ; Move end pointer backward
    
    jmp swap_loop

done:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif