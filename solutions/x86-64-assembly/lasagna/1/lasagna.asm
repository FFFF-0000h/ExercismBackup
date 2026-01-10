; Everything that comes after a semicolon (;) is a comment

; Assembler-time constants may be defined using 'equ'
EXPECTED_OVEN_TIME equ 40
MINUTES_PER_LAYER equ 2

section .text

; You should implement functions in the .text section

; the global directive makes a function visible to the test files
global expected_minutes_in_oven
expected_minutes_in_oven:
    ; This function has no arguments and must return a number
    mov eax, EXPECTED_OVEN_TIME
    ret

global remaining_minutes_in_oven
remaining_minutes_in_oven:
    ; This function takes one number as argument and must return a number
    ; Argument: edi = minutes_elapsed
    mov eax, EXPECTED_OVEN_TIME
    sub eax, edi
    ret

global preparation_time_in_minutes
preparation_time_in_minutes:
    ; This function takes one number as argument and must return a number
    ; Argument: edi = number_of_layers
    mov eax, edi
    imul eax, MINUTES_PER_LAYER
    ret

global elapsed_time_in_minutes
elapsed_time_in_minutes:
    ; This function takes two numbers as arguments and must return a number
    ; Arguments: edi = number_of_layers, esi = minutes_in_oven
    ; Return: preparation_time + minutes_in_oven
    mov eax, edi
    imul eax, MINUTES_PER_LAYER  ; eax = preparation_time
    add eax, esi                  ; eax = preparation_time + minutes_in_oven
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif