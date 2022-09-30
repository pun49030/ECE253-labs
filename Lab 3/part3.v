module part3(A, B, Function, ALUout);
input [3:0] A;
input [3:0] B;
input [2:0] Function;
output [7:0] ALUout;
wire [3:0] add_result;
wire [3:0] carry;
wire c_in;
assign c_in = 0;
adder u0( // computing adder outside of always
			.a(A),
			.b(B),
			.c_in(c_in),
			.s(add_result), 
			.c_out(carry) // sets to digit 5 of output
		);			
reg [7:0] ALUout;
always @(*)
begin
	case (Function[2:0])
		3'b000: begin // assigning pre-computed adder result
					ALUout = 0; 
					ALUout[4] = carry[3];
					ALUout[3] = add_result[3]; 
					ALUout[2] = add_result[2];
					ALUout[1] = add_result[1];
					ALUout[0] = add_result[0];
			end
		3'b001:  ALUout = A + B; 
		default: ALUout = 0;
	endcase
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
	
	


