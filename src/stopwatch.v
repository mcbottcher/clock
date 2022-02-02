`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.01.2022 22:13:11
// Design Name: 
// Module Name: stopwatch
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


module stopwatch(

input master_clock,
input enable,
input trigger,
input reset,

output [7:0] seconds_bcd,
output [7:0] milliseconds_bcd
    );

reg master_clock_mux;
reg trigger_enable;

reg previous_state = 0;

wire milliseconds_ticker;
wire seconds_ticker;

wire [7:0] milliseconds_raw_value;
wire [7:0] seconds_raw_value;

always @(posedge master_clock) begin

    if(trigger && !previous_state) begin
        trigger_enable <= ~trigger_enable;
        previous_state <= 1;
    end else if (!trigger && previous_state) begin
        trigger_enable <= trigger_enable;
        previous_state <= 0;
    end else begin
        trigger_enable <= trigger_enable;
        previous_state <= previous_state;
    end

end

always @(*) begin

    if(enable && trigger_enable) begin
        master_clock_mux <= master_clock;
    end
    else begin
        master_clock_mux <= 0;
    end

end

// this needs to be divided by 10, not ms atm
divider #(.COUNT(32'h7A120)) u1(

.clk(master_clock_mux),
.divided_clk(milliseconds_ticker)
);

eight_bit_counter #(.COUNT(99)) u2 (

.clk(milliseconds_ticker),
.reset_count(reset),
.count_out(milliseconds_raw_value[7:0]),
.rollover(seconds_ticker)
);

eight_bit_counter #(.COUNT(99)) u3 (

.clk(seconds_ticker),
.reset_count(reset),
.count_out(seconds_raw_value[7:0])
);

bin_to_decimal u4(
.B(milliseconds_raw_value[7:0]),
.bcdout(milliseconds_bcd)
);

bin_to_decimal u5(
.B(seconds_raw_value[7:0]),
.bcdout(seconds_bcd)
);
endmodule
