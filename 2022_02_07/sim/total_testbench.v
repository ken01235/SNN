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

module total_testbench();

reg clk;
reg rst;
reg [2 : 0] state;
reg [`N_NUM - 1 : 0] spike_stream_in;
reg [`N_NUM * `G_NUM - 1 : 0] rf_setting;
reg [`N_SZ + `G_SZ - 1 : 0] input_addr;
reg [31 : 0] DIN;
reg wr_en;
wire [7 : 0] cur_voltage_1;
wire [7 : 0] cur_voltage_2;
wire [7 : 0] cur_voltage_3;
wire [7 : 0] cur_voltage_4;
wire [7 : 0] cur_voltage_5;
wire [7 : 0] cur_voltage_6;
wire [7 : 0] cur_voltage_7;
wire [7 : 0] cur_voltage_8;
wire [7 : 0] cur_voltage_9;
wire [7 : 0] cur_voltage_10;
wire [7 : 0] cur_voltage_11;
wire [7 : 0] cur_voltage_12;
wire [7 : 0] cur_voltage_13;
wire [7 : 0] cur_voltage_14;
wire [7 : 0] cur_voltage_15;
wire [7 : 0] cur_voltage_16;
wire [7 : 0] cur_voltage_17;
wire [7 : 0] cur_voltage_18;
wire [7 : 0] cur_voltage_19;
wire [7 : 0] cur_voltage_20;
wire [7 : 0] cur_voltage_21;
wire [7 : 0] cur_voltage_22;
wire [7 : 0] cur_voltage_23;
wire [7 : 0] cur_voltage_24;
wire [7 : 0] cur_voltage_25;
wire [7 : 0] cur_voltage_26;
wire [7 : 0] cur_voltage_27;
wire [7 : 0] cur_voltage_28;
wire [7 : 0] cur_voltage_29;
wire [7 : 0] cur_voltage_30;
wire [7 : 0] cur_voltage_31;
wire [7 : 0] cur_voltage_32;
wire [3 : 0] weight_1;
wire [3 : 0] weight_2;
wire [3 : 0] weight_3;
wire [3 : 0] weight_4;
wire [3 : 0] weight_5;
wire [3 : 0] weight_6;
wire [3 : 0] weight_7;
wire [3 : 0] weight_8;
wire [3 : 0] weight_9;
wire [3 : 0] weight_10;
wire [3 : 0] weight_11;
wire [3 : 0] weight_12;
wire [3 : 0] weight_13;
wire [3 : 0] weight_14;
wire [3 : 0] weight_15;
wire [3 : 0] weight_16;
wire [3 : 0] weight_17;
wire [3 : 0] weight_18;
wire [3 : 0] weight_19;
wire [3 : 0] weight_20;
wire [3 : 0] weight_21;
wire [3 : 0] weight_22;
wire [3 : 0] weight_23;
wire [3 : 0] weight_24;
wire [3 : 0] weight_25;
wire [3 : 0] weight_26;
wire [3 : 0] weight_27;
wire [3 : 0] weight_28;
wire [3 : 0] weight_29;
wire [3 : 0] weight_30;
wire [3 : 0] weight_31;
wire [3 : 0] weight_32;
wire out_en;
wire [`G_NUM * 2 - 1 : 0] syn_en;
wire [`G_NUM - 1 : 0] GS_code_0;
wire [`G_NUM - 1 : 0] GS_code_1;
wire shift_en;
wire [`N_SZ + `G_SZ - 1 : 0] syn_addr;
wire [31 : 0] DOUT;
wire sram_access;
wire [`G_SZ + 1 : 0] cnt;
wire [`G_NUM * 2 - 1 : 0]GS_code;
wire [1:0] spike;

total U0(
    .clk(clk),
    .rst(rst),
    .state(state),
    .spike_stream_in(spike_stream_in),
    .rf_setting(rf_setting),
    .input_addr(input_addr),
    .DIN(DIN),
    .wr_en(wr_en),
    .cur_voltage_1(cur_voltage_1),
    .cur_voltage_2(cur_voltage_2),
    .cur_voltage_3(cur_voltage_3),
    .cur_voltage_4(cur_voltage_4),
    .cur_voltage_5(cur_voltage_5),
    .cur_voltage_6(cur_voltage_6),
    .cur_voltage_7(cur_voltage_7),
    .cur_voltage_8(cur_voltage_8),
    .cur_voltage_9(cur_voltage_9),
    .cur_voltage_10(cur_voltage_10),
    .cur_voltage_11(cur_voltage_11),
    .cur_voltage_12(cur_voltage_12),
    .cur_voltage_13(cur_voltage_13),
    .cur_voltage_14(cur_voltage_14),
    .cur_voltage_15(cur_voltage_15),
    .cur_voltage_16(cur_voltage_16),
    .cur_voltage_17(cur_voltage_17),
    .cur_voltage_18(cur_voltage_18),
    .cur_voltage_19(cur_voltage_19),
    .cur_voltage_20(cur_voltage_20),
    .cur_voltage_21(cur_voltage_21),
    .cur_voltage_22(cur_voltage_22),
    .cur_voltage_23(cur_voltage_23),
    .cur_voltage_24(cur_voltage_24),
    .cur_voltage_25(cur_voltage_25),
    .cur_voltage_26(cur_voltage_26),
    .cur_voltage_27(cur_voltage_27),
    .cur_voltage_28(cur_voltage_28),
    .cur_voltage_29(cur_voltage_29),
    .cur_voltage_30(cur_voltage_30),
    .cur_voltage_31(cur_voltage_31),
    .cur_voltage_32(cur_voltage_32),
    .weight_1(weight_1),
    .weight_2(weight_2),
    .weight_3(weight_3),
    .weight_4(weight_4),
    .weight_5(weight_5),
    .weight_6(weight_6),
    .weight_7(weight_7),
    .weight_8(weight_8),
    .weight_9(weight_9),
    .weight_10(weight_10),
    .weight_11(weight_11),
    .weight_12(weight_12),
    .weight_13(weight_13),
    .weight_14(weight_14),
    .weight_15(weight_15),
    .weight_16(weight_16),
    .weight_17(weight_17),
    .weight_18(weight_18),
    .weight_19(weight_19),
    .weight_20(weight_20),
    .weight_21(weight_21),
    .weight_22(weight_22),
    .weight_23(weight_23),
    .weight_24(weight_24),
    .weight_25(weight_25),
    .weight_26(weight_26),
    .weight_27(weight_27),
    .weight_28(weight_28),
    .weight_29(weight_29),
    .weight_30(weight_30),
    .weight_31(weight_31),
    .weight_32(weight_32),
    .out_en(out_en),
    .syn_en(syn_en),
    .GS_code_0(GS_code_0),
    .GS_code_1(GS_code_1),
    .shift_en(shift_en),
    .syn_addr(syn_addr),
    .DOUT(DOUT),
    .sram_access(sram_access),
    .cnt(cnt),
    .GS_code(GS_code),
    .spike(spike)
);

