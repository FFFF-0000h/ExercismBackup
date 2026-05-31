.text
.globl encode
.globl decode

encode:
        mov x4,#2
        udiv x5, x2, x4
        msub x6, x5, x4, x2
        cbz  x6,failure
        mov x4,#13
        udiv x5, x2, x4
        msub x6, x5, x4, x2
        cbz  x6,failure
        eor x5,x5,x5
        
mainloop1:
        ldrb w4,[x1],#1
        cbz w4,end
        cmp w4,'A'
        b.lt otherthanupper
        cmp w4,'Z'
        b.gt otherthanupper
        add w4,w4,32
otherthanupper:
        cmp w4,'a'
        b.lt otherthanlower
        cmp w4,'z'
        b.gt otherthanlower
        cbz x5,notspace1
        mov x6,#5
        udiv x7, x5, x6
        msub x8, x7, x6, x5
        cbnz x8,notspace1
        mov w7,' '
        strb w7,[x0],#1
notspace1:
        sub w4,w4,'a'
        mul x4,x4,x2
        add x4,x4,x3
        mov x6,#26
        udiv x7, x4, x6
        msub x4, x7, x6, x4
        add w4,w4,'a'
        strb w4,[x0],#1
        add x5,x5,#1
        b.al mainloop1
otherthanlower:
        cmp w4,'0'
        b.lt mainloop1
        cmp w4,'9'
        b.gt mainloop1
        cbz x5,notspace2
        mov x6,#5
        udiv x7, x5, x6
        msub x8, x7, x6, x5
        cbnz x8,notspace2
        mov w7,' '
        strb w7,[x0],#1
notspace2:
        strb w4,[x0],#1
        add x5,x5,#1
        b.al mainloop1
end:
failure:
        eor w3,w3,w3
        strb w3,[x0]
        ret

decode:
        mov x4,#2
        udiv x5, x2, x4
        msub x6, x5, x4, x2
        cbz  x6,failure
        mov x4,#13
        udiv x5, x2, x4
        msub x6, x5, x4, x2
        cbz  x6,failure

        mov x5,#0
        mov x7,#26
mmiloop:
        add x5,x5,#1
        mul x6,x5,x2
        udiv x8, x6, x7
        msub x8, x8, x7, x6
        cmp x8,#1
        b.ne mmiloop
        
mainloop2:
        ldrb w4,[x1],#1
        cbz w4,end
        cmp w4,'a'
        b.lt otherthanlower2
        cmp w4,'z'
        b.gt otherthanlower2
        sub w4,w4,'a'
        sub w4,w4,w3
        mul w4,w5,w4
again:
        cmp w4,#0
        b.ge notsubs
        add w4,w4,#26
        b.al again
notsubs:
        udiv w6, w4, w7
        msub w6, w6, w7, w4
        add w6,w6,'a'
        strb w6,[x0],#1
        b.al mainloop2        
otherthanlower2:
        cmp w4,'0'
        b.lt mainloop2
        cmp w4,'9'
        b.gt mainloop2
        strb w4,[x0],#1
        b.al mainloop2