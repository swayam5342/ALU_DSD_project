module look_ahead (
    input  [3:0] A,
    input  [3:0] B,
    input   Cin,
    output [3:0] Sum,
    output       Cout
);
    wire [3:0] G;
    wire [3:0] P; 
    wire [4:0] C; 
    assign G = A & B;   
    assign P = A ^ B; 
    assign C[0] = Cin;   
    assign C[1] = G[0] | (P[0] & C[0]);
    assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & C[0]);
    assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & C[0]);
    assign C[4] = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & C[0]);
    assign Sum = P ^ C[3:0];
    assign Cout = C[4];
endmodule


module mux_2 (input s, input [3:0] a, input [3:0] b, output [3:0] q);
    assign q = (s==1'b0) ? a : b;
endmodule

module mux_4 (input [1:0] s, input [3:0] a, input [3:0] b, input [3:0] c, input [3:0] d, output [3:0] q);
    assign q = (s == 2'b00) ? a :
               (s == 2'b01) ? b :
               (s == 2'b10) ? c :
                d;
endmodule


module ripple_adder (
    input [3:0] A, B,
    input cin,
    output [3:0] S,
    output Cout
);
    wire [3:0] C;
    full_adder FA0 (A[0], B[0], cin,   S[0], C[0]);
    full_adder FA1 (A[1], B[1], C[0],  S[1], C[1]);	
    full_adder FA2 (A[2], B[2], C[1],  S[2], C[2]);
    full_adder FA3 (A[3], B[3], C[2],  S[3], Cout);
endmodule


module alu(
    input [3:0] op,
    input [3:0] a, b,
    output [3:0] y,
    output cout, neg,zero,overflow
);
wire [3:0] a_mux, b_mux, xor_w, and_w, or_w, s_w,a_not,b_not;
wire cout_w;
assign a_not = ~a;
assign b_not = ~b;
mux_2 muxa(.s(op[3]), .a(a), .b(a_not), .q(a_mux));
mux_2 muxb(.s(op[2]), .a(b), .b(b_not), .q(b_mux));
assign xor_w = a_mux ^ b_mux;
assign or_w = a_mux | b_mux;
assign and_w = a_mux & b_mux;

look_ahead adder1(.A(a_mux), .B(b_mux), .Cin(op[2]), .Sum(s_w), .Cout(cout_w));

//mux_4 mux2(.s(op[1:0]),.a(and_w),.b(or_w),.c(xor_w),.d(sw),.q(y));

assign y = (op[1:0] == 2'b00) ? and_w :
           (op[1:0] == 2'b01) ? or_w :
           (op[1:0] == 2'b10) ? xor_w :
           s_w;
assign cout = (op[1:0] == 2'b11) ? cout_w : 1'b0;
assign neg = (op[1:0] == 2'b11) ? (~cout_w & op[2]) : 1'b0;
assign zero = (y==4'b000) ? 1'b1 : 1'b0;
assign overflow = (op[1:0] == 2'b11) ? ((a_mux[3] & b_mux[3] & ~s_w[3])|(~a_mux[3] & ~b_mux[3] & s_w[3])) : 1'b0;
endmodule