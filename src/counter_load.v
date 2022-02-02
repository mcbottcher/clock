`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.01.2022 20:52:39
// Design Name: 
// Module Name: counter_load
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


module counter_load(

input wire clk,
input wire a_clr,

output wire [7:0] count_out
    );
    
reg [7:0] int_count = 0;

always @(posedge clk or posedge a_clr)
    begin
        if(a_clr) begin
            int_count <= 0;
        end else begin
            int_count <= int_count + 1;
        end
    end

assign count_out = int_count;

endmodule
