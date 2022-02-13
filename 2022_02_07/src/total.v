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

module total(
    clk,
    rst,
    state,
    spike_stream_in,
    rf_setting,
    input_addr,
    DIN,
    wr_en,
    cur_voltage_1,
    cur_voltage_2,
    cur_voltage_3,
    cur_voltage_4,
    cur_voltage_5,
    cur_voltage_6,
    cur_voltage_7,
    cur_voltage_8,
    cur_voltage_9,
    cur_voltage_10,
    cur_voltage_11,
    cur_voltage_12,
    cur_voltage_13,
    cur_voltage_14,
    cur_voltage_15,
    cur_voltage_16,
    cur_voltage_17,
    cur_voltage_18,
    cur_voltage_19,
    cur_voltage_20,
    cur_voltage_21,
    cur_voltage_22,
    cur_voltage_23,
    cur_voltage_24,
    cur_voltage_25,
    cur_voltage_26,
    cur_voltage_27,
    cur_voltage_28,
    cur_voltage_29,
    cur_voltage_30,
    cur_voltage_31,
    cur_voltage_32,
    weight_1,
    weight_2,
    weight_3,
    weight_4,
    weight_5,
    weight_6,
    weight_7,
    weight_8,
    weight_9,
    weight_10,
    weight_11,
    weight_12,
    weight_13,
    weight_14,
    weight_15,
    weight_16,
    weight_17,
    weight_18,
    weight_19,
    weight_20,
    weight_21,
    weight_22,
    weight_23,
    weight_24,
    weight_25,
    weight_26,
    weight_27,
    weight_28,
    weight_29,
    weight_30,
    weight_31,
    weight_32,
    out_en,
    syn_en,
    GS_code_0,
    GS_code_1,
    shift_en,
    syn_addr,
    DOUT,
    sram_access,
    cnt,
    GS_code,
    spike
);

input clk;
input rst;
output [`N_SZ + `G_SZ - 1 : 0] syn_addr;
wire [`N_SZ - 1 : 0] rf_addr;
output [1 : 0] spike;
output shift_en;
output sram_access;
input [2 : 0] state;
input [`N_NUM - 1 : 0] spike_stream_in;
wire accu_fin;
input [`N_NUM * `G_NUM - 1 : 0] rf_setting;
output [`G_NUM - 1 : 0] GS_code_0;
output [`G_NUM - 1 : 0] GS_code_1;

input [`N_SZ + `G_SZ - 1 : 0] input_addr;
input [31 : 0] DIN;
input wr_en;
wire rd_en;
output [31 : 0] DOUT;
output out_en;

