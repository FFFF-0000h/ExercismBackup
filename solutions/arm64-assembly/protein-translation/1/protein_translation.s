.section .rodata
.align 3
protein_Met: .asciz "Methionine\n"
protein_Phe: .asciz "Phenylalanine\n"
protein_Leu: .asciz "Leucine\n"
protein_Ser: .asciz "Serine\n"
protein_Tyr: .asciz "Tyrosine\n"
protein_Cys: .asciz "Cysteine\n"
protein_Trp: .asciz "Tryptophan\n"

.text
.align 2
.globl proteins

proteins:
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp
    stp     x19, x20, [sp, #-16]!
    stp     x21, x22, [sp, #-16]!

    mov     x19, x1               // strand (second argument)
    mov     x20, x0               // buffer (first argument)
    mov     x22, x20

.Lnext_codon:
    ldrb    w0, [x19]
    cbz     w0, .Lterminate
    ldrb    w0, [x19, #1]
    cbz     w0, .Linvalid
    ldrb    w0, [x19, #2]
    cbz     w0, .Linvalid

    ldrb    w0, [x19]
    cmp     w0, #'A'
    b.ne    .Lcheck_U
    ldrb    w0, [x19, #1]
    cmp     w0, #'U'
    b.ne    .Linvalid
    ldrb    w0, [x19, #2]
    cmp     w0, #'G'
    b.ne    .Linvalid
    add     x19, x19, #3
    adrp    x0, protein_Met
    add     x0, x0, :lo12:protein_Met
    b       .Lappend

.Lcheck_U:
    cmp     w0, #'U'
    b.ne    .Linvalid
    ldrb    w0, [x19, #1]
    cmp     w0, #'U'
    b.eq    .L_UU
    cmp     w0, #'C'
    b.eq    .L_UC
    cmp     w0, #'A'
    b.eq    .L_UA
    cmp     w0, #'G'
    b.eq    .L_UG
    b       .Linvalid

.L_UU:
    ldrb    w0, [x19, #2]
    cmp     w0, #'U'
    b.eq    .Lphe
    cmp     w0, #'C'
    b.eq    .Lphe
    cmp     w0, #'A'
    b.eq    .Lleu
    cmp     w0, #'G'
    b.eq    .Lleu
    b       .Linvalid

.L_UC:
    ldrb    w0, [x19, #2]
    cmp     w0, #'U'
    b.eq    .Lser
    cmp     w0, #'C'
    b.eq    .Lser
    cmp     w0, #'A'
    b.eq    .Lser
    cmp     w0, #'G'
    b.eq    .Lser
    b       .Linvalid

.L_UA:
    ldrb    w0, [x19, #2]
    cmp     w0, #'U'
    b.eq    .Ltyr
    cmp     w0, #'C'
    b.eq    .Ltyr
    cmp     w0, #'A'
    b.eq    .Lstop
    cmp     w0, #'G'
    b.eq    .Lstop
    b       .Linvalid

.L_UG:
    ldrb    w0, [x19, #2]
    cmp     w0, #'U'
    b.eq    .Lcys
    cmp     w0, #'C'
    b.eq    .Lcys
    cmp     w0, #'G'
    b.eq    .Ltrp
    cmp     w0, #'A'
    b.eq    .Lstop
    b       .Linvalid

.Lphe:
    add     x19, x19, #3
    adrp    x0, protein_Phe
    add     x0, x0, :lo12:protein_Phe
    b       .Lappend
.Lleu:
    add     x19, x19, #3
    adrp    x0, protein_Leu
    add     x0, x0, :lo12:protein_Leu
    b       .Lappend
.Lser:
    add     x19, x19, #3
    adrp    x0, protein_Ser
    add     x0, x0, :lo12:protein_Ser
    b       .Lappend
.Ltyr:
    add     x19, x19, #3
    adrp    x0, protein_Tyr
    add     x0, x0, :lo12:protein_Tyr
    b       .Lappend
.Lcys:
    add     x19, x19, #3
    adrp    x0, protein_Cys
    add     x0, x0, :lo12:protein_Cys
    b       .Lappend
.Ltrp:
    add     x19, x19, #3
    adrp    x0, protein_Trp
    add     x0, x0, :lo12:protein_Trp
    b       .Lappend
.Lstop:
    add     x19, x19, #3
    mov     w0, #0
    strb    w0, [x22]
    b       .Lexit

.Lappend:
    mov     x1, x22
    bl      strcpy_asm
    mov     x22, x0
    b       .Lnext_codon

.Linvalid:
    mov     w0, #0
    strb    w0, [x20]

.Lexit:
    ldp     x21, x22, [sp], #16
    ldp     x19, x20, [sp], #16
    ldp     x29, x30, [sp], #16
    ret

.Lterminate:
    mov     w0, #0
    strb    w0, [x22]
    b       .Lexit

strcpy_asm:
    ldrb    w2, [x0], #1
    strb    w2, [x1], #1
    cbnz    w2, strcpy_asm
    sub     x0, x1, #1
    ret