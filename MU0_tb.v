`timescale 1 ns/100ps
module MU0_tb();
    
    reg rst_n, clk;
    wire [15:0] data_mu0, data_memory;
    wire [11:0] addr_mu0;
    wire memrq, rnw;    

    MU0   u_mu0(.in_data(data_memory), .rst_n(rst_n), .clk(clk),
          .out_data(data_mu0), .out_address(addr_mu0), .memrq(memrq), .rnw(rnw));
    memory_32x16  u_memory (.in_data(data_mu0), .addr(addr_mu0), .clk(clk), .memrq(memrq), .rw(rnw),
            .out_data(data_memory));

    initial begin
        clk <= 0; rst_n <= 0; force u_memory.rw = 0; force u_memory.memrq = 1;           // ---- 이하 명령어 영역 ----
        #10 force u_memory.addr =  0; force u_memory.in_data = 16'b_0000_0000_0001_0011; // LDA S    m[19]
        #10 force u_memory.addr =  1; force u_memory.in_data = 16'b_0001_0000_0001_0010; // STO sum  m[18]
        #10 force u_memory.addr =  2; force u_memory.in_data = 16'b_0001_0000_0001_0001; // STO i    m[17]
        #10 force u_memory.addr =  3; force u_memory.in_data = 16'b_0011_0000_0001_0000; // SUB N    m[16]
        #10 force u_memory.addr =  4; force u_memory.in_data = 16'b_0110_0000_0000_0110; // JNE loop1 
        #10 force u_memory.addr =  5; force u_memory.in_data = 16'b_0111_0000_0000_0000; // STP
        #10 force u_memory.addr =  6; force u_memory.in_data = 16'b_0000_0000_0001_0001; // LDA i m[17] --- loop1 ----
        #10 force u_memory.addr =  7; force u_memory.in_data = 16'b_0010_0000_0001_0100; // ADD v1   m[20]
        #10 force u_memory.addr =  8; force u_memory.in_data = 16'b_0001_0000_0001_0001; // STO i    m[17]
        #10 force u_memory.addr =  9; force u_memory.in_data = 16'b_0010_0000_0001_0010; // ADD sum  m[18]
        #10 force u_memory.addr = 10; force u_memory.in_data = 16'b_0001_0000_0001_0010; // STO sum  m[18]
        #10 force u_memory.addr = 11; force u_memory.in_data = 16'b_0000_0000_0001_0001; // LDA i    m[17]
        #10 force u_memory.addr = 12; force u_memory.in_data = 16'b_0011_0000_0001_0000; // SUB N    m[16]
        #10 force u_memory.addr = 13; force u_memory.in_data = 16'b_0110_0000_0000_0110; // JNE loop1
        #10 force u_memory.addr = 14; force u_memory.in_data = 16'b_0111_0000_0000_0000; // STP
        #10 force u_memory.addr = 15; force u_memory.in_data = 16'b_xxxx_xxxx_xxxx_xxxx; // ---- 이하 데이터 영역 ----
        #10 force u_memory.addr = 16; force u_memory.in_data = 16'b_0000_0000_0001_0101; // N    m[16] = 21
        #10 force u_memory.addr = 17; force u_memory.in_data = 16'b_0000_0000_0000_0000; // i    m[17]
        #10 force u_memory.addr = 18; force u_memory.in_data = 16'b_0000_0000_0000_0000; // sum  m[18]
        #10 force u_memory.addr = 19; force u_memory.in_data = 16'b_0000_0000_0000_1111; // S    m[19] = 15
        #10 force u_memory.addr = 20; force u_memory.in_data = 16'b_0000_0000_0000_0001; // v1   m[20]
        #10 release u_memory.memrq; release u_memory.addr; release u_memory.in_data;release u_memory.rw; 
        #25 rst_n <= 1;
        
    end

    always
        #5 clk <= ~clk;
    
endmodule