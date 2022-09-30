module part2(Clock, Reset_b, Data, Function, ALUout);

input [3:0] Data;
input Clock, Reset_b;
input [2:0] Function;
output reg [7:0] ALUout;

wire [3:0] add_result;
wire [3:0] carry;

wire c_in;
assign c_in = 0;

adder u0( // computing adder outside of always
			.a(Data),
			.b(ALUout[3:0]),
			.c_in(c_in),
			.s(add_result), 
			.c_out(carry) // sets to digit 5 of output
		);

always @(posedge Clock)
begin
	case (Function[2:0])
		3'b000: begin // assigning pre-computed adder result
					ALUout <= 0; 
					ALUout[4] <= carry[3];
					ALUout[3:0] <= add_result[3:0]; 
				end
		3'b001:  ALUout <= Data + ALUout[3:0]; 
		3'b010: begin 
					ALUout[7] <= ALUout[3]; //{ALUout[3],ALUout[3],ALUout[3],ALUout[3],ALUout[3:0]}
					ALUout[6] <= ALUout[3];
					ALUout[5] <= ALUout[3];
					ALUout[4] <= ALUout[3];
					ALUout[3:0] <= ALUout[3:0];
				end
		3'b011: begin 
					ALUout <= 0;
					ALUout[0] <= Data[0] | Data[1] | Data[2] | Data[3] | ALUout[0] | ALUout[1] | ALUout[2] | ALUout[3];
				end
		3'b100: begin 
					ALUout <= 0;
					ALUout[0] <= Data[0] & Data[1] & Data[2] & Data[3] & ALUout[0] & ALUout[1] & ALUout[2] & ALUout[3];
				end
		3'b101: begin
					ALUout <= ALUout[3:0] << Data;
				end
		3'b110: begin
					ALUout <= Data * ALUout[3:0];
				end
		3'b111: begin
					ALUout <= ALUout;
				end
		default: ALUout <= 0;
	endcase
	if (Reset_b == 1'b0)
		ALUout <= 0;
end

endmodule

module adder(a, b, c_in, s, c_out);
	input [3:0] a;
	input [3:0] b;
	input c_in;
	output [3:0] c_out;
	output [3:0] s;
	
	wire c1, c2, c3;
	
	full_adder u1(
				.a(a[0]),
				.b(b[0]),
				.c_in(c_in),
				.s(s[0]),
				.c_out(c1)
			);

	full_adder u2(
				.a(a[1]),
				.b(b[1]),
				.c_in(c1),
				.s(s[1]),
				.c_out(c2)
			);
			
	full_adder u3(
				.a(a[2]),
				.b(b[2]),
				.c_in(c2),
				.s(s[2]),
				.c_out(c3)
			);
			
	full_adder u4(
				.a(a[3]),
				.b(b[3]),
				.c_in(c3),
				.s(s[3]),
				.c_out(c_out[3])
			);
	
	assign c_out[2] = c3;
	assign c_out[1] = c2;
	assign c_out[0] = c1;
	
endmodule

module full_adder(a, b, c_in, s, c_out);
	input a, b, c_in;
	output s, c_out;
	
	assign c_out = (a & b) + (c_in & a) + (c_in & b);
	assign s = c_in ^ a ^ b;
endmodule
	
	