output [`G_NUM * 2 - 1 : 0] syn_en;

output [3 : 0] weight_1;
output [3 : 0] weight_2;
output [3 : 0] weight_3;
output [3 : 0] weight_4;
output [3 : 0] weight_5;
output [3 : 0] weight_6;
output [3 : 0] weight_7;
output [3 : 0] weight_8;
output [3 : 0] weight_9;
output [3 : 0] weight_10;
output [3 : 0] weight_11;
output [3 : 0] weight_12;
output [3 : 0] weight_13;
output [3 : 0] weight_14;
output [3 : 0] weight_15;
output [3 : 0] weight_16;
output [3 : 0] weight_17;
output [3 : 0] weight_18;
output [3 : 0] weight_19;
output [3 : 0] weight_20;
output [3 : 0] weight_21;
output [3 : 0] weight_22;
output [3 : 0] weight_23;
output [3 : 0] weight_24;
output [3 : 0] weight_25;
output [3 : 0] weight_26;
output [3 : 0] weight_27;
output [3 : 0] weight_28;
output [3 : 0] weight_29;
output [3 : 0] weight_30;
output [3 : 0] weight_31;
output [3 : 0] weight_32;

output [7 : 0] cur_voltage_1;
output [7 : 0] cur_voltage_2;
output [7 : 0] cur_voltage_3;
output [7 : 0] cur_voltage_4;
output [7 : 0] cur_voltage_5;
output [7 : 0] cur_voltage_6;
output [7 : 0] cur_voltage_7;
output [7 : 0] cur_voltage_8;
output [7 : 0] cur_voltage_9;
output [7 : 0] cur_voltage_10;
output [7 : 0] cur_voltage_11;
output [7 : 0] cur_voltage_12;
output [7 : 0] cur_voltage_13;
output [7 : 0] cur_voltage_14;
output [7 : 0] cur_voltage_15;
output [7 : 0] cur_voltage_16;
output [7 : 0] cur_voltage_17;
output [7 : 0] cur_voltage_18;
output [7 : 0] cur_voltage_19;
output [7 : 0] cur_voltage_20;
output [7 : 0] cur_voltage_21;
output [7 : 0] cur_voltage_22;
output [7 : 0] cur_voltage_23;
output [7 : 0] cur_voltage_24;
output [7 : 0] cur_voltage_25;
output [7 : 0] cur_voltage_26;
output [7 : 0] cur_voltage_27;
output [7 : 0] cur_voltage_28;
output [7 : 0] cur_voltage_29;
output [7 : 0] cur_voltage_30;
output [7 : 0] cur_voltage_31;
output [7 : 0] cur_voltage_32;
output [`G_SZ + 1 : 0] cnt;
output [`G_NUM * 2 - 1 : 0] GS_code;

controller U0(
    .clk(clk),
    .rst(rst),
    .syn_addr(syn_addr),
    .rf_addr(rf_addr),
    .spike(spike),
    .shift_en(shift_en),
    .sram_access(sram_access),
    .state(state),
    .rf_setting(rf_setting),
    .GS_code_0(GS_code_0),
    .GS_code_1(GS_code_1)
);

decoder U1(
    .clk(clk),
    .rst(rst),
    .spike_stream_in(spike_stream_in),
    .rf_addr(rf_addr),
    .spike(spike),
    .shift_en(shift_en),
    .state(state),
    .accu_fin(accu_fin)
);

SRAM U2(
    .clk(clk),
    .rst(rst),
    .syn_addr(syn_addr),
    .input_addr(input_addr),
    .DIN(DIN),
    .wr_en(wr_en),
    .rd_en(sram_access),
    .DOUT(DOUT),
    .out_en(out_en)
);

group_arrangement U3(
    .clk(clk),
    .rst(rst),
    .state(state),
    .sram_access(sram_access),
    .GS_code_0_input(GS_code_0),
    .GS_code_1_input(GS_code_1),
    .syn_en(syn_en),
    .shift_en(shift_en),
    .cnt(cnt),
    .GS_code(GS_code)
);

syn_group U4(
    .clk(clk),
    .rst(rst),
    .syn_en(syn_en[3] | syn_en[7]),
    .out_en(out_en),
    .DOUT(DOUT),
    .weight_1(weight_1),
    .weight_2(weight_2),
    .weight_3(weight_3),
    .weight_4(weight_4),
    .weight_5(weight_5),
    .weight_6(weight_6),
    .weight_7(weight_7),
    .weight_8(weight_8)
);

syn_group U5(
    .clk(clk),
    .rst(rst),
    .syn_en(syn_en[2] | syn_en[6]),
    .out_en(out_en),
    .DOUT(DOUT),
    .weight_1(weight_9),
    .weight_2(weight_10),
    .weight_3(weight_11),
    .weight_4(weight_12),
    .weight_5(weight_13),
    .weight_6(weight_14),
    .weight_7(weight_15),
    .weight_8(weight_16)
);

syn_group U6(
    .clk(clk),
    .rst(rst),
    .syn_en(syn_en[1] | syn_en[5]),
    .out_en(out_en),
    .DOUT(DOUT),
    .weight_1(weight_17),
    .weight_2(weight_18),
    .weight_3(weight_19),
    .weight_4(weight_20),
    .weight_5(weight_21),
    .weight_6(weight_22),
    .weight_7(weight_23),
    .weight_8(weight_24)
);

syn_group U7(
    .clk(clk),
    .rst(rst),
    .syn_en(syn_en[0] | syn_en[4]),
    .out_en(out_en),
    .DOUT(DOUT),
    .weight_1(weight_25),
    .weight_2(weight_26),
    .weight_3(weight_27),
    .weight_4(weight_28),
    .weight_5(weight_29),
    .weight_6(weight_30),
    .weight_7(weight_31),
    .weight_8(weight_32)
);

syn_unit U8(.clk(clk), .rst(rst), .shift_en(shift_en), .weight(weight_1), .syn_en(syn_en[3] | syn_en[7]), .cur_voltage(cur_voltage_1));
syn_unit U9(.clk(clk), .rst(rst), .shift_en(shift_en), .weight(weight_2), .syn_en(syn_en[3] | syn_en[7]), .cur_voltage(cur_voltage_2));
syn_unit U10(.clk(clk), .rst(rst), .shift_en(shift_en), .weight(weight_3), .syn_en(syn_en[3] | syn_en[7]), .cur_voltage(cur_voltage_3));
syn_unit U11(.clk(clk), .rst(rst), .shift_en(shift_en), .weight(weight_4), .syn_en(syn_en[3] | syn_en[7]), .cur_voltage(cur_voltage_4));
syn_unit U12(.clk(clk), .rst(rst), .shift_en(shift_en), .weight(weight_5), .syn_en(syn_en[3] | syn_en[7]), .cur_voltage(cur_voltage_5));
syn_unit U13(.clk(clk), .rst(rst), .shift_en(shift_en), .weight(weight_6), .syn_en(syn_en[3] | syn_en[7]), .cur_voltage(cur_voltage_6));
syn_unit U14(.clk(clk), .rst(rst), .shift_en(shift_en), .weight(weight_7), .syn_en(syn_en[3] | syn_en[7]), .cur_voltage(cur_voltage_7));
syn_unit U15(.clk(clk), .rst(rst), .shift_en(shift_en), .weight(weight_8), .syn_en(syn_en[3] | syn_en[7]), .cur_voltage(cur_voltage_8));
syn_unit U16(.clk(clk), .rst(rst), .shift_en(shift_en), .weight(weight_9), .syn_en(syn_en[2] | syn_en[6]), .cur_voltage(cur_voltage_9));
syn_unit U17(.clk(clk), .rst(rst), .shift_en(shift_en), .weight(weight_10), .syn_en(syn_en[2] | syn_en[6]), .cur_voltage(cur_voltage_10));
syn_unit U18(.clk(clk), .rst(rst), .shift_en(shift_en), .weight(weight_11), .syn_en(syn_en[2] | syn_en[6]), .cur_voltage(cur_voltage_11));
syn_unit U19(.clk(clk), .rst(rst), .shift_en(shift_en), .weight(weight_12), .syn_en(syn_en[2] | syn_en[6]), .cur_voltage(cur_voltage_12));
syn_unit U20(.clk(clk), .rst(rst), .shift_en(shift_en), .weight(weight_13), .syn_en(syn_en[2] | syn_en[6]), .cur_voltage(cur_voltage_13));
syn_unit U21(.clk(clk), .rst(rst), .shift_en(shift_en), .weight(weight_14), .syn_en(syn_en[2] | syn_en[6]), .cur_voltage(cur_voltage_14));
syn_unit U22(.clk(clk), .rst(rst), .shift_en(shift_en), .weight(weight_15), .syn_en(syn_en[2] | syn_en[6]), .cur_voltage(cur_voltage_15));
syn_unit U23(.clk(clk), .rst(rst), .shift_en(shift_en), .weight(weight_16), .syn_en(syn_en[2] | syn_en[6]), .cur_voltage(cur_voltage_16));
syn_unit U24(.clk(clk), .rst(rst), .shift_en(shift_en), .weight(weight_17), .syn_en(syn_en[1] | syn_en[5]), .cur_voltage(cur_voltage_17));
syn_unit U25(.clk(clk), .rst(rst), .shift_en(shift_en), .weight(weight_18), .syn_en(syn_en[1] | syn_en[5]), .cur_voltage(cur_voltage_18));
syn_unit U26(.clk(clk), .rst(rst), .shift_en(shift_en), .weight(weight_19), .syn_en(syn_en[1] | syn_en[5]), .cur_voltage(cur_voltage_19));
syn_unit U27(.clk(clk), .rst(rst), .shift_en(shift_en), .weight(weight_20), .syn_en(syn_en[1] | syn_en[5]), .cur_voltage(cur_voltage_20));
syn_unit U28(.clk(clk), .rst(rst), .shift_en(shift_en), .weight(weight_21), .syn_en(syn_en[1] | syn_en[5]), .cur_voltage(cur_voltage_21));
syn_unit U29(.clk(clk), .rst(rst), .shift_en(shift_en), .weight(weight_22), .syn_en(syn_en[1] | syn_en[5]), .cur_voltage(cur_voltage_22));
syn_unit U30(.clk(clk), .rst(rst), .shift_en(shift_en), .weight(weight_23), .syn_en(syn_en[1] | syn_en[5]), .cur_voltage(cur_voltage_23));
syn_unit U31(.clk(clk), .rst(rst), .shift_en(shift_en), .weight(weight_24), .syn_en(syn_en[1] | syn_en[5]), .cur_voltage(cur_voltage_24));
syn_unit U32(.clk(clk), .rst(rst), .shift_en(shift_en), .weight(weight_25), .syn_en(syn_en[0] | syn_en[4]), .cur_voltage(cur_voltage_25));
syn_unit U33(.clk(clk), .rst(rst), .shift_en(shift_en), .weight(weight_26), .syn_en(syn_en[0] | syn_en[4]), .cur_voltage(cur_voltage_26));
syn_unit U34(.clk(clk), .rst(rst), .shift_en(shift_en), .weight(weight_27), .syn_en(syn_en[0] | syn_en[4]), .cur_voltage(cur_voltage_27));
syn_unit U35(.clk(clk), .rst(rst), .shift_en(shift_en), .weight(weight_28), .syn_en(syn_en[0] | syn_en[4]), .cur_voltage(cur_voltage_28));
syn_unit U36(.clk(clk), .rst(rst), .shift_en(shift_en), .weight(weight_29), .syn_en(syn_en[0] | syn_en[4]), .cur_voltage(cur_voltage_29));
syn_unit U37(.clk(clk), .rst(rst), .shift_en(shift_en), .weight(weight_30), .syn_en(syn_en[0] | syn_en[4]), .cur_voltage(cur_voltage_30));
syn_unit U38(.clk(clk), .rst(rst), .shift_en(shift_en), .weight(weight_31), .syn_en(syn_en[0] | syn_en[4]), .cur_voltage(cur_voltage_31));
syn_unit U39(.clk(clk), .rst(rst), .shift_en(shift_en), .weight(weight_32), .syn_en(syn_en[0] | syn_en[4]), .cur_voltage(cur_voltage_32));

endmodule

