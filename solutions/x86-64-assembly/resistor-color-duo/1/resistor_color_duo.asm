section .text
global value

; int value(const char *first, const char *second, const char *third);
value:
    push r12
    push r13
    mov  r12, rdi        ; first color
    mov  r13, rsi        ; second color

    ; process first color -> tens digit
    mov  rdi, r12
    call color_to_digit
    mov  ecx, eax        ; ecx = first digit

    ; process second color -> ones digit
    mov  rdi, r13
    call color_to_digit  ; eax = second digit

    imul ecx, ecx, 10
    add  eax, ecx

    pop  r13
    pop  r12
    ret

; int color_to_digit(const char *name)
; Uses only immediate character comparisons (no .rodata strings)
color_to_digit:
    mov   al, byte [rdi]
    cmp   al, 'b'
    je    .check_b
    cmp   al, 'r'
    je    .is_red
    cmp   al, 'o'
    je    .is_orange
    cmp   al, 'y'
    je    .is_yellow
    cmp   al, 'g'
    je    .check_g
    cmp   al, 'v'
    je    .is_violet
    cmp   al, 'w'
    je    .is_white
    jmp   .default

.check_b:
    mov   al, byte [rdi + 1]
    cmp   al, 'l'
    je    .check_bl
    cmp   al, 'r'
    je    .is_brown
    jmp   .default

.check_bl:
    mov   al, byte [rdi + 2]
    cmp   al, 'a'
    je    .is_black
    cmp   al, 'u'
    je    .is_blue
    jmp   .default

.check_g:
    mov   al, byte [rdi + 1]
    cmp   al, 'r'
    jne   .default
    mov   al, byte [rdi + 2]
    cmp   al, 'e'
    jne   .default
    mov   al, byte [rdi + 3]
    cmp   al, 'e'
    je    .is_green
    cmp   al, 'y'
    je    .is_grey
    jmp   .default

.is_black:
    xor   eax, eax
    ret
.is_brown:
    mov   eax, 1
    ret
.is_red:
    mov   eax, 2
    ret
.is_orange:
    mov   eax, 3
    ret
.is_yellow:
    mov   eax, 4
    ret
.is_green:
    mov   eax, 5
    ret
.is_blue:
    mov   eax, 6
    ret
.is_violet:
    mov   eax, 7
    ret
.is_grey:
    mov   eax, 8
    ret
.is_white:
    mov   eax, 9
    ret
.default:
    xor   eax, eax
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif