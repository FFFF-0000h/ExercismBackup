; Everything that comes after a semicolon (;) is a comment.

section .text

; You should implement functions in the .text section.
; A skeleton is provided for the first function.

; the global directive makes a function visible to the test files.
global front_door_response
front_door_response:
    ; This function takes the address in memory for a line of the poem as an argument.
    ; It returns the first letter of that line, as a ASCII-encoded character.
    
    ; RDI contains the address of the string
    mov al, [rdi]        ; Load first character into AL
    ret

global front_door_password
front_door_password:
    ; This function takes as argument the address in memory for a string containing the combined letters you found in task 1.
    ; It must modify this string in-place, making it correctly capitalized.
    ; The function has no return value.
    
    ; RDI contains the address of the string
    ; Capitalize first letter (if it's lowercase)
    mov al, [rdi]        ; Load first character
    cmp al, 'a'
    jl .check_end        ; If less than 'a', not lowercase letter
    cmp al, 'z'
    jg .check_end        ; If greater than 'z', not lowercase letter
    sub al, 32           ; Convert to uppercase: 'a' - 'A' = 32
    mov [rdi], al        ; Store back
    
.check_end:
    ; Make remaining letters lowercase
    mov rsi, rdi
    inc rsi              ; Move to second character
    
.loop:
    mov al, [rsi]
    test al, al          ; Check for null terminator
    jz .done
    
    cmp al, 'A'
    jl .next             ; If less than 'A', not uppercase letter
    cmp al, 'Z'
    jg .next             ; If greater than 'Z', not uppercase letter
    add al, 32           ; Convert to lowercase: 'A' + 32 = 'a'
    mov [rsi], al        ; Store back
    
.next:
    inc rsi
    jmp .loop
    
.done:
    ret

global back_door_response
back_door_response:
    ; This function takes as argument the address in memory for a line of the poem.
    ; It returns the last letter of that line that is not a whitespace character, as a ASCII-encoded character.
    
    ; RDI contains the address of the string
    mov rsi, rdi         ; Copy address to RSI
    
    ; Find the end of the string
.find_end:
    mov al, [rsi]
    test al, al          ; Check for null terminator
    jz .found_end
    inc rsi
    jmp .find_end
    
.found_end:
    dec rsi              ; Move back from null terminator
    
    ; Skip trailing whitespace and punctuation
.skip_whitespace:
    cmp rsi, rdi         ; Check if we've reached the beginning
    jl .no_letter        ; If we've gone past beginning, no letter found
    
    mov al, [rsi]
    
    ; Check if character is a letter
    cmp al, 'A'
    jl .not_letter       ; Less than 'A'
    cmp al, 'Z'
    jle .found_letter    ; Between 'A' and 'Z' inclusive
    cmp al, 'a'
    jl .not_letter       ; Between 'Z' and 'a'
    cmp al, 'z'
    jle .found_letter    ; Between 'a' and 'z' inclusive
    
.not_letter:
    dec rsi              ; Move to previous character
    jmp .skip_whitespace
    
.found_letter:
    mov al, [rsi]        ; Get the last letter
    ret
    
.no_letter:
    xor al, al           ; Return null character if no letter found
    ret

global back_door_password
back_door_password:
    ; This function takes as arguments, in this order:
    ; 1. RDI: The address in memory for a buffer where the resulting string will be stored.
    ; 2. RSI: The address in memory for a string containing the combined letters you found in task 3.
    ; It should store the polite version of the capitalized password in the buffer.
    ; A polite version is correctly capitalized and has ", please." added at the end.
    ; The function has no return value.
    
    ; Save registers that we'll modify
    push rbx
    push r12
    push r13
    
    mov rbx, rdi         ; RBX = buffer address
    mov r12, rsi         ; R12 = input string address
    
    ; First, capitalize the input word (similar to front_door_password but for a single word)
    
    ; Capitalize first letter
    mov al, [r12]        ; Load first character
    cmp al, 'a'
    jl .copy_rest_capitalized
    cmp al, 'z'
    jg .copy_rest_capitalized
    sub al, 32           ; Convert to uppercase
    mov [rbx], al        ; Store in buffer
    jmp .copy_rest
    
.copy_rest_capitalized:
    mov al, [r12]
    mov [rbx], al        ; Store first character as-is
    
.copy_rest:
    ; Copy the rest of the word, making letters lowercase
    mov r13, r12
    inc r13              ; R13 points to second character of input
    lea rdi, [rbx + 1]   ; RDI points to second position of buffer
    
.copy_loop:
    mov al, [r13]
    test al, al          ; Check for null terminator
    jz .add_please
    
    ; Check if uppercase and convert to lowercase
    cmp al, 'A'
    jl .store_char
    cmp al, 'Z'
    jg .store_char
    add al, 32           ; Convert to lowercase
    
.store_char:
    mov [rdi], al
    inc r13
    inc rdi
    jmp .copy_loop
    
.add_please:
    ; Add ", please." to the end
    mov byte [rdi], ','
    inc rdi
    mov byte [rdi], ' '
    inc rdi
    mov byte [rdi], 'p'
    inc rdi
    mov byte [rdi], 'l'
    inc rdi
    mov byte [rdi], 'e'
    inc rdi
    mov byte [rdi], 'a'
    inc rdi
    mov byte [rdi], 's'
    inc rdi
    mov byte [rdi], 'e'
    inc rdi
    mov byte [rdi], '.'
    inc rdi
    mov byte [rdi], 0    ; Null terminator
    
    ; Restore registers
    pop r13
    pop r12
    pop rbx
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif