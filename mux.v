module mux_2 (input s, input a, input b, output q);
    assign q = (a & ~s) | (b & s);
endmodule

module mux_4 (input [1:0] s, input a, input b, input c, input d, output q);
    assign q = (s == 2'b00) ? a :
               (s == 2'b01) ? b :
               (s == 2'b10) ? c :
                              d;
endmodule