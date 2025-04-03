module full_adder (
    input A, B, Cin, 
    output Sum, Cout
);
    assign Sum = A ^ B ^ Cin;
    assign Cout = (A & B) | (B & Cin) | (A & Cin);
endmodule

module ripple_adder_subtractor (
    input [3:0] A, B,  // 4-bit inputs
    input M,           // Mode: 0 for addition, 1 for subtraction
    output [3:0] S,    // 4-bit sum/difference output
    output Cout        // Carry/Borrow out
);
    wire [3:0] B_xor;  // XORed B for subtraction
    wire [3:0] C;      // Carry signals

    assign B_xor = B ^ {4{M}};  // Invert B when M = 1 (B')

    // Instantiate full adders for each bit
    full_adder FA0 (A[0], B_xor[0], M,     S[0], C[0]);
    full_adder FA1 (A[1], B_xor[1], C[0],  S[1], C[1]);
    full_adder FA2 (A[2], B_xor[2], C[1],  S[2], C[2]);
    full_adder FA3 (A[3], B_xor[3], C[2],  S[3], Cout);

endmodule
