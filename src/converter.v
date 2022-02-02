`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.01.2022 19:50:43
// Design Name: 
// Module Name: converter
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


module converter(

input [1:0] converter_input,
output reg [3:0] converter_output

    );
    
always @(*) begin

    case(converter_input)
        2'b00 : converter_output <= 4'b0001;
        2'b01 : converter_output <= 4'b0010;
        2'b10 : converter_output <= 4'b0100;
        default : converter_output <= 4'b1000;
    endcase

end   
    
endmodule
