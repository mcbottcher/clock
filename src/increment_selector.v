`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.01.2022 19:35:09
// Design Name: 
// Module Name: increment_selector
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module increment_selector(

input selector,

input in_0,
input in_1,

output signal
    );

reg signal_temp;

always @(*) begin

    if(selector) begin
        signal_temp <= in_0;
    end else begin
        signal_temp <= in_1;
    end

end
    
assign signal = signal_temp;
    
endmodule

