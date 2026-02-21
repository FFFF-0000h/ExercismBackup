.text
.equ EGGS, 0
.equ PEANUTS, 1
.equ SHELLFISH, 2
.equ STRAWBERRIES, 3
.equ TOMATOES, 4
.equ CHOCOLATE, 5
.equ POLLEN, 6
.equ CATS, 7
.equ MAX_ITEMS, 8

.globl allergic_to
.globl list

/* extern int allergic_to(item_t item, unsigned int score); */
allergic_to:
        lsr x0, x1, x0
        and x0, x0, 1
        ret

/* extern void list(unsigned int score, item_list_t *list); */
list:
        and     x0, x0, 0xff            /* clear unused bits */
        add     x9, x1, 4               /* start of items array */
        mov     x10, x9                 /* pointer into items array */
        mov     x11, xzr                /* current item */
        b       .while

.loop:
        and     x12, x0, 1
        cbz     x12, .advance

        str     w11, [x10], #4

.advance:
        lsr     x0, x0, 1
        add     x11, x11, 1

.while:
        cbnz    x0, .loop

        sub     x10, x10, x9
        lsr     x10, x10, 2             /* number of items */
        str     w10, [x1]
        ret
