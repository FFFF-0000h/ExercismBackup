section .text
global score
score:
    ; uint8_t score(double x, double y)
    ; Input: xmm0 = x (double), xmm1 = y (double)
    ; Output: al = score (0, 1, 5, or 10)
    ; Based on distance from origin: sqrt(x² + y²)
    
    ; Calculate x² + y²
    mulsd xmm0, xmm0      ; xmm0 = x²
    mulsd xmm1, xmm1      ; xmm1 = y²
    addsd xmm0, xmm1      ; xmm0 = x² + y²
    
    ; Compare with radius thresholds
    ; We'll compare squared distances to avoid sqrt
    ; Thresholds squared: 
    ;   outer circle (radius 10): 10² = 100
    ;   middle circle (radius 5): 5² = 25  
    ;   inner circle (radius 1): 1² = 1
    
    ; Load comparison constants
    mov rax, 100
    movq xmm2, rax        ; xmm2 = 100.0
    cvtsi2sd xmm2, rax
    
    mov rax, 25
    movq xmm3, rax        ; xmm3 = 25.0
    cvtsi2sd xmm3, rax
    
    mov rax, 1
    movq xmm4, rax        ; xmm4 = 1.0
    cvtsi2sd xmm4, rax
    
    ; Compare distances
    comisd xmm0, xmm2     ; Compare with 100
    ja .outside           ; >100: outside target (0 points)
    
    comisd xmm0, xmm3     ; Compare with 25
    ja .outer_circle      ; >25 but ≤100: outer circle (1 point)
    
    comisd xmm0, xmm4     ; Compare with 1
    ja .middle_circle     ; >1 but ≤25: middle circle (5 points)
    
    ; ≤1: inner circle (10 points)
    mov al, 10
    ret
    
.outside:
    xor al, al           ; 0 points
    ret
    
.outer_circle:
    mov al, 1            ; 1 point
    ret
    
.middle_circle:
    mov al, 5            ; 5 points
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif