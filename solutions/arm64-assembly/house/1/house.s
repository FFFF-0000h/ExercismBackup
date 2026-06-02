.section .rodata
.align 3

line0: .asciz "This is the house that Jack built.\n"
line1: .asciz "This is the malt that lay in the house that Jack built.\n"
line2: .asciz "This is the rat that ate the malt that lay in the house that Jack built.\n"
line3: .asciz "This is the cat that killed the rat that ate the malt that lay in the house that Jack built.\n"
line4: .asciz "This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\n"
line5: .asciz "This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\n"
line6: .asciz "This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\n"
line7: .asciz "This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\n"
line8: .asciz "This is the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\n"
line9: .asciz "This is the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\n"
line10: .asciz "This is the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\n"
line11: .asciz "This is the horse and the hound and the horn that belonged to the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\n"

verse_table:
    .quad line0, line1, line2, line3, line4, line5, line6, line7, line8, line9, line10, line11

.text
.globl recite

// void recite(char *buffer, int start_verse, int end_verse);
// x0 = buffer, w1 = start_verse, w2 = end_verse
recite:
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp
    stp     x19, x20, [sp, #-16]!
    stp     x21, x22, [sp, #-16]!
    stp     x23, x24, [sp, #-16]!

    mov     x19, x0             // x19 = buffer
    mov     w20, w1             // w20 = start_verse
    mov     w21, w2             // w21 = end_verse

    adrp    x22, verse_table
    add     x22, x22, :lo12:verse_table

    mov     w23, w20            // i = start_verse
.Lverse_loop:
    cmp     w23, w21
    b.gt    .Ldone

    // Load verse pointer (1-indexed to 0-indexed)
    sub     w24, w23, #1
    ldr     x0, [x22, w24, uxtw #3]

    // Copy string to buffer
    mov     x1, x19
    bl      .Lstrcpy
    mov     x19, x0            // x0 points to null

.Lnext_verse:
    add     w23, w23, #1
    b       .Lverse_loop

.Ldone:
    ldp     x23, x24, [sp], #16
    ldp     x21, x22, [sp], #16
    ldp     x19, x20, [sp], #16
    ldp     x29, x30, [sp], #16
    ret

// Simple string copy: src in x0, dst in x1
// Returns x0 = pointer to the destination null terminator
.Lstrcpy:
    ldrb    w2, [x0], #1
    strb    w2, [x1], #1
    cbnz    w2, .Lstrcpy
    sub     x0, x1, #1         // x0 = address of terminating null
    ret