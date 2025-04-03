module tb_ripple_adder_subtractor;
    reg [3:0] A, B;  // 4-bit inputs
    reg M;           // Mode: 0 for add, 1 for subtract
    wire [3:0] S;    // 4-bit sum/difference output
    wire Cout;       // Carry/Borrow out

    // Instantiate the DUT (Device Under Test)
    ripple_adder_subtractor uut (
        .A(A),
        .B(B),
        .M(M),
        .S(S),
        .Cout(Cout)
    );

    initial begin
        // Monitor outputs
        $monitor("Time=%0t | A=%b, B=%b, M=%b | S=%b, Cout=%b", $time, A, B, M, S, Cout);

        // Test addition (M = 0)
        A = 4'b0011; B = 4'b0001; M = 0; #10;  // 3 + 1 = 4
        A = 4'b0101; B = 4'b0011; M = 0; #10;  // 5 + 3 = 8
        A = 4'b1111; B = 4'b0001; M = 0; #10;  // 15 + 1 = 16 (overflow)

        // Test subtraction (M = 1)
        A = 4'b0100; B = 4'b0001; M = 1; #10;  // 4 - 1 = 3
        A = 4'b0110; B = 4'b0011; M = 1; #10;  // 6 - 3 = 3
        A = 4'b0001; B = 4'b0010; M = 1; #10;  // 1 - 2 = -1 (two?s complement: 1111)

        // End simulation
        $finish;
    end
endmodule
