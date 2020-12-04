module IR(in_instruction, ir_ce, clk,
          out_opcode, out_address);
    
    input [15:0]in_instruction;
    input ir_ce, clk;
    output reg [3:0] out_opcode;
    output reg [11:0] out_address;
    
    always @(posedge clk)
    if (ir_ce)
        begin
            out_opcode  <= in_instruction[15:12];
            out_address <= in_instruction[11:0];
        end
    
endmodule
