section .rodata
align 16
abs_mask:    dd 0x7FFFFFFF, 0x7FFFFFFF, 0x7FFFFFFF, 0x7FFFFFFF
exp_mask:    dd 0x7F800000, 0x7F800000, 0x7F800000, 0x7F800000
bias:        dd 127, 127, 127, 127

section .text

global rectify_trace
rectify_trace:
    movaps  xmm0, [rsi]
    andps   xmm0, [rel abs_mask]
    movaps  [rdi], xmm0
    ret

global reading_scale
reading_scale:
    movaps  xmm0, [rsi]
    pand    xmm0, [rel exp_mask]
    psrld   xmm0, 23
    psubd   xmm0, [rel bias]
    movdqa  [rdi], xmm0
    ret

global coarsen_displacements
coarsen_displacements:
    movdqa  xmm0, [rsi]
    movq    xmm1, rdx
    psrad   xmm0, xmm1
    movdqa  [rdi], xmm0
    ret

global gate_channels
gate_channels:
    movdqa  xmm0, [rsi]
    por     xmm0, [rdx]
    movdqa  xmm1, [rcx]
    pandn   xmm1, xmm0
    movdqa  [rdi], xmm1
    ret

global toggle_calibration
toggle_calibration:
    movdqa  xmm0, [rcx]
    pandn   xmm0, [rdx]
    pxor    xmm0, [rsi]
    movdqa  [rdi], xmm0
    ret

global amplify_trace
amplify_trace:
    movaps  xmm0, [rsi]          ; float values
    movdqa  xmm1, [rdx]          ; integer gains
    pslld   xmm1, 23
    paddd   xmm0, xmm1
    movaps  [rdi], xmm0
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif