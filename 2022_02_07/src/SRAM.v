`define N_NUM 32
`define G_NUM 4
`define N_SZ 5
`define G_SZ 2
`define IDLE 3'b000
`define SET 3'b001
`define SYN_ACCU 3'b010
`define DECAY 3'b011
`define PDE 3'b100
`define FINISH 3'b101
`define DONE 3'b110

module SRAM(
    clk,
    rst,
    syn_addr,
    input_addr,
    DIN,
    wr_en,
    rd_en,
    DOUT,
    out_en
);

input clk;
input rst;
input [`N_SZ + `G_SZ - 1 : 0] syn_addr; // syn_addr = 0 ~ 32-1 + 0 ~ 32/8-1 = 5 + 2 = 7 bits
input [`N_SZ + `G_SZ - 1 : 0] input_addr; // syn_addr = 0 ~ 32-1 + 0 ~ 32/8-1 = 5 + 2 = 7 bits
reg [`N_SZ + `G_SZ - 1 : 0] input_addr2;
input [31 : 0] DIN;
input wr_en;
input rd_en;
output reg [31 : 0] DOUT;
output reg out_en;
reg [31 : 0] data [`N_NUM * `G_NUM - 1 : 0]; //store weight
reg [`N_SZ + `G_SZ : 0] i;

always@(posedge clk)
begin
    if (~rst)
    begin
        for(i = 0; i < `N_NUM * `G_NUM; i = i + 1)
        begin
            data[i] <= 0;
        end
    end
    else if (wr_en)
    begin
        data[input_addr2] <= DIN;
    end
    else
    begin
        for(i = 0; i < `N_NUM * `G_NUM; i = i + 1)
        begin
            data[i] <= data[i];
        end
    end
end

always@(*)
begin
    input_addr2 = {7'b1111111 - input_addr[6:2], input_addr[1:0]};
end

always@(negedge clk)
begin
    if(rd_en)
    begin
        out_en <= 1;
        DOUT <= data[syn_addr];
    end
    else
    begin
        out_en <= 0;
        DOUT <= 0;
    end
end
endmodule
