.global _start
.global SWAP
_start:
	
LDR R1, = LIST
MOV R0, R1 // copy of address of first to modify
MOV R2, [R0] // count
ADD R0, R0, #4 // points to first number
MOV R7, #0 // number of swaps in full run through – if zero, end swapping
MOV R9,R0 // initialise R9, which will hold copy of R0 between loops

LOOP:
	CMP R7,#0 // 0 swaps in whole run through: end
	BEQ END
	
	CMP R2,#0
	MOVEQ R7,#0 // reset number of swaps in run through
	MOVEQ R2,[R0] // reset count to number of terms
	MOVEQ R0, [R1, #4] // reset pointer to first term
	
	BL SWAP
	B LOOP

LOOP2:
	CMP R2,#0
	BEQ LOOP
	MOV R0, R9 // moves address back to R0
	B SWAP

SWAP:
	LDR R5, [R0] // first number to compare
	LDR R6, [R0, #4] // loading value of second to R4
	
	CMP R5, R6
	STRGT R6, [R0] // stores second value in address of first
	ADDGT R0, R0, #4 // increment address to second address
	STRGT R5, [R0] // stores first value into address of second
	
	ADDGT R7, R7, #1 // swapped, so increment swap counter
	
	MOV R9, R0 // copy of address of second as need to fill R0
	
	MOVGT R0,#1 // return 1 as swapped
	MOVLE R0,#0 // return 0 as no swap
	SUB R2,#1 // count down
	
	MOV R0, 
	B LOOP2
	
ENDSUB:
	MOV PC, LR
	
END:
	B END


	