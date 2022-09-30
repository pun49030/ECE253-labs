module part1(Clock, Enable, Clear_b, CounterValue);
	input Clock, Enable, Clear_b;
	output [7:0] CounterValue;
	
	wire [7:0] T;
	wire [7:0] B;
	
	t_ff u0(
		.Clock(Clock),
		.Enable(Enable),
		.Clear_b(Clear_b),
		.Q(B[0])
	);
	
	assign T[0] = Enable;
	assign CounterValue[0] = B[0];
	
	assign T[1] = T[0] & B[0];
	
	t_ff u1(
		.Clock(Clock),
		.Enable(T[1]),
		.Clear_b(Clear_b),
		.Q(B[1])
	);
	
	assign CounterValue[1] = B[1];
	assign T[2] = T[1] & B[1];
	
	t_ff u2(
		.Clock(Clock),
		.Enable(T[2]),
		.Clear_b(Clear_b),
		.Q(B[2])
	);
	
	assign CounterValue[2] = B[2];
	assign T[3] = T[2] & B[2];
	
	t_ff u3(
		.Clock(Clock),
		.Enable(T[3]),
		.Clear_b(Clear_b),
		.Q(B[3])
	);
	
	assign CounterValue[3] = B[3];
	assign T[4] = T[3] & B[3];

	t_ff u4(
		.Clock(Clock),
		.Enable(T[4]),
		.Clear_b(Clear_b),
		.Q(B[4])
	);
	
	assign CounterValue[4] = B[4];
	assign T[5] = T[4] & B[4];
	
	t_ff u5(
		.Clock(Clock),
		.Enable(T[5]),
		.Clear_b(Clear_b),
		.Q(B[5])
	);
	
	assign CounterValue[5] = B[5];
	assign T[6] = T[5] & B[5];
	
	t_ff u6(
		.Clock(Clock),
		.Enable(T[6]),
		.Clear_b(Clear_b),
		.Q(B[6])
	);
	
	assign CounterValue[6] = B[6];
	assign T[7] = T[6] & B[6];
	
		t_ff u7(
		.Clock(Clock),
		.Enable(T[7]),
		.Clear_b(Clear_b),
		.Q(B[7])
	);
	
	assign CounterValue[7] = B[7];
	
endmodule
	
module t_ff(Clock, Enable, Clear_b, Q);
	input Clock, Enable, Clear_b;
	output reg Q;
	
	always@(posedge Clock)
		begin
			if (Clear_b == 1'b0)
				Q <= 0;
			else if (Enable == 1'b1)
				Q <= ~Q;
			else
				Q <= Q;

		end
endmodule
