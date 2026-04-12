; Clock x86-64 implementation
; NASM syntax

section .text

global create
global add_minutes
global subtract_minutes
global equal

;------------------------------------------------------------------------
; Normalize a total number of minutes (signed) into a 24‑hour clock.
; Input:  RAX = total minutes (may be negative or >= 1440)
; Output: RAX = packed clock value:
;         bits  0..7  = hour   (0–23)
;         bits  8..15 = minute (0–59)
;         (upper bits of RAX are zeroed)
;------------------------------------------------------------------------
normalize_time:
    mov     rcx, 1440          ; minutes in a day
    cqo                         ; sign‑extend RAX → RDX:RAX
    idiv    rcx                 ; RAX = quotient, RDX = remainder (-1439..1439)
    test    rdx, rdx
    jns     .positive
    add     rdx, rcx            ; if negative, wrap to positive range
.positive:
    ; Now RDX is total minutes in [0, 1439]
    mov     rax, rdx
    xor     rdx, rdx
    mov     rcx, 60
    div     rcx                 ; RAX = hour, RDX = minute
    shl     rdx, 8              ; move minute to bits 8..15
    or      rax, rdx            ; pack: RAX = (minute << 8) | hour
    ret

;------------------------------------------------------------------------
; clock_t create(int64_t hour, int64_t minute)
;   rdi = hour, rsi = minute
; Returns a packed clock value as described above.
;------------------------------------------------------------------------
create:
    mov     rax, rdi
    imul    rax, 60
    add     rax, rsi            ; RAX = hour*60 + minute
    jmp     normalize_time

;------------------------------------------------------------------------
; clock_t add_minutes(int64_t hour, int64_t minute, int64_t value)
;   rdi = hour, rsi = minute, rdx = minutes to add
;------------------------------------------------------------------------
add_minutes:
    mov     rax, rdi
    imul    rax, 60
    add     rax, rsi
    add     rax, rdx            ; RAX = base minutes + value
    jmp     normalize_time

;------------------------------------------------------------------------
; clock_t subtract_minutes(int64_t hour, int64_t minute, int64_t value)
;   rdi = hour, rsi = minute, rdx = minutes to subtract
;------------------------------------------------------------------------
subtract_minutes:
    mov     rax, rdi
    imul    rax, 60
    add     rax, rsi
    sub     rax, rdx            ; RAX = base minutes - value
    jmp     normalize_time

;------------------------------------------------------------------------
; bool equal(clock_t clock1, clock_t clock2)
;   rdi = clock1 (packed 16‑bit value in DI)
;   rsi = clock2 (packed 16‑bit value in SI)
; Returns 1 if equal, 0 otherwise.
;------------------------------------------------------------------------
equal:
    cmp     di, si              ; compare the 16‑bit packed values
    sete    al
    movzx   rax, al
    ret

;------------------------------------------------------------------------
%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif