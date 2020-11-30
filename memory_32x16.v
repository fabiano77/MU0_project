module memory_32x16(in_data, addr, clk, memrq, rw, mem_rst_n,
              out_data);
    
    input [15:0]in_data;
    input [11:0]addr;
    input mem_rst_n;
    input clk, memrq, rw;
    output reg [15:0] out_data;

    reg [15:0] memory [0:31];
    reg r_state;


    // always @(posedge clk) begin //최후 best
    //     if (memrq) begin
    //         if(rw) begin
    //             out_data <= memory[addr];
    //         end
    //         else begin
    //             memory[addr] <= in_data;
    //             out_data <= 16'bzzzz_1111_zzzz_1111;
    //             //memory[addr] <= in_data;
    //             //out_data <= memory[addr-1];
    //         end
    //     end
    // end
    
    // always @(posedge clk) begin //두번째 best
    //     if (memrq) 
    //     begin
    //         if(rw) 
    //         begin
    //             //out_data <= memory[addr];
    //             r_state = 1;
    //         end
    //         else 
    //         begin
    //             r_state = 0;
    //             memory[addr] = in_data;
    //             //out_data <= 16'b1111_1111_1111_1111;
    //             //memory[addr] <= in_data;
    //             //out_data <= memory[addr-1];
    //         end
    //     end
    // end

    // always @(*)
    //     if(memrq)
    //         if(r_state) out_data = memory[addr];

    always @(posedge clk) begin 
        if (memrq) 
        begin
            if(rw) 
            begin
                r_state = 1;
            end
            else 
            begin
                r_state = 0;
                memory[addr] = in_data;

            end
        end
    end

    always @(*)
        if(memrq)
            if(rw) out_data = memory[addr];

endmodule

    
