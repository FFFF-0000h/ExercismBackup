section .text

global mix_tracks
mix_tracks:
    ; rdi = result, rsi = track_a, rdx = track_b
    movdqa  xmm0, [rsi]
    movdqa  xmm1, [rdx]
    paddsw  xmm0, xmm1
    movdqa  [rdi], xmm0
    ret

global remove_bleed
remove_bleed:
    ; rdi = result, rsi = track, rdx = bleed
    movdqa  xmm0, [rsi]
    movdqu  xmm1, [rdx]
    psubsw  xmm0, xmm1
    movdqu  [rdi], xmm0
    ret

global combine_meters
combine_meters:
    ; rdi = result, rsi = meter_a, rdx = meter_b
    movdqa  xmm0, [rsi]
    movdqa  xmm1, [rdx]
    paddusb xmm0, xmm1
    movdqa  [rdi], xmm0
    ret

global apply_fade
apply_fade:
    ; rdi = result, rsi = track, rdx = gains, rcx = n
    shr     rcx, 3
.loop:
    movdqa  xmm0, [rsi]
    movdqa  xmm1, [rdx]
    pmulhw  xmm0, xmm1
    movdqa  [rdi], xmm0
    add     rsi, 16
    add     rdx, 16
    add     rdi, 16
    dec     rcx
    jnz     .loop
    ret

global attenuate_track
attenuate_track:
    ; rdi = result, rsi = samples, rdx = divisor, rcx = n
    shr     rcx, 2              ; n / 4
    movdqa  xmm3, [rdx]         ; divisor (4 x int32)
    cvtdq2ps xmm3, xmm3         ; convert to float
.loop2:
    movq    xmm0, [rsi]          ; load 8 bytes (4 x int16)
    pmovsxwd xmm0, xmm0         ; sign-extend 4 words to 4 dwords
    cvtdq2ps xmm0, xmm0         ; convert to float
    divps   xmm0, xmm3          ; divide
    cvttps2dq xmm0, xmm0        ; convert back to int, truncate
    movdqa  [rdi], xmm0         ; store 4 dwords
    add     rsi, 8
    add     rdi, 16
    dec     rcx
    jnz     .loop2
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif