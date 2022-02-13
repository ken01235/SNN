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

module controller(
    clk,
    rst,
    syn_addr,
    rf_addr,
    spike,
    shift_en,
    sram_access,
    state,
    rf_setting,
    GS_code_0,
    GS_code_1
);

input clk;
input rst;
reg [`G_SZ : 0] GS_num_0;
reg [`G_SZ : 0] GS_num_1;
reg [`G_SZ + 1 : 0] GS_num_tot;
reg [`N_SZ - 1 : 0] cnt_1;
reg [`N_SZ - 1 : 0] cnt_1_tmp;
reg [`G_SZ - 1 : 0] cnt_2;
reg [`G_SZ - 1 : 0] cnt_2_tmp;
output reg [`N_SZ + `G_SZ - 1 : 0] syn_addr;
reg [`N_SZ + `G_SZ - 1 : 0] syn_addr_tmp;
input [`N_SZ - 1 : 0] rf_addr;
input [1 : 0] spike;
output reg shift_en;
reg shift_en_1;
reg shift_en_tmp;
output reg sram_access;
reg sram_access_tmp;
reg [`G_SZ + 1: 0] sram_access_cnt;
reg [`G_SZ + 1: 0] sram_access_cnt_tmp;
input [2 : 0] state;
reg [2 : 0] prev_state;
input [`N_NUM * `G_NUM - 1 : 0] rf_setting;
reg [`N_NUM * `G_NUM - 1 : 0] rf;          // 32 * 32 / 8 = 128 
reg [`N_NUM * `G_NUM - 1 : 0] rf_tmp;
output reg [`G_NUM - 1 : 0] GS_code_0;
output reg [`G_NUM - 1 : 0] GS_code_1;
reg [`G_SZ : 0] i;

always@(posedge clk)
begin
    if (~rst)
    begin
        cnt_1 <= 0;
        cnt_2 <= 0;
        syn_addr <= 0;
        shift_en_1 <= 0;
        sram_access <= 0;
        sram_access_cnt <= 0;
        prev_state <= 0;
        rf <= 0;
    end
    else
    begin
        cnt_1 <= cnt_1_tmp;
        cnt_2 <= cnt_2_tmp;
        syn_addr <= syn_addr_tmp;
        shift_en_1 <= shift_en_tmp;
        sram_access <= sram_access_tmp;
        sram_access_cnt <= sram_access_cnt_tmp;
        prev_state <= state;
        rf <= rf_tmp;
    end
end

// syn_addr_tmp
always@(*)
begin
    if (state == `SYN_ACCU)
    begin
        syn_addr_tmp = {cnt_1_tmp, cnt_2_tmp};
    end
    else
    begin
        syn_addr_tmp = 0;
    end
end

// GS_num_tot
always@(*)
begin
    case(spike)
        2'b00: GS_num_tot = 0;
        2'b01: GS_num_tot = GS_num_0;
        2'b10: GS_num_tot = GS_num_1;
        2'b11: GS_num_tot = GS_num_0 + GS_num_1;
        default: GS_num_tot = 0;
    endcase
end

// shift_en
always@(*)
begin
    shift_en = shift_en_1 || (GS_num_tot == 0);
end

// shift_en_tmp, sram_access_tmp, sram_access_cnt_tmp
always@(*)
begin
    if (state != `SYN_ACCU /*|| prev_state != `SYN_ACCU*/)
    begin
        shift_en_tmp = 0;
        sram_access_tmp = 0;
        sram_access_cnt_tmp = 0;
    end
    else if (GS_num_tot == 0)
    begin
        shift_en_tmp = !shift_en;
        sram_access_tmp = 0;
        sram_access_cnt_tmp = 0;
    end
    else if (sram_access_cnt + 1 == GS_num_tot)
    begin
        shift_en_tmp = 1;
        sram_access_tmp = 1;
        sram_access_cnt_tmp = sram_access_cnt + 1;
    end
    else if (sram_access_cnt == GS_num_tot)
    begin
        shift_en_tmp = 0;
        sram_access_tmp = 0;
        sram_access_cnt_tmp = 0;
    end
    else
    begin
        shift_en_tmp = 0;
        sram_access_tmp = 1;
        sram_access_cnt_tmp = sram_access_cnt + 1;
    end
end

// cnt_1_tmp, cnt_2_tmp
always@(*)
begin
    if (state != `SYN_ACCU || !sram_access_tmp)
    begin
        cnt_1_tmp = 0;
        cnt_2_tmp = 0;
    end
    else if (spike[0] && GS_num_0 && sram_access_cnt_tmp <= GS_num_0)
    begin
        cnt_1_tmp = rf_addr;
        cnt_2_tmp = sram_access ? cnt_2 + 1 : 0;
    end
    else if (spike[0] && GS_num_0 && sram_access_cnt_tmp == GS_num_0 + 1)
    begin
        cnt_1_tmp = rf_addr + 1;
        cnt_2_tmp = 0;
    end
    else if (sram_access_cnt_tmp <= GS_num_tot)
    begin
        cnt_1_tmp = rf_addr + 1;
        cnt_2_tmp = sram_access ? cnt_2 + 1 : 0;
    end
    else
    begin
        cnt_1_tmp = 0;
        cnt_2_tmp = 0;
    end
end

// rf_tmp
always@(*)
begin
    if (state == `SET)
    begin
        rf_tmp = rf_setting;
    end
    else
    begin
        rf_tmp = rf;
    end
end

// GS_code_0, GS_code_1
always@(*)
begin
    if (state == `SYN_ACCU && spike[0])
    begin
        for (i = 0; i < `G_NUM; i = i + 1)
        begin
            GS_code_0[i] = rf[rf_addr * `G_NUM + i];
        end
    end
    else
    begin
        GS_code_0 = 0;
    end
end

always@(*)
begin
    if (state == `SYN_ACCU && spike[1])
    begin
        for (i = 0; i < `G_NUM; i = i + 1)
        begin
            GS_code_1[i] = rf[rf_addr * `G_NUM + `G_NUM + i];
        end
    end
    else
    begin
        GS_code_1 = 0;
    end
end

// GS_num_0, GS_num_1
always@(*)
begin
    if (state == `SYN_ACCU)
    begin
        GS_num_0 = GS_code_0[0];
        GS_num_1 = GS_code_1[0];
        for(i = 1; i < `G_NUM; i = i + 1)
        begin
            GS_num_0 = GS_num_0 + GS_code_0[i];
            GS_num_1 = GS_num_1 + GS_code_1[i];
        end
    end
    else
    begin
        GS_num_0 = 0;
        GS_num_1 = 0;
    end
end

endmodule
