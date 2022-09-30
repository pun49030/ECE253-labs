.text
.global _start
_start:

LDR R8, = 0 // count register
LDR R2, = TEST_NUM // address
LDR R1, [R2] // value at R1
LDR R7, = 0 // sum register


LOOP:
	CMP R1, #-1
	BEQ END
	ADD R7, R7, R1 // add to sum
	ADD R8, R8, #1 // increment counter
	ADD R2, R2, #4
	LDR R1, [R2] // load value at new address
	B LOOP

END:
	B END

