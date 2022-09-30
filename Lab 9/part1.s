.global _start
_start:

LDR R8, = 0xFFFEC600 // Timer
LDR R7, = 0xFF200000 // LEDs
LDR R6, = 0xFF200050 // Keys

LDR R0, = 50000000 // Delay = 0.25 s with 200MHz frequency
STR R0, [R8] // Timer max value
MOV R0, #0B011 // A = 1, E = 1
STR R0, [R8, #8]
MOV R2, #0 // State counter
MOV R4, #0 // Direction: 0 is inwards, 1 is outwards

STATE1: 
	LDR R1,=0b1000000001 // R1 holds pattern
	STR R1,[R7] // store pattern into LED
	b NEXT_STATE

STATE2:
	LDR R1,=0b0100000010
	STR R1,[R7]
	b NEXT_STATE

STATE3:
	LDR R1,=0b0010000100
	STR R1,[R7]
	b NEXT_STATE

STATE4:
	LDR R1,=0b0001001000
	STR R1,[R7]
	b NEXT_STATE

STATE5:
	LDR R1,=0b0000110000
	STR R1,[R7]
	b NEXT_STATE

NEXT_STATE:
	CMP R2,#4 // At the middle, change direction to outwards
	MOVEQ R4,#1
	CMP R2,#0 // At the ends, change direction to inwards
	MOVEQ R4,#0

	CMP R4,#0
	ADDEQ R2,R2,#1 // Inwards, so increment up
	SUBGT R2,R2,#1 // Outwards, so increment down
	B DELAY

DELAY: 
	LDR R0, [R8, #0xC] // Timer status
	LDR R3, [R6] // Load keys
	CMP R3, #0b1000 // Key3 pressed
	BEQ TOGGLE
	
	CMP R0, #0 // Check if timed out
	BEQ DELAY // Zero: still counting, keep waiting
	STR R0, [R8, #0xC] // write 1 to status to reset F to 0

	CMP R2,#0 // Update state based on state counter
	BEQ STATE1
	CMP R2,#1
	BEQ STATE2
	CMP R2,#2
	BEQ STATE3
	CMP R2,#3
	BEQ STATE4
	CMP R2,#4
	BEQ STATE5


TOGGLE:
	LDR R0, [R8, #0xC] // Timer status
	LDR R3, [R6] // Load keys
	CMP R3, #0b1000 // Key3 pressed
	BLT RESET // Key3 released after being pressed
	CMP R0, #0
	BEQ TOGGLE	
	
	STR R0, [R8, #0xC] // storing status back
	
	CMP R2,#0 // Update state based on state counter
	BEQ STATE1
	CMP R2,#1
	BEQ STATE2
	CMP R2,#2
	BEQ STATE3
	CMP R2,#3
	BEQ STATE4
	CMP R2,#4
	BEQ STATE5
	
RESET:  // already first pressed + released
	LDR R3, [R6] // Load keys
	CMP R3, #0b1000 // Key3 pressed
	BEQ RESET_TOGGLE // pressed down again
	B RESET

RESET_TOGGLE: // already second pressed
	LDR R3, [R6] // Load keys
	CMP R3, #0b1000 // Key3 pressed
	BLT DELAY // released after second press - resume 
	B RESET_TOGGLE // still second pressed

.end

	