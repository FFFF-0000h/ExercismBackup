section .text

global daily_rate
global apply_discount
global monthly_rate
global days_in_budget

; ==============================================
; daily_rate
; ==============================================
daily_rate:
    movsd   xmm1, [rel eight]     ; RIP-relative addressing
    mulsd   xmm0, xmm1
    ret

; ==============================================
; apply_discount
; ==============================================
apply_discount:
    movsd   xmm2, [rel hundred]
    subsd   xmm2, xmm1
    divsd   xmm2, [rel hundred]
    mulsd   xmm0, xmm2
    ret

; ==============================================
; Helper: round_up (ceil) for monthly_rate
; ==============================================
round_up:
    ; Save the original value
    movsd   xmm1, xmm0
    
    ; Truncate to integer (round toward zero)
    cvttsd2si rax, xmm0
    cvtsi2sd xmm2, rax
    
    ; Compare original with truncated
    comisd  xmm1, xmm2
    je      .done
    
    ; If original > truncated, need to round up
    ja      .round_up
    
    ; If original < truncated (shouldn't happen for positive)
    jmp     .done

.round_up:
    inc     rax

.done:
    ret

; ==============================================
; Helper: round_down (floor) for days_in_budget
; ==============================================
round_down:
    ; Simply truncate toward zero (works for positive numbers)
    cvttsd2si eax, xmm0
    
    ; Check if result is negative (shouldn't happen)
    test    eax, eax
    jns     .positive
    xor     eax, eax

.positive:
    ret

; ==============================================
; monthly_rate
; ==============================================
monthly_rate:
    push    rbx
    
    ; Save original values
    movsd   xmm2, xmm0        ; Save hourly_rate
    movsd   xmm3, xmm1        ; Save discount
    
    ; Calculate daily rate
    movsd   xmm0, xmm2        ; Restore hourly_rate
    call    daily_rate        ; xmm0 = daily_rate
    
    ; Apply discount
    movsd   xmm1, xmm3        ; Restore discount
    call    apply_discount    ; xmm0 = discounted_daily_rate
    
    ; Multiply by 22
    movsd   xmm1, [rel twenty_two]
    mulsd   xmm0, xmm1        ; xmm0 = monthly_rate
    
    ; Round up
    call    round_up          ; rax = rounded monthly_rate
    
    pop     rbx
    ret

; ==============================================
; days_in_budget
; ==============================================
days_in_budget:
    push    rbx
    push    r12
    
    ; Save budget
    mov     r12, rdi          ; r12 = budget
    
    ; Save original values
    movsd   xmm2, xmm0        ; Save hourly_rate
    movsd   xmm3, xmm1        ; Save discount
    
    ; Calculate discounted daily rate
    movsd   xmm0, xmm2        ; Restore hourly_rate
    call    daily_rate        ; xmm0 = daily_rate
    
    movsd   xmm1, xmm3        ; Restore discount
    call    apply_discount    ; xmm0 = discounted_daily_rate
    
    ; Convert budget to double
    cvtsi2sd xmm1, r12        ; xmm1 = budget as double
    
    ; Calculate days = budget / discounted_daily_rate
    divsd   xmm1, xmm0        ; xmm1 = days
    movsd   xmm0, xmm1
    
    ; Round down
    call    round_down        ; eax = days (rounded down)
    
    pop     r12
    pop     rbx
    ret

; ==============================================
; Constants in the .text section (not .rodata)
; This avoids relocation issues
; ==============================================
eight:      dq 8.0
twenty_two: dq 22.0
hundred:    dq 100.0

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif