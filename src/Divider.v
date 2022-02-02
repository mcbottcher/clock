`timescale 1ns / 1ps

module divider
#(parameter COUNT = 32'h2FAF080)
(
	input clk,
    output divided_clk
    );

reg [31:0] count;
reg div_temp;

always @(posedge clk) begin

    count <= count + 1;
	if(count == COUNT)
	begin
	   count <= 0;
	   div_temp <= ~div_temp;
	end
	
end 

assign divided_clk = div_temp;

endmodule
  