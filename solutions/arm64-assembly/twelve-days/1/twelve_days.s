.data
first: .string "first"
second: .string "second"
third: .string "third"
fourth: .string "fourth"
fifth: .string "fifth"
sixth: .string "sixth"
seventh: .string "seventh"
eighth: .string "eighth"
ninth: .string "ninth"
tenth: .string "tenth"
eleventh: .string "eleventh"
twelfth: .string "twelfth"
numbers: .dword first
         .dword second 
         .dword third
         .dword fourth
         .dword fifth
         .dword sixth
         .dword seventh
         .dword eighth
         .dword ninth
         .dword tenth
         .dword eleventh
        .dword twelfth

text1: .string "On the "
text2: .string " day of Christmas my true love gave to me: "
giving12: .string "twelve Drummers Drumming, "
giving11: .string "eleven Pipers Piping, "
giving10: .string "ten Lords-a-Leaping, "
giving9: .string "nine Ladies Dancing, "
giving8: .string "eight Maids-a-Milking, "
giving7: .string "seven Swans-a-Swimming, "
giving6: .string "six Geese-a-Laying, "
giving5: .string "five Gold Rings, "
giving4: .string "four Calling Birds, "
giving3: .string "three French Hens, "
giving2: .string "two Turtle Doves, and "
giving1: .string "a Partridge in a Pear Tree.\n"
givings: .dword giving1
         .dword giving2
         .dword giving3
         .dword giving4
         .dword giving5
         .dword giving6
         .dword giving7
         .dword giving8
         .dword giving9
         .dword giving10
         .dword giving11
         .dword giving12          

.text
.globl recite

copystrings:
copystrings_loop:
        ldrb w3, [x4],#1
        cbz w3,copystrings_done
        strb w3, [x0], #1
        b.al copystrings_loop
copystrings_done:
        strb w3, [x0] 
        ret

recite:
        stp fp, lr, [sp, -16]!
mainloop:
        cmp x1,x2
        b.gt end
        ldr x4,=text1
        bl copystrings
        ldr x4,=numbers
        mov x5,#8
        madd x4,x1,x5,x4
        sub x4,x4,#8
        ldr x4,[x4]
        bl copystrings
        ldr x4,=text2
        bl copystrings

        sub x6,x1,#1
        ldr x7,=givings
        mov x5,#8
        madd x7,x6,x5,x7

givingsloop:
        ldr x4,[x7]
        bl copystrings
        cbz x6,endofmain
        sub x6,x6,#1
        sub x7,x7,#8
        b.al givingsloop
endofmain:
        add x1,x1,#1
        b.al mainloop
end:
        ldp fp, lr, [sp], 16
        ret