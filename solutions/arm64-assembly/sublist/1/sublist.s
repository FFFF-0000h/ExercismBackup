.equ UNEQUAL, 0
.equ EQUAL, 1
.equ SUBLIST, 2
.equ SUPERLIST, 3

.text
.globl sublist

sublist:
        cmp x1,x3
        b.eq equallists
        b.lt firstlistless
        sub x4,x1,x3
        add x4,x4,#1
mainloop1:
        cbz x4, unequal
        mov x7,x2
        mov x9,x3
        mov x10,x0
innerloop1:
        cbz x9, superlistfound
        ldr x5,[x10],#8
        ldr x6,[x7],#8
        cmp x6,x5
        b.ne endofinnerloop1
        sub x9,x9,#1
        b.al innerloop1        
endofinnerloop1:
        sub x4,x4,#1
        add x0,x0,#8
        b.al mainloop1
superlistfound:
        mov x0,SUPERLIST
        ret
unequal:
        mov x0,UNEQUAL
        ret
        
firstlistless:
        sub x4,x3,x1
        add x4,x4,#1
mainloop2:
        cbz x4, unequal
        mov x7,x0
        mov x9,x1
        mov x10,x2
innerloop2:
        cbz x9, sublistfound
        ldr x5,[x10],#8
        ldr x6,[x7],#8
        cmp x6,x5
        b.ne endofinnerloop2
        sub x9,x9,#1
        b.al innerloop2
endofinnerloop2:
        sub x4,x4,#1
        add x2,x2,#8
        b.al mainloop2
sublistfound:
        mov x0,SUBLIST
        ret
        
equallists:
        mov x4,x1
mainloop3:
        cbz x4,equal
        ldr x5,[x0],#8
        ldr x6,[x2],#8
        cmp x6,x5
        b.ne unequal
        sub x4,x4,#1
        b.al mainloop3
equal:
        mov x0,EQUAL
        ret