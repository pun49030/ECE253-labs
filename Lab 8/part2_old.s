.text
.global _start
.global SWAP
_start:

LDR R2, = LIST // address of first entry - count
LDR R1,[R2] // total count value
MOV R3, R2
ADD R3, R3, #4
SUB R1, R1, #1 // will compare to n-1
//ADD R2, R2, #4
MOV R5, #0 // i for outer
MOV R6, #0 // j for inner
BL OUTERLOOP

OUTERLOOP:
	MOV R6, #0 // reset j
	MOV R2, R3
	CMP R5, R1
	BEQ END
	B INNERLOOP
	ADD R5, R5, #1 // increment i
	
INNERLOOP:
	SUB R7, R1, R5 // to compare to n - i -1
	CMP R6, R7
	BEQ OUTERLOOP
	MOV R0,R2 // loading address of first to R0
	BL SWAP
	ADD R6, R6, #1 // increment j
	ADD R2, R2, #4 // increment R2
	
	B INNERLOOP

SWAP:
	LDR R4,[R0,#4] // loading value of second to R4
	LDR R9,[R0] // loading value of R0
	CMP R9, R4
	STRGT R4,[R0] // stored second value in address of first
	ADDGT R0, R0, #4 // increment address to second address
	STRGT R9,[R0] // stored first value in second address
	MOVGT R0,#1 // return 1 as swapped
	MOVLE R0,#0 // return 0 as no swap
	
ENDSUB:
	MOV PC, LR
	
END:
	B END


	
	
	