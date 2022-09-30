module part2(ClockIn, Reset, Speed, CounterValue);
	input ClockIn, Reset;
	input [1:0] Speed;
	output reg [3:0] CounterValue;
	
	reg [10:0] RateDivider;

	always @(posedge ClockIn)
	begin
		if (Reset == 1'b1) // assuming always start with reset
			begin
				RateDivider <= 11'b00000000000;
				CounterValue <= 4'b0000;
			end
		else if (RateDivider == 11'b00000000000)
			begin 
				CounterValue <= CounterValue + 1; 
				// increments when Rate Divider is 0
			
				if (Speed == 2'b00)
						RateDivider <= 11'b00000000000; // 1-1 (full)
				else if (Speed == 2'b01)
						RateDivider <= 11'b00111110011; // 500-1 (1 Hz)
				else if (Speed == 2'b10)
						RateDivider <= 11'b01111100111; // 1000-1 (0.5 Hz)
				else if (Speed == 2'b11)
						RateDivider <= 11'b11111001111; // 2000-1 (0.25 Hz)
			end
		else
			RateDivider <= RateDivider - 1;
	end
endmodule 