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

module input_buffer(
    clk,
    rst,
    ext_in,
    DIN,
    input_addr, // input addr of SRAM
    addr,       // input of the buffer
    wr_en
);

input clk;
input rst;
input [15 : 0] ext_in;
output reg [31 : 0] DIN;
reg [31 : 0] DIN_tmp;
output reg wr_en;
reg wr_en_tmp;
output reg [`N_SZ + `G_SZ - 1 : 0] input_addr;
reg [`N_SZ + `G_SZ - 1 : 0] input_addr_tmp;
input [`N_SZ + `G_SZ - 1 : 0] addr;
reg i;

always@(posedge clk)
begin
    if (~rst)
    begin
        DIN <= 0;
        wr_en <= 0;
    end
    else
    begin
        DIN <= DIN_tmp;
        wr_en <= wr_en_tmp;
    end
end

always@(*)
begin

end

endmodule