initial
begin
    $fsdbDumpfile("total.fsdb");
    $fsdbDumpvars;
end

initial
begin
    clk = 1'b0;
    repeat(1000) #5 clk = ~clk; 
end

initial
begin
    rst = 0;
    #15 rst = 1;
end

initial
begin
    // rf_setting = 128'b01101100110011110000101010001000001001010101011111111110011011001000011001000001010011001101111110110110000001111000100001011101;
    // spike_stream_in = 32'b00111000001100100111010111110001;
    //
    rf_setting = 128'b01000011011010101100100011101010001100010100000101010001000101111001101100011101100110001111111011111000100011010001101010001011;
    spike_stream_in = 32'b01100001110011100001101110010100;
    //
    // rf_setting = 128'b01101110111110011101101110010011000001101100010101000111000101000011101101001010000010000110101110100001101101010101100101110101;
    // spike_stream_in = 32'b01001011001010001000001000110110;
    //
    // rf_setting = 128'b10101111001111001110101010000001111100110000001001011011111111010000100010110000001011000100110010111000111100010000110110000001;
    // spike_stream_in = 32'b11110100111100100111100011110101;
    //
    // rf_setting = 128'b00110110011111011111110110101011001111011110011011100011110110010101001011101001001011011100100011001111110111111001000011010001;
    // spike_stream_in = 32'b01111110010010110010101111100101;

    state = `IDLE;
    wr_en = 0; input_addr = 0;
    #20 state = `SET; wr_en = 1'b1;
    
    #10 input_addr = 7'b0000000;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b0000001;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b0000010;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b0000011;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b0000100;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b0000101;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b0000110;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b0000111;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b0001000;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b0001001;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b0001010;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b0001011;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b0001100;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b0001101;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b0001110;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b0001111;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b0010000;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b0010001;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b0010010;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b0010011;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b0010100;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b0010101;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b0010110;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b0010111;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b0011000;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b0011001;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b0011010;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b0011011;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b0011100;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b0011101;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b0011110;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b0011111;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b0100000;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b0100001;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b0100010;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b0100011;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b0100100;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b0100101;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b0100110;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b0100111;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b0101000;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b0101001;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b0101010;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b0101011;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b0101100;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b0101101;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b0101110;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b0101111;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b0110000;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b0110001;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b0110010;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b0110011;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b0110100;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b0110101;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b0110110;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b0110111;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b0111000;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b0111001;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b0111010;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b0111011;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b0111100;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b0111101;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b0111110;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b0111111;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b1000000;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b1000001;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b1000010;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b1000011;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b1000100;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b1000101;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b1000110;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b1000111;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b1001000;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b1001001;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b1001010;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b1001011;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b1001100;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b1001101;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b1001110;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b1001111;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b1010000;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b1010001;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b1010010;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b1010011;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b1010100;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b1010101;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b1010110;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b1010111;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b1011000;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b1011001;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b1011010;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b1011011;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b1011100;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b1011101;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b1011110;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b1011111;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b1100000;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b1100001;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b1100010;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b1100011;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b1100100;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b1100101;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b1100110;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b1100111;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b1101000;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b1101001;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b1101010;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b1101011;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b1101100;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b1101101;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b1101110;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b1101111;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b1110000;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b1110001;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b1110010;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b1110011;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b1110100;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b1110101;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b1110110;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b1110111;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b1111000;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b1111001;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b1111010;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b1111011;
    DIN = 32'b00000000000000000000000000000000;
    #10 input_addr = 7'b1111100;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b1111101;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b1111110;
    DIN = 32'b00010010001101000101011001111000;
    #10 input_addr = 7'b1111111;
    DIN = 32'b00000000000000000000000000000000;

    #10 wr_en = 0; input_addr = 0; DIN = 0;
    #10 state = `SYN_ACCU;
    #1000 state = `DECAY;
end

endmodule

