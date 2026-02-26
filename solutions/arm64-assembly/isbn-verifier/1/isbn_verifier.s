.text
.globl is_valid

is_valid:
        mov x1,#10
        eor x2,x2,x2
        eor x3,x3,x3
charloop:
        ldrb w3,[x0], #1
        cbz w3,end
        cmp w3,'0'
        b.lt notnumber
        cmp w3,'9'
        b.gt notnumber
        sub w3,w3,'0'
        //mul x3,x3,x1
        //add x2,x2,x3
        madd x2,x3,x1,x2
        cbz x1,failure
        sub x1,x1,#1
        b.al charloop
notnumber:
        cmp w3,'-'
        b.eq charloop
        cmp w3,'X'
        b.ne failure
        cmp x1,#1
        b.ne failure
        add x2,x2,#10
        sub x1,x1,#1
        b.al charloop
end:
        cbnz x1,failure
        mov x1,#11
        udiv x3, x2, x1 // x2 = x0 / x1
        msub x4, x3, x1, x2 // x3 = x0  - x2*x1
        cbnz x4,failure
        mov x0,#1
        ret
failure:
        mov x0,#0
        ret
