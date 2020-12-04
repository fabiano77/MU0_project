module mux_2to1(i0, i1, sel, out);
    
    parameter WORD = 16;
    input [WORD-1:0]i0, i1;
    input sel;
    output reg [WORD-1:0] out;
    
    always @(*)
        case (sel)
            1'b0: out    <= i0;
            1'b1: out    <= i1;
            default: out <= 16'bzzzz_zzzz_zzzz_zzzz;
        endcase
    
    
endmodule
