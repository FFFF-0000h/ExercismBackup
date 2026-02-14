section .rodata
earth_year_seconds: dd 31557600.0  ; float: seconds in an Earth year

; Orbital periods relative to Earth years
planet_periods:
    dd 0.2408467      ; Mercury
    dd 0.61519726     ; Venus  
    dd 1.0            ; Earth
    dd 1.8808158      ; Mars
    dd 11.862615      ; Jupiter
    dd 29.447498      ; Saturn
    dd 84.016846      ; Uranus
    dd 164.79132      ; Neptune

section .text
global age
age:
    ; Function signature: float age(enum planet planet, int seconds)
    ; rdi = planet index (0-7)
    ; rsi = seconds (int)
    
    ; Convert planet index to address offset (4 bytes per float)
    mov eax, edi          ; planet index
    shl eax, 2            ; multiply by 4 (sizeof(float))
    
    ; Load the orbital period for this planet
    lea rcx, [rel planet_periods]  ; Use RIP-relative addressing
    movss xmm0, [rcx + rax]        ; xmm0 = orbital_period
    
    ; Load Earth year in seconds
    movss xmm1, [rel earth_year_seconds] ; xmm1 = 31557600.0
    
    ; Convert seconds (int) to float
    cvtsi2ss xmm2, esi             ; xmm2 = seconds as float
    
    ; Calculate age on Earth: seconds / earth_year_seconds
    divss xmm2, xmm1               ; xmm2 = age_on_earth
    
    ; Adjust for planet's orbital period: age_on_earth / orbital_period
    divss xmm2, xmm0               ; xmm2 = age_on_planet
    
    ; Return value in xmm0 (standard for float returns in x86-64)
    movaps xmm0, xmm2
    
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif