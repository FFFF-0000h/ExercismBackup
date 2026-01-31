.text
.globl is_pangram

is_pangram:
	mov w8, wzr
	mov w10, #0xdf
.loop:
	ldrb w9, [x0], #1
	cbz w9, .done
	and w9, w9, w10
	sub w9, w9, #'A
	cmp w9, #25
	b.hi .loop
	mov w11, #1
	lsl w11, w11, w9
	orr w8, w8, w11
	b .loop
.done:
	mov w9, #0x3ffffff
	cmp w8, w9
	cset w0, eq
	ret

