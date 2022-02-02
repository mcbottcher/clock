`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Digilent Inc.
// Engineer: Varun Kondagunturi
// 
// Create Date:    17:08:26 06/12/2014 
// Design Name: 
// Module Name:    Abacus_Top_Module 
// Project Name: 
// Target Devices: 
// Tool versions: 
//
//
// Description: 
//This is the Top-Level Source file for the Abacus Project. 
//Slide switches provide two 8-bit binary inputs A and B. 
//Slide Switches [15 down to 8] is input A.
//Slide Switches [7 down to 0] is input B.
//Inputs from the Push Buttons ( btnU, btnD, btnR, btnL) will allow the user to select different arithmetic operations that will be computed on the inputs A and B.
//btnU: Subtraction/Difference. Result will Scroll
//When A>B, difference is positive. 
//When A<B, difference is negative. If the button is not held down but just pressed once, the result will scroll. To find out if the result is negative, press and hold onto the push button btnU. This will show the negative sign. 
//btnD: Multiplication/Product. Result will Scroll
//btnR: Quotient(Division Operation). Press and Hold the button to display result
//btnL: Remainder ( Division Operation). Press and Hold the button to display result
//Output is displayed on the 7 segment LED display. 
//
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
 module Basys3_Abacus_Top(

//CLK Input
	 input clk,
	 
// button input
    input btnC,
    input btnR,
    input btnU,

// mode input
    input [15:0] sw,

// Seven Segment Display Outputs
     output [6:0] seg,
     output dp,
     output [3:0] an,
     
     output [15:0] led
 );

wire[15:0] seven_seg_input;
wire[15:0] clock_module_mux_output;

wire[15:0] joiner;

wire [7:0] hours_bcd;
wire [7:0] minutes_bcd;
wire [7:0] seconds_bcd;

wire [7:0] stopwatch_ms_bcd;
wire [7:0] stopwatch_s_bcd;

wire clock_mode;
wire stop_watch_mode;
wire set_time_mode;
wire set_alarm_mode;

wire set_time_inc_mins;
wire set_time_inc_hours;

wire [5:0] raw_value_mins;
wire [5:0] raw_value_hrs;

wire btnC_debounced;
wire btnU_debounced;
wire btnR_debounced;

debounce_button u_btnc(
.clk(clk),
.debounce_in(btnC),

.debounce_out(btnC_debounced)
);

debounce_button u_btnu(
.clk(clk),
.debounce_in(btnU),

.debounce_out(btnU_debounced)
);

debounce_button u_btnR(
.clk(clk),
.debounce_in(btnR),

.debounce_out(btnR_debounced)
);

converter u_mode(
.converter_input({sw[1],sw[0]}),
.converter_output({set_alarm_mode, set_time_mode, stop_watch_mode, clock_mode})
);

alarm u_alarm(

.alarm_mins(sw[9:4]),
.alarm_hours(sw[15:0]),

.mins_value(raw_value_mins),
.hours_value(raw_value_hrs),

.flash(led)
);

count_time u1(

.master_clock(clk),

.set_time(set_time_mode),
.increment_hours(set_time_inc_hours),
.increment_minutes(set_time_inc_mins),

.raw_value_mins(raw_value_mins),
.raw_value_hrs(raw_value_hrs),

.hours_bcd(hours_bcd),
.minutes_bcd(minutes_bcd),
.seconds_bcd(seconds_bcd)
);

mux u2(

.selector(btnC),
.group0({hours_bcd[7:0], minutes_bcd[7:0]}),
.group1(seconds_bcd[7:0]),
.group_out(clock_module_mux_output[15:0])
);

stopwatch u3
(
.master_clock(clk),
.enable(stop_watch_mode),
.trigger(btnC_debounced),
.reset(btnR_debounced),

.seconds_bcd(stopwatch_s_bcd),
.milliseconds_bcd(stopwatch_ms_bcd)
);

set_time u_set_time(

.master_clk(clk),

.change_selection(btnR_debounced),
.increment_selection(btnU_debounced),

.set_minutes(set_time_inc_mins),
.set_hours(set_time_inc_hours)
    );

display_demux u_display_demux(

.mode({sw[1],sw[0]}),

.clock_module_bcd(clock_module_mux_output),
.stop_watch_bcd({stopwatch_s_bcd, stopwatch_ms_bcd}),
.set_alarm_bcd(0),

.output_bcd(seven_seg_input)
);

// 7segment display module
seg7decimal u5 (

.x(seven_seg_input[15:0]),
.clk(clk),
.clr('b0),
.a_to_g(seg),
.an(an),
.dp(dp)
);

endmodule