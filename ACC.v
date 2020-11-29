module ACC(in_data, acc_ce, acc_oe, clk,
           out_data, out_to_bus, acc_15, accz);
    
    input [15:0] in_data;
    input acc_ce, acc_oe, clk;
    output reg [15:0] out_data, out_to_bus;
    output reg acc_15, accz;
    
    always @(posedge clk) begin
        if (acc_ce)
            out_data <= in_data;
    end
    
    always @(out_data) begin
        acc_15 <= out_data[15];
        accz   <= ~|out_data;
    end

    always @(*)
        if (acc_oe)
            out_to_bus <= out_data;
        else 
            out_to_bus <= 16'b_zzzz_xxxx_zzzz_xxxx;
    
    
    
endmodule
