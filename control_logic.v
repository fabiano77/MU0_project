module control_logic(in_opcode,
                     acc_15,
                     accz,
                     clk,
                     rst_n,
                     a_sel,
                     b_sel,
                     pc_ce,
                     ir_ce,
                     acc_ce,
                     acc_oe,
                     alufs,
                     rnw,
                     memrq);
    
    input [3:0] in_opcode;
    input acc_15, accz, clk, rst_n;
    output reg [2:0] alufs;
    output reg a_sel, b_sel, pc_ce, ir_ce, acc_ce, acc_oe;
    output reg rnw, memrq;
    
    reg ft, n_ft;
    reg [6:0] p_state; // 7'b_0000_000
    
    always @(*) begin
            if(rst_n == 1) p_state <= {in_opcode, ft, accz, acc_15};
    end
    
    always @(*) begin
        if(rst_n == 1)
        case (in_opcode)
            4'b_0000: if(ft == 0) n_ft <= 1; else n_ft <= 0;
            4'b_0001: if(ft == 0) n_ft <= 1; else n_ft <= 0;
            4'b_0010: if(ft == 0) n_ft <= 1; else n_ft <= 0;
            4'b_0011: if(ft == 0) n_ft <= 1; else n_ft <= 0;

            4'b_0100: n_ft <= 0;
            4'b_0101: n_ft <= 0;
            4'b_0110: n_ft <= 0;
            4'b_0111: n_ft <= 0;

            default:  n_ft <= 1'b_x;
        endcase
    end

    always @(posedge clk) begin
        if(~rst_n) begin
            ft <= 1'b_0; n_ft <= 1'b_0;
        end
        else
            ft <= n_ft;
    end
    
    
    always @(p_state or negedge rst_n) begin
        if (~rst_n) begin
            {a_sel, b_sel, acc_ce, pc_ce, ir_ce, acc_oe, memrq, rnw} <= {8'b_0_0_1_1_1_0__1_1}; alufs <= 0;
        end
        else begin
            casex (p_state)
                //LDA S
                7'b_0000_0xx: begin {a_sel, b_sel, acc_ce, pc_ce, ir_ce, acc_oe, memrq, rnw} <= {8'b_1_1_1_0_0_0__1_1}; alufs <= 3;end
                7'b_0000_1xx: begin {a_sel, b_sel, acc_ce, pc_ce, ir_ce, acc_oe, memrq, rnw} <= {8'b_0_0_0_1_1_0__1_1}; alufs <= 4;end
                //STO S
                7'b_0001_0xx: begin {a_sel, b_sel, acc_ce, pc_ce, ir_ce, acc_oe, memrq, rnw} <= {8'b_1_x_0_0_0_1__1_0}; alufs <= 3'bx;end
                7'b_0001_1xx: begin {a_sel, b_sel, acc_ce, pc_ce, ir_ce, acc_oe, memrq, rnw} <= {8'b_0_0_0_1_1_0__1_1}; alufs <= 4;end
                //ADD S
                7'b_0010_0xx: begin {a_sel, b_sel, acc_ce, pc_ce, ir_ce, acc_oe, memrq, rnw} <= {8'b_1_1_1_0_0_0__1_1}; alufs <= 1;end
                7'b_0010_1xx: begin {a_sel, b_sel, acc_ce, pc_ce, ir_ce, acc_oe, memrq, rnw} <= {8'b_0_0_0_1_1_0__1_1}; alufs <= 4;end
                //SUB S
                7'b_0011_0xx: begin {a_sel, b_sel, acc_ce, pc_ce, ir_ce, acc_oe, memrq, rnw} <= {8'b_1_1_1_0_0_0__1_1}; alufs <= 2;end
                7'b_0011_1xx: begin {a_sel, b_sel, acc_ce, pc_ce, ir_ce, acc_oe, memrq, rnw} <= {8'b_0_0_0_1_1_0__1_1}; alufs <= 4;end
                //JMP S
                7'b_0100_xxx: begin {a_sel, b_sel, acc_ce, pc_ce, ir_ce, acc_oe, memrq, rnw} <= {8'b_1_0_0_1_1_0__1_1}; alufs <= 4;end
                //JGE S
                7'b_0101_xx0: begin {a_sel, b_sel, acc_ce, pc_ce, ir_ce, acc_oe, memrq, rnw} <= {8'b_1_0_0_1_1_0__1_1}; alufs <= 4;end
                7'b_0101_xx1: begin {a_sel, b_sel, acc_ce, pc_ce, ir_ce, acc_oe, memrq, rnw} <= {8'b_0_0_0_1_1_0__1_1}; alufs <= 4;end
                //JNE S
                7'b_0110_x0x: begin {a_sel, b_sel, acc_ce, pc_ce, ir_ce, acc_oe, memrq, rnw} <= {8'b_1_0_0_1_1_0__1_1}; alufs <= 4;end
                7'b_0110_x1x: begin {a_sel, b_sel, acc_ce, pc_ce, ir_ce, acc_oe, memrq, rnw} <= {8'b_0_0_0_1_1_0__1_1}; alufs <= 4;end
                //STOP
                7'b_0111_xxx: begin {a_sel, b_sel, acc_ce, pc_ce, ir_ce, acc_oe, memrq, rnw} <= {8'b_1_x_0_0_0_0__0_1}; alufs <= 3'bx;end

                default: begin {a_sel, b_sel, acc_ce, pc_ce, ir_ce, acc_oe, memrq, rnw} <= {8'b_x_z_x_z_x_z__x_1}; alufs <= 3'd_7;end
            endcase
        end
    end
    
    
endmodule
    
