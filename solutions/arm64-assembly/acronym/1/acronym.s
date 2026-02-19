.text
.globl abbreviate

abbreviate:
        mov x2,#1

mainloop:
        ldrb w3,[x1],#1
        cbz w3,end
        cmp w3,' '
        b.eq inloop
        cmp w3,'-'
        b.eq inloop
        cmp w3,'_'
        b.eq inloop
        cbz x2,mainloop
        cmp w3,'a'
        b.lt bigchar
        cmp w3,'z'
        b.gt bigchar
        sub w3,w3,32
bigchar:
        strb w3,[x0],#1
        mov x2,#0
        b.al mainloop
inloop:
        mov x2,#1
        b.al mainloop
end:
        strb w3,[x0]
        ret
