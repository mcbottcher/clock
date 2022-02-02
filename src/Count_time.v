`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.01.2022 19:00:48
// Design Name: 
// Module Name: count_time
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


module count_time(

input master_clock,

input set_time,
input increment_hours,
input increment_minutes,

output [5:0] raw_value_mins,
output [5:0] raw_value_hrs,

output [7:0] hours_bcd,
output [7:0] minutes_bcd,
output [7:0] seconds_bcd
    );

wire minutes_increment;
wire hours_increment;

wire seconds_ticker;
wire minutes_ticker;
wire hours_ticker;

wire [7:0] seconds_raw_value;
wire [7:0] minutes_raw_value;
wire [7:0] hours_raw_value;

assign raw_value_hrs = hours_raw_value[5:0];
assign raw_value_mins = minutes_raw_value[5:0];

// by default this is one second
// create one second period clock
divider u1(
.clk(master_clock),
.divided_clk(seconds_ticker)
);
    
eight_bit_counter #(.COUNT(59)) u2 (

.clk(seconds_ticker),
.reset_count(0),
.rollover(minutes_ticker),
.count_out(seconds_raw_value[7:0])
);

increment_selector u3(

.selector(set_time),
.in_0(increment_minutes),
.in_1(minutes_ticker),
.signal(minutes_increment)
);

eight_bit_counter #(.COUNT(59)) u4 (

.clk(minutes_increment),
.reset_count(0),
.count_out(minutes_raw_value[7:0]),
.rollover(hours_ticker)
);

increment_selector u5(

.selector(set_time),
.in_0(increment_hours),
.in_1(hours_ticker),
.signal(hours_increment)
);

eight_bit_counter #(.COUNT(23)) u6 (

.clk(hours_increment),
.reset_count(0),
.count_out(hours_raw_value)
);

bin_to_decimal u7(
.B(seconds_raw_value[7:0]),
.bcdout(seconds_bcd)
);

bin_to_decimal u8(
.B(minutes_raw_value[7:0]),
.bcdout(minutes_bcd)
);

bin_to_decimal u9(
.B(hours_raw_value[7:0]),
.bcdout(hours_bcd)
);
    
endmodule
