`timescale 1ns / 1ps

--module eight_bit_counter #
--(
--    parameter MAX_COUNT_VALUE = 255;
--)
--(
--	input wire clk,
--    // @todo: Add rst input
--    output wire [7:0] count_out,
--    output wire rollover
--);

--reg [7:0] count = 0;

--always @(posedge clk) begin

--    if(count == MAX_COUNT_VALUE) begin
--        count <= 0;
--        rollover <= 1;
--    end
--    else begin
--        count <= count + 1;
--        rollover <= 0;
--    end

--end 

--assign count_out = count;

--endmodule