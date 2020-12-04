module memory_32x16(in_data, addr, clk, memrq, rw, mem_rst_n,
              out_data);
    
    input [15:0]in_data;
    input [11:0]addr;
    input mem_rst_n;
    input clk, memrq, rw;
    output reg [15:0] out_data;

    reg [15:0] memory [0:31];
    reg r_state;

    always @(posedge clk) begin 
        if (memrq) 
            if(rw) 
                r_state = 1;
            else begin
                r_state = 0;
                memory[addr] = in_data;
            end
    end

    always @(*)
        if(memrq)
            if(rw) out_data = memory[addr];

endmodule