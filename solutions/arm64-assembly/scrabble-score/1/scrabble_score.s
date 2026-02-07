.data
table: .byte 1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10

.text
.globl score

score:
        eor x5,x5,x5
        eor x2,x2,x2
        eor x3,x3,x3
        ldr x4,=table
scoreloop:
        ldrb w3,[x0,x5]
        cbz  w3,end
        cmp w3,'A'
        b.lt notbigchar
        cmp w3,'Z'
        b.gt notbigchar
        add w3,w3,32
notbigchar:
        sub w3,w3,'a'
        ldrb w3,[x4,x3]
        add x2,x2,x3
        add x5,x5,#1
        b.al scoreloop
end:
        mov x0,x2
        ret
