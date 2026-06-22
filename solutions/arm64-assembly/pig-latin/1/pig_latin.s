.text
.globl translate

// void translate(char *buffer, const char *phrase);
// x0 = buffer (output), x1 = phrase (input)
translate:
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp
    stp     x19, x20, [sp, #-16]!
    stp     x21, x22, [sp, #-16]!
    stp     x23, x24, [sp, #-16]!
    stp     x25, x26, [sp, #-16]!

    mov     x19, x0               // output buffer
    mov     x20, x1               // input phrase
    mov     x25, x19              // current output position

.Lnext_word:
.Lskip_spaces:
    ldrb    w21, [x20]
    cmp     w21, #' '
    b.ne    .Lcheck_end
    strb    w21, [x25], #1
    add     x20, x20, #1
    b       .Lskip_spaces

.Lcheck_end:
    cbz     w21, .Lterminate

    mov     x22, x20              // word_start

.Lfind_end:
    ldrb    w21, [x20]
    cbz     w21, .Lword_end
    cmp     w21, #' '
    b.eq    .Lword_end
    add     x20, x20, #1
    b       .Lfind_end

.Lword_end:
    mov     x23, x20              // word_end
    sub     x24, x23, x22         // word length

    // Rule 1: vowel, xr, yt
    ldrb    w0, [x22]
    bl      is_vowel_char
    cmp     w0, #1
    b.eq    .Lrule1

    ldrb    w0, [x22]
    cmp     w0, #'x'
    b.ne    .Lcheck_yt_start
    cmp     x24, #2
    b.lt    .Lcheck_yt_start
    ldrb    w0, [x22, #1]
    cmp     w0, #'r'
    b.eq    .Lrule1

.Lcheck_yt_start:
    ldrb    w0, [x22]
    cmp     w0, #'y'
    b.ne    .Lcheck_qu_rule3
    cmp     x24, #2
    b.lt    .Lcheck_qu_rule3
    ldrb    w0, [x22, #1]
    cmp     w0, #'t'
    b.eq    .Lrule1

.Lcheck_qu_rule3:
    bl      check_qu_rule3
    cmp     x0, #-1
    b.ne    .Lrule3

    bl      find_y_after_cons
    cmp     x0, #-1
    b.ne    .Lrule4

    bl      count_leading_cons
    cmp     x0, #0
    b.gt    .Lrule2

    b       .Lrule1

.Lrule1:
    mov     x0, x22
    mov     x1, x23
    bl      copy_to_output
    mov     w0, #'a'
    strb    w0, [x25], #1
    mov     w0, #'y'
    strb    w0, [x25], #1
    b       .Lword_done

.Lrule2:
    mov     x5, x0               // consonant count
    add     x0, x22, x5
    mov     x1, x23
    bl      copy_to_output
    mov     x0, x22
    add     x1, x22, x5
    bl      copy_to_output
    mov     w0, #'a'
    strb    w0, [x25], #1
    mov     w0, #'y'
    strb    w0, [x25], #1
    b       .Lword_done

.Lrule3:
    // x0 = number of consonants before "qu"
    mov     x5, x0
    add     x0, x5, #2           // consonants + "qu"
    add     x0, x22, x0          // position after "qu"
    mov     x1, x23
    bl      copy_to_output
    mov     x0, x22
    add     x1, x22, x5
    add     x1, x1, #2           // include "qu"
    bl      copy_to_output
    mov     w0, #'a'
    strb    w0, [x25], #1
    mov     w0, #'y'
    strb    w0, [x25], #1
    b       .Lword_done

.Lrule4:
    mov     x5, x0               // position of y
    add     x0, x22, x5
    mov     x1, x23
    bl      copy_to_output
    mov     x0, x22
    add     x1, x22, x5
    bl      copy_to_output
    mov     w0, #'a'
    strb    w0, [x25], #1
    mov     w0, #'y'
    strb    w0, [x25], #1

.Lword_done:
    b       .Lnext_word

.Lterminate:
    mov     w0, #0
    strb    w0, [x25]

    ldp     x25, x26, [sp], #16
    ldp     x23, x24, [sp], #16
    ldp     x21, x22, [sp], #16
    ldp     x19, x20, [sp], #16
    ldp     x29, x30, [sp], #16
    ret

// Helper functions
is_vowel_char:
    orr     w0, w0, #32
    cmp     w0, #'a'
    b.eq    .L_is_vowel
    cmp     w0, #'e'
    b.eq    .L_is_vowel
    cmp     w0, #'i'
    b.eq    .L_is_vowel
    cmp     w0, #'o'
    b.eq    .L_is_vowel
    cmp     w0, #'u'
    b.eq    .L_is_vowel
    mov     w0, #0
    ret
.L_is_vowel:
    mov     w0, #1
    ret

count_leading_cons:
    mov     x2, #0
.Lclc_loop:
    cmp     x2, x24
    b.ge    .Lclc_done
    ldrb    w4, [x22, x2]
    mov     w0, w4
    stp     x2, lr, [sp, #-16]!
    bl      is_vowel_char
    ldp     x2, lr, [sp], #16
    cmp     w0, #1
    b.eq    .Lclc_done
    orr     w4, w4, #32
    cmp     w4, #'y'
    b.eq    .Lclc_y_check
    add     x2, x2, #1
    b       .Lclc_loop
.Lclc_y_check:
    cmp     x2, #0
    b.eq    .Lclc_y_consonant
    b       .Lclc_done
.Lclc_y_consonant:
    add     x2, x2, #1
    b       .Lclc_loop
.Lclc_done:
    mov     x0, x2
    ret

check_qu_rule3:
    mov     x2, #0
.Lcq_loop:
    add     x3, x2, #1
    cmp     x3, x24
    b.ge    .Lcq_not_found
    ldrb    w4, [x22, x2]
    orr     w4, w4, #32
    cmp     w4, #'q'
    b.ne    .Lcq_not_q
    ldrb    w4, [x22, x3]
    orr     w4, w4, #32
    cmp     w4, #'u'
    b.eq    .Lcq_found
.Lcq_not_q:
    mov     w0, w4
    stp     x2, lr, [sp, #-16]!
    bl      is_vowel_char
    ldp     x2, lr, [sp], #16
    cmp     w0, #1
    b.eq    .Lcq_not_found
    add     x2, x2, #1
    b       .Lcq_loop
.Lcq_found:
    mov     x0, x2
    ret
.Lcq_not_found:
    mov     x0, #-1
    ret

find_y_after_cons:
    mov     x2, #0
    mov     x5, #0
.Lfy_loop:
    cmp     x2, x24
    b.ge    .Lfy_not_found
    ldrb    w4, [x22, x2]
    orr     w4, w4, #32
    cmp     w4, #'y'
    b.eq    .Lfy_is_y
    mov     w0, w4
    stp     x2, x5, [sp, #-16]!
    stp     lr, x1, [sp, #-16]!
    bl      is_vowel_char
    ldp     lr, x1, [sp], #16
    ldp     x2, x5, [sp], #16
    cmp     w0, #1
    b.eq    .Lfy_not_found
    mov     x5, #1
    add     x2, x2, #1
    b       .Lfy_loop
.Lfy_is_y:
    cmp     x5, #1
    b.eq    .Lfy_found
    mov     x5, #0
    add     x2, x2, #1
    b       .Lfy_loop
.Lfy_found:
    mov     x0, x2
    ret
.Lfy_not_found:
    mov     x0, #-1
    ret

copy_to_output:
.Lcto_loop:
    cmp     x0, x1
    b.eq    .Lcto_done
    ldrb    w2, [x0], #1
    strb    w2, [x25], #1
    b       .Lcto_loop
.Lcto_done:
    ret