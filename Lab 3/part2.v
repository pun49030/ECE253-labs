module part2(a, b, c_in, s, c_out);
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
	
	

