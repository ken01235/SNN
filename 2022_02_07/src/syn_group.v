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


module syn_group(
    clk,
    rst,
    syn_en,
    out_en,
    DOUT,
    weight_1,
    weight_2,
    weight_3,
    weight_4,
    weight_5,
    weight_6,
    weight_7,
    weight_8
);

input clk;
input rst;
input syn_en;
input out_en;
input [31 : 0] DOUT;
output reg [3 : 0] weight_1;
output reg [3 : 0] weight_2;
output reg [3 : 0] weight_3;
output reg [3 : 0] weight_4;
output reg [3 : 0] weight_5;
output reg [3 : 0] weight_6;
output reg [3 : 0] weight_7;
output reg [3 : 0] weight_8;
reg [3 : 0] weight_1_tmp;
reg [3 : 0] weight_2_tmp;
reg [3 : 0] weight_3_tmp;
reg [3 : 0] weight_4_tmp;
reg [3 : 0] weight_5_tmp;
reg [3 : 0] weight_6_tmp;
reg [3 : 0] weight_7_tmp;
reg [3 : 0] weight_8_tmp;

always@(posedge clk)
begin
    if (~rst | ~syn_en)
    begin
        weight_1 <= 0;
        weight_2 <= 0;
        weight_3 <= 0;
        weight_4 <= 0;
        weight_5 <= 0;
        weight_6 <= 0;
        weight_7 <= 0;
        weight_8 <= 0;
    end
    else
    begin
        weight_1 <= weight_1_tmp;
        weight_2 <= weight_2_tmp;
        weight_3 <= weight_3_tmp;
        weight_4 <= weight_4_tmp;
        weight_5 <= weight_5_tmp;
        weight_6 <= weight_6_tmp;
        weight_7 <= weight_7_tmp;
        weight_8 <= weight_8_tmp;
    end
end

always@(*)
begin
    begin
        weight_1_tmp = DOUT[31 : 28];
        weight_2_tmp = DOUT[27 : 24];
        weight_3_tmp = DOUT[23 : 20];
        weight_4_tmp = DOUT[19 : 16];
        weight_5_tmp = DOUT[15 : 12];
        weight_6_tmp = DOUT[11 : 8];
        weight_7_tmp = DOUT[7 : 4];
        weight_8_tmp = DOUT[3 : 0];
    end
end

endmodule
