.section .rodata
.align 3
verse1:
    .asciz "I know an old lady who swallowed a fly.\nI don't know why she swallowed the fly. Perhaps she'll die.\n"
verse2:
    .asciz "I know an old lady who swallowed a spider.\nIt wriggled and jiggled and tickled inside her.\nShe swallowed the spider to catch the fly.\nI don't know why she swallowed the fly. Perhaps she'll die.\n"
verse3:
    .asciz "I know an old lady who swallowed a bird.\nHow absurd to swallow a bird!\nShe swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.\nShe swallowed the spider to catch the fly.\nI don't know why she swallowed the fly. Perhaps she'll die.\n"
verse4:
    .asciz "I know an old lady who swallowed a cat.\nImagine that, to swallow a cat!\nShe swallowed the cat to catch the bird.\nShe swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.\nShe swallowed the spider to catch the fly.\nI don't know why she swallowed the fly. Perhaps she'll die.\n"
verse5:
    .asciz "I know an old lady who swallowed a dog.\nWhat a hog, to swallow a dog!\nShe swallowed the dog to catch the cat.\nShe swallowed the cat to catch the bird.\nShe swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.\nShe swallowed the spider to catch the fly.\nI don't know why she swallowed the fly. Perhaps she'll die.\n"
verse6:
    .asciz "I know an old lady who swallowed a goat.\nJust opened her throat and swallowed a goat!\nShe swallowed the goat to catch the dog.\nShe swallowed the dog to catch the cat.\nShe swallowed the cat to catch the bird.\nShe swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.\nShe swallowed the spider to catch the fly.\nI don't know why she swallowed the fly. Perhaps she'll die.\n"
verse7:
    .asciz "I know an old lady who swallowed a cow.\nI don't know how she swallowed a cow!\nShe swallowed the cow to catch the goat.\nShe swallowed the goat to catch the dog.\nShe swallowed the dog to catch the cat.\nShe swallowed the cat to catch the bird.\nShe swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.\nShe swallowed the spider to catch the fly.\nI don't know why she swallowed the fly. Perhaps she'll die.\n"
verse8:
    .asciz "I know an old lady who swallowed a horse.\nShe's dead, of course!\n"

.align 3
verse_table:
    .quad verse1, verse2, verse3, verse4, verse5, verse6, verse7, verse8

.text
.globl recite

// void recite(char *buffer, int start_verse, int end_verse);
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

    // load verse pointer
    sub     w24, w23, #1
    ldr     x0, [x22, w24, uxtw #3]   // x0 = verse string

    // copy string to buffer
    mov     x1, x19
    bl      .Lstrcpy
    mov     x19, x0                // x0 points to the copied null

    // if not last verse, add a blank line separator (extra newline)
    cmp     w23, w21
    b.eq    .Lnext_verse
    mov     w5, '\n'
    strb    w5, [x19], #1          // write '\n' at the null position and advance
    // x19 now points to the next free byte; next verse copy will overwrite

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
    sub     x0, x1, #1             // x0 = address of the terminating null
    ret