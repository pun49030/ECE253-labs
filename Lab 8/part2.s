.global _start
.global SWAP
_start:

	
LDR R5, = LIST
MOV R0, R5 // copy of address of first to modify
LDR R7, [R0] // total count - R3 constant
MOV R6, R7 // count
// SUB R2, R2, #1 // subtract count by 1


// set to 1 so doesn't end on first run
MOV R3, #1 // number of swaps in full run through – if zero, end swapping
MOV R9, R0 // initialise R9, which will hold copy of R0 between loops
MOV R8, R0 // copy of pointer to first term - R8 constant


LOOP:
	CMP R3,#0 // 0 swaps in whole run through: end
	BEQ END
	
	// already comparing in loop2
	// CMP R2,#0 // check if counted down to zero: finished run
	MOV R3,#0 // reset number of swaps in run through
	MOV R6, R7 // reset count to number of terms
	MOV R0, R8 // reset pointer to LIST address
				// will be incremented to first term in LOOP2
	MOV R9, R0 // make copy of address of first
	B LOOP2

LOOP2:
	ADD R9, R9, #4 // increment temp R9 by 1
	SUB R6, R6, #1
	CMP R6,#0
	BEQ LOOP
	MOV R0, R9 // moves temp address back to R0
	BL SWAP
	B LOOP2

SWAP:
	LDR R1, [R0] // first number to compare
	LDR R2, [R0, #4] // loading value of second to R6
	
	CMP R1, R2
	STRGT R2, [R0] // stores second value in address of first
	// ADDGT R0, R0, #4 // increment address to second address
	STRGT R1, [R0, #4] // stores first value into address of second
	
	ADDGT R3, R3, #1 // swapped, so increment swap counter
	// SUBGT R0, R0, #4
	// MOV R9, R0 // copy of address of second as need to fill R0
	
	MOVGT R0,#1 // return 1 as swapped
	MOVLE R0,#0 // return 0 as no swap
	
ENDSUB:
	MOV PC, LR
	
END:
	B END




