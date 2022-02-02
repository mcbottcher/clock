`timescale 1ns / 1ps

module eight_bit_counter
#(parameter COUNT = 5)
(
    input wire clk,
    input wire reset_count,
    
    output wire rollover,
    output wire [7:0] count_out
);

reg int_rollover = 0;
reg [7:0] int_count = 0;

always @(posedge clk or posedge reset_count) begin
    
    if(reset_count) begin
        int_count <= 0;
        int_rollover <= 0;
    end else if(int_count == COUNT) begin
        int_count <= 0;
        int_rollover <= 1;
    end else begin
        int_count <= int_count + 1;
        int_rollover <= 0;
    end 

end

assign rollover = int_rollover;
assign count_out = int_count;

endmodule