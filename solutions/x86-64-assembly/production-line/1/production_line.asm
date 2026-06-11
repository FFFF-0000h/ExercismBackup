section .rodata
align 16
conversion_factor: dq 0.5, 0.5

section .text

; Task 1
global sum_yields
sum_yields:
    ; rdi = line_a (aligned), rsi = line_b (aligned), rdx = result (aligned)
    movaps  xmm0, [rdi]
    addps   xmm0, [rsi]
    movaps  [rdx], xmm0
    ret

; Task 2
global scaled_deviation
scaled_deviation:
    ; rdi = measured (aligned), rsi = target, rdx = sensitivity, rcx = result
    movapd  xmm0, [rdi]          ; aligned load
    movupd  xmm1, [rsi]          ; unaligned load
    subpd   xmm0, xmm1
    movupd  xmm1, [rdx]          ; unaligned load
    mulpd   xmm0, xmm1
    movupd  [rcx], xmm0          ; unaligned store
    ret

; Task 3
global calibrate_batch
calibrate_batch:
    ; rdi = raw, rsi = reference (aligned), rdx = offset (aligned), rcx = result (aligned)
    ; first row (raw[0], raw[1])
    cvtps2pd xmm0, [rdi]         ; convert two floats to doubles
    movapd   xmm1, [rdx]          ; offset
    subpd    xmm0, xmm1           ; raw_dbl - offset
    movapd   xmm1, [rsi]          ; reference
    divpd    xmm1, xmm0           ; reference / (raw - offset)
    mulpd    xmm1, [rel conversion_factor]   ; multiply by 0.5 (RIP‑relative)
    movapd   [rcx], xmm1          ; store first two results

    ; second row (raw[2], raw[3])
    add      rdi, 8
    cvtps2pd xmm0, [rdi]
    movapd   xmm1, [rdx]
    subpd    xmm0, xmm1
    movapd   xmm1, [rsi]
    divpd    xmm1, xmm0
    mulpd    xmm1, [rel conversion_factor]
    movapd   [rcx + 16], xmm1
    ret

; Task 4
global normalize_scores
normalize_scores:
    ; rdi = scores (aligned), rsi = gains (aligned), rdx = scale (aligned), rcx = n
    movapd  xmm2, [rdx]           ; load scale once
    xor     rax, rax               ; index (in elements)
.loop:
    cmp     rax, rcx
    jae     .done
    movapd  xmm0, [rdi + rax*8]   ; scores[i], scores[i+1]
    movapd  xmm1, [rsi + rax*8]   ; gains[i], gains[i+1]
    mulpd   xmm0, xmm1            ; score * gain
    divpd   xmm0, xmm2            ; / scale
    movapd  [rdi + rax*8], xmm0   ; store back
    add     rax, 2
    jmp     .loop
.done:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif