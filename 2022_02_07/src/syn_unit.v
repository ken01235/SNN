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

module syn_unit(
    clk,
    rst,
    shift_en,
    weight,
    syn_en,
    cur_voltage
);

input clk;
input rst;
input shift_en;
input [3 : 0] weight;
input syn_en;
output reg [7 : 0] cur_voltage;
reg [7 : 0] cur_voltage_tmp;
reg [5 : 0] cnt;
reg [5 : 0] cnt_tmp;
reg syn_en_delayed;

always@(posedge clk)
begin
    if(~rst)
    begin
        cur_voltage_tmp <= 0;
        cur_voltage <= 0;
        syn_en_delayed <= 0;
    end
    else
    begin
        cur_voltage <= cur_voltage_tmp;
        syn_en_delayed <= syn_en;
    end
end

always@(*)
begin
    if (syn_en_delayed)
    begin
        cur_voltage_tmp = cur_voltage + weight;
    end
    else
    begin
        cur_voltage_tmp = cur_voltage;
    end
end

endmodule
