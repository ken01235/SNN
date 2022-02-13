`define V_TH 8
`define PARAM 3
`define I_IN 9

module  I_QIF(
    clk,rst,
    Vpde_thres,
    Vthres, 
    Vrest, 
    a,b, 
    neu_in, 
    Vreset,
    membrane, 
    spike_out
);

input clk;
input rst;
input [`V_TH-1:0]Vpde_thres;
input [`V_TH-1:0]Vthres;
input [`V_TH-1:0]Vrest;
input [`PARAM-1:0]a;
input [`PARAM-1:0]b;
input [`I_IN-1:0]neu_in; 
input [`V_TH-1:0]Vreset;

output reg  [`V_TH-1:0]membrane;
output reg  spike_out;

reg  [`V_TH-1:0]membrane_temp;
reg  detect_bit;
reg  [`V_TH-1:0]membrane_sol; // adder result
 

always@(*) //Conditional Calculation & Compare
begin
    if (membrane <= Vpde_thres)
    begin
        membrane_temp = neu_in + a * (Vrest - membrane);
        {detect_bit, membrane_sol} = membrane + membrane_temp;
    end
    else
    begin 
        membrane_temp = neu_in + b * (membrane - Vthres);
        {detect_bit, membrane_sol} = membrane + membrane_temp;  //Membrane MAC 
    end 	
end

always@(posedge clk)   // Spike Generation 
begin
    if (~rst)
        spike_out <= 0; 
    else if (detect_bit == 1)  // Overflow 
        spike_out = detect_bit;
    else 
        spike_out = detect_bit;
end

always@(posedge clk)   //Membrane Update 
begin
    if(~rst)
        membrane <= Vreset;
    else if (detect_bit == 0)  
        membrane <= membrane_sol;
    else
        membrane <= Vreset;
end

endmodule
