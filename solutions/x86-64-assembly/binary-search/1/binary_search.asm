section .text
global find

; int find(int *array, int size, int value)
;   array: rdi
;   size:  esi
;   value: edx
;   returns index in eax, or -1 if not found

find:
    ; If size <= 0, return -1
    cmp     esi, 0
    jle     .not_found

    ; Initialize left = 0, right = size - 1
    xor     r8d, r8d          ; left = 0
    mov     r9d, esi
    dec     r9d               ; right = size - 1

.loop:
    ; Check if left > right
    cmp     r8d, r9d
    jg      .not_found

    ; mid = (left + right) / 2
    mov     eax, r8d
    add     eax, r9d
    shr     eax, 1            ; eax = mid

    ; Load array[mid]
    mov     ecx, eax          ; keep mid in ecx for later
    mov     r10d, [rdi + rax*4]   ; r10d = array[mid]

    ; Compare with value
    cmp     r10d, edx
    je      .found            ; equal -> found
    jl      .greater          ; less -> value in right half

    ; Greater: search left half
    lea     r9d, [rcx - 1]    ; right = mid - 1
    jmp     .loop

.greater:
    ; Search right half
    lea     r8d, [rcx + 1]    ; left = mid + 1
    jmp     .loop

.found:
    mov     eax, ecx          ; return mid
    ret

.not_found:
    mov     eax, -1
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif