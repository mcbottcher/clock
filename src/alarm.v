`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.01.2022 20:33:10
// Design Name: 
// Module Name: alarm
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


module alarm(

input [5:0] alarm_mins,
input [5:0] alarm_hours,

input [5:0] mins_value,
input [5:0] hours_value,

output reg [15:0] flash
    );
    
always @(*) begin

    if((mins_value == alarm_mins) && (hours_value == alarm_hours)) begin
        flash <= 16'b1111111111111111;
    end else begin
        flash <= 0;
    end

end    
    
endmodule
