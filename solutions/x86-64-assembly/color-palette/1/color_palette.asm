; Everything that comes after a semicolon (;) is a comment

; Define the constants 'RED', 'GREEN' and 'BLUE'
; They must be accessible from other source files
global RED, GREEN, BLUE

; Define the variable 'base_color' with the default value of 0xFFFFFF00
; It must be accessible from other source files
global base_color

section .data
    ; Constants for primary colors (32-bit values)
    RED:    dd 0xFF000000   ; Red: FF 00 00 00
    GREEN:  dd 0x00FF0000   ; Green: 00 FF 00 00  
    BLUE:   dd 0x0000FF00   ; Blue: 00 00 FF 00
    
    ; Base color variable with default value white (0xFFFFFF00)
    base_color: dd 0xFFFFFF00   ; White: FF FF FF 00

section .text

; the global directive makes a function visible to the test files
global get_color_value
get_color_value:
    ; This function takes the address for a color as parameter
    ; It must return the 32-bit value associated with the color
    ; Parameter: address in RDI (System V AMD64 ABI)
    
    ; Load the 32-bit color value from the given address
    mov eax, [rdi]   ; Load 32-bit value from address in RDI into EAX
    
    ret

global add_base_color
add_base_color:
    ; This function takes the address for a color as parameter
    ; It saves the 32-bit value associated with this color in the variable 'base_color'
    ; This function has no return value
    ; Parameter: address in RDI (System V AMD64 ABI)
    
    ; Load the 32-bit color value from the given address
    mov eax, [rdi]   ; Load color value into EAX
    
    ; Save it to the base_color variable using RIP-relative addressing for PIE
    lea rcx, [rel base_color]  ; Get address of base_color
    mov [rcx], eax             ; Store the value
    
    ret

global make_color_combination
make_color_combination:
    ; This function takes the following parameters:
    ; - RDI: The address where the 32-bit value for the combined color should be stored.
    ; - RSI: The address of a secondary color in the color table.
    ; It should call 'combining_function' with the 32-bit value for base and secondary colors
    ; and store the result in the passed address
    ; This function has no return value
    
    ; Save non-volatile registers (System V ABI: RBX, RBP, R12-R15 must be preserved)
    push rbx
    push r12
    
    ; Save parameters in preserved registers since combining_function may clobber RDI, RSI
    mov rbx, rdi      ; Save result address in RBX
    mov r12, rsi      ; Save secondary color address in R12
    
    ; Prepare parameters for combining_function call
    ; First parameter (RDI): base_color value
    lea rax, [rel base_color]   ; Get address of base_color
    mov edi, [rax]              ; Load base_color value into EDI
    
    ; Second parameter (RSI): secondary color value
    mov esi, [r12]              ; Load secondary color value from its address
    
    ; Call the external combining_function (assumes it follows System V ABI)
    ; combining_function takes two 32-bit parameters and returns 32-bit result in EAX
    extern combining_function
    call combining_function
    
    ; Store the result (in EAX) at the result address (saved in RBX)
    mov [rbx], eax
    
    ; Restore non-volatile registers
    pop r12
    pop rbx
    
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif