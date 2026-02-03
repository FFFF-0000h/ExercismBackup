.section .rodata
.data
black:  .string "black"
brown:  .string "brown"
red:    .string "red"
orange: .string "orange"
yellow: .string "yellow"
green:  .string "green"
blue:   .string "blue"
violet: .string "violet"
grey:   .string "grey"
white:  .string "white"
color_array:
        .dword black
        .dword brown
        .dword red
        .dword orange
        .dword yellow
        .dword green
        .dword blue
        .dword violet
        .dword grey
        .dword white
        .dword 0           
.text
.globl color_code
.globl colors

// Input: x0 str2, x1 str1, Output: x2 -1 less than, 0 equal, 1 greater than
cmpstrings:
        eor x5,x5,x5
cmploop:
        ldrb w3, [x1, x5]
        ldrb w4, [x0, x5]
        cmp w3,w4
        b.eq equal
        b.lt lessthan
        mov x2,#1
        ret
lessthan:
        mov x2,#-1
        ret
equal:  cbz w3,strsequal
        add x5,x5,#1
        b.al cmploop
strsequal:
        mov x2,#0
        ret

color_code:
        stp fp, lr, [sp, -16]!
        ldr x7,=color_array
        mov x6,#0
resistorloop:
        cmp x6,#10
        b.eq fail
        ldr x1,[x7],#8
        bl cmpstrings
        cbz x2,resistorfound
        add x6,x6,#1
        b.al resistorloop
resistorfound:
        mov x0,x6
        ldp fp, lr, [sp], 16
        ret
fail:
        mov x0,#-1
        ldp fp, lr, [sp], 16
        ret

colors:
        ldr x0,=color_array
        ret
