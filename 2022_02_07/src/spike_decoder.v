`define IDLE 3'b000
`define SET 3'b001
`define SYN_ACCU 3'b010
`define DECAY 3'b011
`define PDE 3'b100
`define FINISH 3'b101
`define DONE 3'b110

`define N_NUM 32
`define G_NUM 4
`define N_SZ 5
`define G_SZ 2

module decoder(
    clk,
    rst,
    spike_stream_in,
    rf_addr,
    spike,
    shift_en,
    state,
    accu_fin
);

input clk;
input rst;
input [`N_NUM - 1 : 0] spike_stream_in;
output reg [`N_SZ - 1 : 0] rf_addr;
reg [`N_SZ - 1 : 0] rf_addr_tmp;
output reg [1 : 0] spike;
reg [`N_NUM - 1 : 0] shift_reg;
reg [`N_NUM - 1 : 0] shift_reg_tmp;
input shift_en;
input [2 : 0] state;
reg [5 : 0] state_prev;
output reg accu_fin;
reg accu_fin_tmp;
reg [`N_NUM - 2 : 0] fin_cnt;
reg [`N_NUM - 2 : 0] fin_cnt_tmp;

always@(posedge clk)
begin
    if (~rst)
    begin
        spike <= 0;
        rf_addr <= 0;
        shift_reg <= 0;
        state_prev <= 0;
        accu_fin <= 0;
        fin_cnt <= 0;
    end
    else
    begin
        spike <= shift_reg_tmp[1 : 0];
        rf_addr <= rf_addr_tmp;
        shift_reg <= shift_reg_tmp;
        state_prev <= {state_prev[2 : 0], state};
        accu_fin <= accu_fin_tmp;
        fin_cnt <= fin_cnt_tmp;
    end
end

always@(*)
begin
    if (state == `SYN_ACCU)
    begin
        if (state_prev[5 : 3] != `SYN_ACCU)
        begin
            shift_reg_tmp = spike_stream_in;
            rf_addr_tmp = 0;
        end
        else if (shift_en)
        begin
            shift_reg_tmp = shift_reg >> 2;
            rf_addr_tmp = rf_addr + 2;
        end
        else
        begin
            shift_reg_tmp = shift_reg;
            rf_addr_tmp = rf_addr;
        end
    end
    else
    begin
        shift_reg_tmp = 0;
        rf_addr_tmp = 0;
    end
end

always@(*)
begin
    if (state != `SYN_ACCU)
    begin
        fin_cnt_tmp = 0;
        accu_fin_tmp = 0;
    end
    else if (shift_en && fin_cnt == 4'b1111)
    begin
        fin_cnt_tmp = 0;
        accu_fin_tmp = 1;
    end
    else if (shift_en)
    begin
        fin_cnt_tmp = fin_cnt + 1;
        accu_fin_tmp = 0;
    end
    else
    begin
        accu_fin_tmp = 0;
        fin_cnt_tmp = fin_cnt;
    end
end

endmodule

