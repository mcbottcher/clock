`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.02.2022 20:34:45
// Design Name: 
// Module Name: debounce_button
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


module debounce_button(

input clk,
input debounce_in,

output debounce_out

    );

wire q_temp1;
wire q_temp2;
wire q_temp3;
wire q_temp3_bar;

wire slow_clk;

assign q_temp3_bar = ~q_temp3;
assign debounce_out = q_temp3_bar & q_temp2;

d_flipflop u1(
.clk(slow_clk),
.D(debounce_in),
.Q(q_temp1)
);

d_flipflop u2(
.clk(slow_clk),
.D(q_temp1),
.Q(q_temp2)
);

d_flipflop u3(
.clk(slow_clk),
.D(q_temp2),
.Q(q_temp3)
);

divider #(.COUNT(32'h17D784)) u4(
.clk(clk),
.divided_clk(slow_clk)
);

endmodule

module d_flipflop(

input clk,
input D,

output reg Q

);

always @(posedge clk)begin
    Q <= D;
end
 
endmodule
