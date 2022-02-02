`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.01.2022 22:29:36
// Design Name: 
// Module Name: Mux
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
module mux
(
input selector,
input [15:0] group0,
input [15:0] group1,
output [15:0] group_out
);
    
reg [15:0] group_temp;    
    
assign group_out[15:0] = group_temp[15:0];  
  
always @(*) begin

    if(selector == 0) begin
        group_temp[15:0] <= group0[15:0];
    end
    else begin
        group_temp[15:0] <= group1[15:0];
    end

end    
    
endmodule
