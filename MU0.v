module MU0(in_data, rst_n, clk,
          out_data, out_address, memrq, rnw);
    
    input [15:0]in_data;
    input rst_n, clk;
    output [15:0] out_data;
    output [11:0] out_address;
    output memrq, rnw;
    wire acc_ce, acc_oe, acc_15, accz;
    wire a_sel, b_sel, pc_ce, ir_ce;
    wire [2:0] alufs;
    wire [3:0] opcode;
    wire [11:0] addr_from_pc, addr_from_ir;
    wire [15:0] data_alu, data_mux, data_acToAlu;
    
    ACC u_acc(.in_data(data_alu), .acc_ce(acc_ce), .acc_oe(acc_oe), .clk(clk),
           .out_to_bus(out_data), .out_data(data_acToAlu),.acc_15(acc_15), .accz(accz));
    ALU u_alu(.in_A(data_acToAlu), .in_B(data_mux), .alufs(alufs),
           .out(data_alu));
    control_logic u_control_logic(.in_opcode(opcode), .acc_15(acc_15), .accz(accz), .clk(clk), .rst_n(rst_n),
           .a_sel(a_sel), .b_sel(b_sel), .pc_ce(pc_ce), .ir_ce(ir_ce), .acc_ce(acc_ce), .acc_oe(acc_oe), .alufs(alufs),
           .rnw(rnw), .memrq(memrq));
    IR u_ir(.in_instruction(in_data), .ir_ce(ir_ce), .clk(clk),
          .out_opcode(opcode), .out_address(addr_from_ir));
    mux_2to1 #(.WORD(12)) u_mux_a(.i0(addr_from_pc), .i1(addr_from_ir), .sel(a_sel),
                .out(out_address));
    mux_2to1 u_mux_b(.i0({4'b0000,out_address}), .i1(in_data), .sel(b_sel),
                .out(data_mux));
    PC u_pc(.in_address(data_alu), .pc_ce(pc_ce), .clk(clk),
          .out_address(addr_from_pc));

endmodule
