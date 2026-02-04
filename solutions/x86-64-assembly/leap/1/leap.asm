section .text
global leap_year
leap_year:
    ; Input: year in edi (32-bit signed integer)
    ; Output: 1 if leap year, 0 if not leap year in eax
    
    ; Save year for later use
    mov eax, edi
    mov ecx, edi
    mov edx, edi
    
    ; Check divisibility by 4: year % 4 == 0
    mov ebx, 4
    xor edx, edx        ; Clear edx for division
    div ebx             ; eax = year/4, edx = year%4
    mov esi, edx        ; Save remainder in esi
    
    ; Check divisibility by 100: year % 100 == 0
    mov eax, ecx        ; Restore year
    mov ebx, 100
    xor edx, edx        ; Clear edx for division
    div ebx             ; eax = year/100, edx = year%100
    
    ; Check divisibility by 400: year % 400 == 0
    mov eax, ecx        ; Restore year
    mov ebx, 400
    mov ecx, edx        ; Save year%100 in ecx
    xor edx, edx        ; Clear edx for division
    div ebx             ; eax = year/400, edx = year%400
    
    ; Now evaluate the leap year condition:
    ; (year % 4 == 0) AND ((year % 100 != 0) OR (year % 400 == 0))
    
    ; First check: year % 4 == 0
    test esi, esi       ; Check if year%4 == 0
    jnz not_leap        ; If not divisible by 4, not leap
    
    ; Second part: (year % 100 != 0) OR (year % 400 == 0)
    test ecx, ecx       ; Check if year%100 == 0
    jnz is_leap         ; If not divisible by 100, it's leap
    
    ; If divisible by 100, check divisible by 400
    test edx, edx       ; Check if year%400 == 0
    jnz not_leap        ; If divisible by 100 but not 400, not leap
    
is_leap:
    mov eax, 1          ; Return 1 (true) for leap year
    ret
    
not_leap:
    mov eax, 0          ; Return 0 (false) for not leap year
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif