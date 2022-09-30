
module part3(clock, reset, ParallelLoadn, RotateRight, ASRight, Data_IN, Q);
	input clock, reset, ParallelLoadn, RotateRight, ASRight;
	input [7:0] Data_IN;
	output [7:0] Q;
	wire [7:0] w_a; // between set of muxes
	wire [7:0] w_b; // output of mux to input of flipflop
	wire [7:0] w_o; // outputs to connect
	wire w_rl;
	
	assign Q = w_o;
	
	// mux for arithmetic shift
	mux2to1 m_rl(
			.x(w_o[7]),
			.y(w_o[0]),
			.s(ASRight),
			.m(w_rl)
		);
	
	// unit 0
	mux2to1 m_0a(
			.x(w_o[1]), 
			.y(w_rl), 
			.s(RotateRight), 
			.m(w_a[0])
		);
	
	mux2to1 m_0b(
			.x(Data_IN[0]), 
			.y(w_a[0]), 
			.s(ParallelLoadn), 
			.m(w_b[0])
		);
	
	flipflop ff_0(
			.d(w_b[0]),
			.q(w_o[0]),
			.clock(clock),
			.reset(reset)
		);
	
	// unit 1
	mux2to1 m_1a(
			.x(w_o[2]), 
			.y(w_o[0]), 
			.s(RotateRight), 
			.m(w_a[1])
		);
	
	mux2to1 m_1b(
			.x(Data_IN[1]), 
			.y(w_a[1]), 
			.s(ParallelLoadn), 
			.m(w_b[1])
		);
	
	flipflop ff_1(
			.d(w_b[1]),
			.q(w_o[1]),
			.clock(clock),
			.reset(reset)
		);
	
	// unit 2
	mux2to1 m_2a(
			.x(w_o[3]), 
			.y(w_o[1]), 
			.s(RotateRight), 
			.m(w_a[2])
		);
	
	mux2to1 m_2b(
			.x(Data_IN[2]), 
			.y(w_a[2]), 
			.s(ParallelLoadn), 
			.m(w_b[2])
		);
	
	flipflop ff_2(
			.d(w_b[2]),
			.q(w_o[2]),
			.clock(clock),
			.reset(reset)
		);
		
	// unit 3
	mux2to1 m_3a(
			.x(w_o[4]), 
			.y(w_o[2]), 
			.s(RotateRight), 
			.m(w_a[3])
		);
	
	mux2to1 m_3b(
			.x(Data_IN[3]), 
			.y(w_a[3]), 
			.s(ParallelLoadn), 
			.m(w_b[3])
		);
	
	flipflop ff_3(
			                                                                                                                                                         
		
	// unit 4
	mux2to1 m_4a(
			.x(w_o[5]), 
			.y(w_o[3]), 
			.s(RotateRight), 
			.m(w_a[4])
		);
	
	mux2to1 m_4b(
			.x(Data_IN[4]), 
			.y(w_a[4]), 
			.s(ParallelLoadn), 
			.m(w_b[4])
		);
	
	flipflop ff_4(
			.d(w_b[4]),
			.q(w_o[4]),
			.clock(clock),
			.reset(reset)
		);
		
	// unit 5
	mux2to1 m_5a(
			.x(w_o[6]), 
			.y(w_o[4]), 
			.s(RotateRight), 
			.m(w_a[5])
		);
	
	mux2to1 m_5b(
			.x(Data_IN[5]), 
			.y(w_a[5]), 
			.s(ParallelLoadn), 
			.m(w_b[5])
		);
	
	flipflop ff_5(
			.d(w_b[5]),
			.q(w_o[5]),
			.clock(clock),
			.reset(reset)
		);
		
	// unit 6
	mux2to1 m_6a(
			.x(w_o[7]), 
			.y(w_o[5]), 
			.s(RotateRight), 
			.m(w_a[6])
		);
	
	mux2to1 m_6b(
			.x(Data_IN[6]), 
			.y(w_a[6]), 
			.s(ParallelLoadn), 
			.m(w_b[6])
		);
	
	flipflop ff_6(
			.d(w_b[6]),
			.q(w_o[6]),
			.clock(clock),
			.reset(reset)
		);

	// unit 7
	mux2to1 m_7a(
			.x(w_o[0]), 
			.y(w_o[6]), 
			.s(RotateRight), 
			.m(w_a[7])
		);
	
	mux2to1 m_7b(
			.x(Data_IN[7]), 
			.y(w_a[7]), 
			.s(ParallelLoadn), 
			.m(w_b[7])
		);
	
	flipflop ff_7(
			.d(w_b[7]),
			.q(w_o[7]),
			.clock(clock),
			.reset(reset)
		);

endmodule
		
module flipflop(d, q, clock, reset);
	input d, clock, reset;
	
	output reg q;
	
	always@(posedge clock)
	begin
		if (reset == 1'b1)
			q <= 0;
		else
			q <= d;
	end
endmodule


module mux2to1(x, y, s, m);
   input x; //select 0
   input y; //select 1
   input s; //select signal
   output m; //output
	
	wire w1, w2, w3;
	
	v7404 u1(
			.pin1(s),
			.pin2(w1)
		);
	
	v7408 u2(
			.pin1(x),
			.pin2(w1),
			.pin3(w2),
			.pin4(s),
			.pin5(y),
			.pin6(w3)
		);
	
	v7432 u3(
			.pin1(w2),
			.pin2(w3),
			.pin3(m)
		);
	
endmodule

module v7404(input pin1, pin3, pin5, pin9, pin11, pin13,
				output pin2, pin4, pin6, pin8, pin10, pin12);
	assign pin2 = ~pin1;
	assign pin4 = ~pin3;
	assign pin6 = ~pin5;
	assign pin8 = ~pin9;
	assign pin10 = ~pin11;
	assign pin12 = ~pin13;
endmodule

module v7408(input pin1, pin2, pin4, pin5, pin9, pin10, pin12, pin13,
				output pin3, pin6, pin8, pin11);
	assign pin3 = pin1 & pin2;
	assign pin6 = pin4 & pin5;
	assign pin8 = pin9 & pin10;
	assign pin11 = pin12 & pin13;
endmodule

module v7432(input pin1, pin2, pin4, pin5, pin9, pin10, pin12, pin13,
				output pin3, pin6, pin8, pin11);
	assign pin3 = pin1 | pin2;
	assign pin6 = pin4 | pin5;
	assign pin8 = pin9 | pin10;
	assign pin11 = pin12 | pin13;
endmodule
