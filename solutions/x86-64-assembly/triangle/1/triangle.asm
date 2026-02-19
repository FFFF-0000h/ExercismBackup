section .text

global is_equilateral
is_equilateral:
    movsd xmm0, [rsp+8]   ; a
    movsd xmm1, [rsp+16]  ; b  
    movsd xmm2, [rsp+24]  ; c
    xorpd xmm3, xmm3
    ucomisd xmm0, xmm3
    jbe .false
    ucomisd xmm1, xmm3  
    jbe .false
    ucomisd xmm2, xmm3
    jbe .false
    ucomisd xmm0, xmm1
    jne .false
    ucomisd xmm0, xmm2
    jne .false
    mov eax, 1
    ret
.false:
    mov eax, 0
    ret

global is_isosceles
is_isosceles:
    movsd xmm0, [rsp+8]   ; a
    movsd xmm1, [rsp+16]  ; b  
    movsd xmm2, [rsp+24]  ; c
    ; no side less than 0
    xorpd xmm3, xmm3
    ucomisd xmm0, xmm3
    jbe .false
    ucomisd xmm1, xmm3  
    jbe .false
    ucomisd xmm2, xmm3
    jbe .false
    ; triangle inequality
    movapd xmm4, xmm0
    addsd xmm4, xmm1
    ucomisd xmm4, xmm2
    jbe .false
    movapd xmm4, xmm0
    addsd xmm4, xmm2
    ucomisd xmm4, xmm1
    jbe .false
    movapd xmm4, xmm1
    addsd xmm4, xmm2
    ucomisd xmm4, xmm0
    jbe .false
    ; check any two sides equal
    ucomisd xmm0, xmm1
    je .true
    ucomisd xmm0, xmm2
    je .true
    ucomisd xmm1, xmm2
    je .true
.false:
    mov eax, 0
    ret
.true:
    mov eax, 1
    ret

global is_scalene
is_scalene:
    movsd xmm0, [rsp+8]   ; a
    movsd xmm1, [rsp+16]  ; b  
    movsd xmm2, [rsp+24]  ; c
    ; no side less than 0
    xorpd xmm3, xmm3
    ucomisd xmm0, xmm3
    jbe .false
    ucomisd xmm1, xmm3  
    jbe .false
    ucomisd xmm2, xmm3
    jbe .false
    ; triangle inequality
    movapd xmm4, xmm0
    addsd xmm4, xmm1
    ucomisd xmm4, xmm2
    jbe .false
    movapd xmm4, xmm0
    addsd xmm4, xmm2
    ucomisd xmm4, xmm1
    jbe .false
    movapd xmm4, xmm1
    addsd xmm4, xmm2
    ucomisd xmm4, xmm0
    jbe .false
    ; check if no side equals
    ucomisd xmm0, xmm1
    je .false
    ucomisd xmm0, xmm2
    je .false
    ucomisd xmm1, xmm2
    je .false
    mov eax, 1
    ret
.false:
    mov eax, 0
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif