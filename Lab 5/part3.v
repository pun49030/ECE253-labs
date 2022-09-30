module part3(ClockIn, Resetn, Start, Letter, DotDashOut);
	input ClockIn, Resetn, Start;
	input [2:0] Letter;
	output reg DotDashOut;
	
	reg [11:0] Pattern;
	
	reg [11:0] cur_bitstream; // pattern is loaded into it
	
	reg [7:0] RateDivider; // 250 - 1 for 2 Hz (base is 500 Hz)
	
	reg [3:0] CounterValue; // counts through 12 bit pattern
	
	reg start_run; // triggered when start == 1
	

	always @(*)
	begin
		case(Letter)
			3'b000: Pattern = 12'b101110000000;
			3'b001: Pattern = 12'b111010101000;
			3'b010: Pattern = 12'b111010111010;
			3'b011: Pattern = 12'b111010100000;
			3'b100: Pattern = 12'b100000000000;
			3'b101: Pattern = 12'b101011101000;
			3'b110: Pattern = 12'b111011101000;
			3'b111: Pattern = 12'b101010100000;
			default: Pattern = 0;
		endcase
	end
	
	always @(posedge ClockIn or negedge Resetn)
	begin
		if (Start == 1'b1)
			start_run <= 1'b1;
			
		if (Resetn == 1'b0)
			begin
				cur_bitstream <= Pattern;
				start_run <= 1'b0;
				RateDivider <= 8'b00000000;
				DotDashOut <= 0;	
			end
		
		else
			begin
				if (RateDivider == 8'b00000000) // functions as enable block
					begin
						RateDivider <= 8'b11111001;
						if (start_run == 1'b1)
							begin
								DotDashOut <= cur_bitstream[11];
								cur_bitstream <= cur_bitstream << 1;
								cur_bitstream[0] <= cur_bitstream[11];
							end
					end
				else
					RateDivider <= RateDivider - 1;	
			end

	end
		
endmodule
