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

module group_arrangement(
    clk,
    rst,
    state,
    sram_access,
    GS_code_0_input,
    GS_code_1_input,
    syn_en,
    shift_en,
    cnt,
    GS_code
);

input clk;
input rst;
input [2 : 0] state;
input sram_access;
input [`G_NUM - 1 : 0] GS_code_0_input;
input [`G_NUM - 1 : 0] GS_code_1_input;
reg [`G_NUM - 1 : 0] GS_code_0_tmp;
reg [`G_NUM - 1 : 0] GS_code_1_tmp;
output reg [`G_NUM * 2 - 1 : 0] GS_code;
reg [`G_SZ - 1 : 0] GS_num_0;
reg [`G_SZ - 1 : 0] GS_num_1;
reg [`G_SZ : 0] GS_num_tot;
reg [`G_SZ + 1 : 0] i;
output reg [`G_NUM * 2 - 1 : 0] syn_en;
reg [`G_NUM * 2 - 1 : 0] syn_en_tmp;
output reg [`G_SZ + 1 : 0] cnt;
reg [`G_SZ + 1 : 0] cnt_tmp;
input shift_en;

always@(posedge clk)
begin
    if (~rst)
    begin
        cnt <= 0;
        syn_en <= 0;
    end
    else
    begin
        cnt <= cnt_tmp;
        syn_en <= syn_en_tmp;
    end
end

always@(*)
begin
    GS_code = {GS_code_0_input, GS_code_1_input};
    GS_num_tot = GS_code[0];
    for (i = 1; i < `G_NUM * 2; i = i + 1)
    begin
        GS_num_tot = GS_num_tot + GS_code[i];
    end
end

always@(*)
begin
    if (shift_en)
    begin
        GS_code_0_tmp = GS_code_0_input;
        GS_code_1_tmp = GS_code_1_input;
    end
    else
    begin
        GS_code_0_tmp = GS_code[`G_NUM * 2 - 1 : `G_NUM];
        GS_code_1_tmp = GS_code[`G_NUM - 1 : 0];
    end
end

always@(*)
begin
    if (shift_en)
    begin
        cnt_tmp = 0;
    end
    else if (cnt == GS_num_tot)
    begin
        cnt_tmp = 0;
    end
    else
    begin
        cnt_tmp = cnt + 1;
    end
end

always@(*)
begin
    // if (state != `SYN_ACCU || GS_code == 8'b0)
    // begin
    //     syn_en_tmp = 8'b0;
    // end
    // else if ((syn_en_tmp == 8'b0 && GS_code != 8'b0) || syn_en == 0)
    // begin
    //     syn_en_tmp = 8'b10000000;
    //     while(syn_en_tmp != 8'b0 && (syn_en_tmp & GS_code) == 0)
    //     begin
    //         syn_en_tmp = syn_en_tmp >> 1;
    //     end
    // end
    // else
    // begin
    //     syn_en_tmp = syn_en >> 1;
    //     while(syn_en_tmp != 8'b0 && (syn_en_tmp & GS_code) == 0)
    //     begin
    //         syn_en_tmp = syn_en_tmp >> 1;
    //     end
    // end
    if (state != `SYN_ACCU || GS_code == 8'b0)
    begin
        syn_en_tmp = 8'b0;
    end
    else if ((syn_en_tmp == 8'b0 && GS_code != 8'b0) || syn_en == 0)
    begin
        syn_en_tmp = 8'b10000000;
        while(syn_en_tmp != 8'b0 && (syn_en_tmp & GS_code) == 0)
        begin
            syn_en_tmp = syn_en_tmp >> 1;
        end
    end
    else
    begin
        syn_en_tmp = syn_en >> 1;
        while(syn_en_tmp != 8'b0 && (syn_en_tmp & GS_code) == 0)
        begin
            syn_en_tmp = syn_en_tmp >> 1;
        end
    end
end


endmodule
