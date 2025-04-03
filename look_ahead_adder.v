module cla_adder_subtractor (
    input [3:0] A, B,  // 4-bit inputs
    input M,           // Mode: 0 for addition, 1 for subtraction
    output [3:0] S,    // 4-bit Sum/Difference output
    output Cout        // Carry/Borrow out
);
    wire [3:0] B_xor;  // XORed B for subtraction
    wire [3:0] G, P;   // Generate and Propagate
    wire [3:0] C;      // Carry signals

    assign B_xor = B ^ {4{M}};  // XOR B with M (B' when M=1)
    assign G = A & B_xor;       // Generate: G_i = A_i * B'_i
    assign P = A ^ B_xor;       // Propagate: P_i = A_i ? B'_i

    // Carry Look-Ahead Logic
    assign C[0] = M;  // Initial carry is M (1 for subtraction)
    assign C[1] = G[0] | (P[0] & C[0]);
    assign C[2] = G[1] | (P[1] & C[1]);
    assign C[3] = G[2] | (P[2] & C[2]);
    assign Cout = G[3] | (P[3] & C[3]);  // Final carry out

    assign S = P ^ C;  // Sum/Difference: S_i = P_i ? C_i

endmodule
