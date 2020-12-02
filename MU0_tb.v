`timescale 1 ns/100ps
module MU0_tb();
    
    reg rst_n, clk, mem_rst_n;
    wire [15:0] data_mu0, data_memory;
    wire [11:0] addr_mu0;
    wire memrq, rnw;    

    MU0   u_mu0(.in_data(data_memory), .rst_n(rst_n), .clk(clk),
          .out_data(data_mu0), .out_address(addr_mu0), .memrq(memrq), .rnw(rnw));
    memory_32x16  u_memory (.in_data(data_mu0), .addr(addr_mu0), .clk(clk), .memrq(memrq), .rw(rnw), .mem_rst_n(mem_rst_n),
            .out_data(data_memory));

    initial begin
rst_n <= 1; clk <= 0; mem_rst_n <= 0; force u_memory.rw = 0; force u_memory.memrq = 1; 
#5 force u_memory.addr = 0; force u_memory.in_data = 16'b_0000_0000_0001_0011; #5 clk <= 1; rst_n <= 0; #5 clk <= 0; #5 clk <= 1; //LDA S mem[19]
        #5 clk <= 0; force u_memory.addr =  1; force u_memory.in_data = 16'b_0001_0000_0001_0010; #5 clk <= 1; #5 clk <= 0; #5 clk <= 1;  //STO sum mem[18]
        #5 clk <= 0; force u_memory.addr =  2; force u_memory.in_data = 16'b_0001_0000_0001_0001; #5 clk <= 1; #5 clk <= 0; #5 clk <= 1;  //STO i mem[17]
        #5 clk <= 0; force u_memory.addr =  3; force u_memory.in_data = 16'b_0011_0000_0001_0000; #5 clk <= 1; #5 clk <= 0; #5 clk <= 1;  //SUB N mem[16]
        #5 clk <= 0; force u_memory.addr =  4; force u_memory.in_data = 16'b_0110_0000_0000_0110; #5 clk <= 1; #5 clk <= 0; #5 clk <= 1;  //JNE loop1
        #5 clk <= 0; force u_memory.addr =  5; force u_memory.in_data = 16'b_0111_0000_0000_0000; #5 clk <= 1; #5 clk <= 0; #5 clk <= 1;  //STP
        #5 clk <= 0; force u_memory.addr =  6; force u_memory.in_data = 16'b_0000_0000_0001_0001; #5 clk <= 1; #5 clk <= 0; #5 clk <= 1;  //loop1 LDA i
        #5 clk <= 0; force u_memory.addr =  7; force u_memory.in_data = 16'b_0010_0000_0001_0100; #5 clk <= 1; #5 clk <= 0; #5 clk <= 1;  //ADD v1
        #5 clk <= 0; force u_memory.addr =  8; force u_memory.in_data = 16'b_0001_0000_0001_0001; #5 clk <= 1; #5 clk <= 0; #5 clk <= 1;  //STO i
        #5 clk <= 0; force u_memory.addr =  9; force u_memory.in_data = 16'b_0010_0000_0001_0010; #5 clk <= 1; #5 clk <= 0; #5 clk <= 1;  //ADD sum
        #5 clk <= 0; force u_memory.addr = 10; force u_memory.in_data = 16'b_0001_0000_0001_0010; #5 clk <= 1; #5 clk <= 0; #5 clk <= 1;  //STO sum
        #5 clk <= 0; force u_memory.addr = 11; force u_memory.in_data = 16'b_0000_0000_0001_0001; #5 clk <= 1; #5 clk <= 0; #5 clk <= 1;  //LDA i
        #5 clk <= 0; force u_memory.addr = 12; force u_memory.in_data = 16'b_0011_0000_0001_0000; #5 clk <= 1; #5 clk <= 0; #5 clk <= 1;  //SUB N
        #5 clk <= 0; force u_memory.addr = 13; force u_memory.in_data = 16'b_0110_0000_0000_0110; #5 clk <= 1; #5 clk <= 0; #5 clk <= 1;  //JNE loop1
        #5 clk <= 0; force u_memory.addr = 14; force u_memory.in_data = 16'b_0111_0000_0000_0000; #5 clk <= 1; #5 clk <= 0; #5 clk <= 1;  //STP
        #5 clk <= 0; force u_memory.addr = 15; force u_memory.in_data = 16'b_xxxx_xxxx_xxxx_xxxx; #5 clk <= 1; #5 clk <= 0; #5 clk <= 1;  //----
        #5 clk <= 0; force u_memory.addr = 16; force u_memory.in_data = 16'b_0000_0000_0001_0010; #5 clk <= 1; #5 clk <= 0; #5 clk <= 1;  //N
        #5 clk <= 0; force u_memory.addr = 17; force u_memory.in_data = 16'b_0000_0000_0000_0000; #5 clk <= 1; #5 clk <= 0; #5 clk <= 1;  //i
        #5 clk <= 0; force u_memory.addr = 18; force u_memory.in_data = 16'b_0000_0000_0000_0000; #5 clk <= 1; #5 clk <= 0; #5 clk <= 1;  //sum
        #5 clk <= 0; force u_memory.addr = 19; force u_memory.in_data = 16'b_0000_0000_0000_0010; #5 clk <= 1; #5 clk <= 0; #5 clk <= 1;  //S
        #5 clk <= 0; force u_memory.addr = 20; force u_memory.in_data = 16'b_0000_0000_0000_0001; #5 clk <= 1; #5 clk <= 0;               //v1
        mem_rst_n <= 1; release u_memory.memrq; release u_memory.addr; release u_memory.in_data;release u_memory.rw; 
        #5 clk <= ~clk; #5 clk <= ~clk; #5 clk <= ~clk; #5 clk <= ~clk; #5 rst_n <= 1; clk <= ~clk;
        
        forever
            #5 clk <= ~clk;
    end
    
endmodule