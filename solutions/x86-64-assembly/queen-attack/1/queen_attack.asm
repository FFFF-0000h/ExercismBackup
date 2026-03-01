section .text
global can_create
global can_attack

; int can_create(int row, int column)
; Returns non-zero if (row, column) is within 0..7 inclusive.
can_create:
    ; edi = row, esi = column
    cmp edi, 0
    jl .invalid
    cmp edi, 7
    jg .invalid
    cmp esi, 0
    jl .invalid
    cmp esi, 7
    jg .invalid
    mov eax, 1
    ret
.invalid:
    xor eax, eax
    ret

; int can_attack(int white_row, int white_column, int black_row, int black_column)
; Returns non-zero if the two queens can attack each other.
can_attack:
    ; edi = white_row, esi = white_column, edx = black_row, ecx = black_column
    ; same row?
    cmp edi, edx
    je .attack
    ; same column?
    cmp esi, ecx
    je .attack
    ; diagonal: |white_row - black_row| == |white_column - black_column|
    ; compute abs(white_row - black_row)
    mov eax, edi
    sub eax, edx            ; eax = diff row
    mov ebx, eax
    sar ebx, 31             ; ebx = sign mask (all 1s if negative)
    xor eax, ebx
    sub eax, ebx            ; eax = abs(diff row)
    ; compute abs(white_column - black_column)
    mov edx, esi
    sub edx, ecx            ; edx = diff col
    mov ecx, edx
    sar ecx, 31             ; ecx = sign mask
    xor edx, ecx
    sub edx, ecx            ; edx = abs(diff col)
    cmp eax, edx
    je .attack
    xor eax, eax
    ret
.attack:
    mov eax, 1
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif