.text
.global truncate

truncate:
	mov w8, wzr
	mov w9, #6
.copy:
	sub w9, w9, #1
	cbz w9, .done
	ldrb w10, [x1, x8]
	cbz w10, .done
	strb w10, [x0, x8]
.cont:
	add x8, x8, #1
	ldrsb w10, [x1, x8]
	cmn w10, #65
	b.gt .copy
	strb w10, [x0, x8]
	b .cont
.done:
	strb wzr, [x0, x8]
	ret
    