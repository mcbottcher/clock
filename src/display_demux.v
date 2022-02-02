`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.01.2022 20:05:51
// Design Name: 
// Module Name: display_demux
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


module display_demux(

input [1:0] mode,

input [15:0] clock_module_bcd,
input [15:0] stop_watch_bcd,
input [15:0] set_alarm_bcd,

output reg [15:0] output_bcd
);

always @(*) begin

    case(mode)
        
        2'b00 : output_bcd <= clock_module_bcd;
        2'b01 : output_bcd <= stop_watch_bcd;
        2'b10 : output_bcd <= clock_module_bcd;
        default : output_bcd <= set_alarm_bcd;
        
    endcase

end

endmodule
