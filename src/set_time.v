`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.01.2022 20:16:08
// Design Name: 
// Module Name: set_time
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


module set_time(

input master_clk,

input change_selection,
input increment_selection,

output reg set_minutes,
output reg set_hours

    );
   
reg previous_change_selection_state = 0;
reg previous_increment_selection_state = 0;

reg mode = 0;

always @(posedge master_clk) begin

    if(change_selection && !previous_change_selection_state) begin
        mode <= ~mode;
        previous_change_selection_state <= 1;
    end else if (!change_selection && previous_change_selection_state) begin
        mode <= mode;
        previous_change_selection_state <= 0;
    end else begin
        mode <= mode;
        previous_change_selection_state <= previous_change_selection_state;
    end

end

always @(posedge master_clk) begin

    if(increment_selection && (!previous_increment_selection_state)) begin
        if(mode) begin
             set_minutes <= 1;
             set_hours <= 0;         
        end else begin
             set_minutes <= 0;
             set_hours <= 1;   
        end
        previous_increment_selection_state <= 1;
    end else if(!increment_selection && previous_increment_selection_state) begin
        set_minutes <= 0;
        set_hours <= 0; 
        previous_increment_selection_state <= 0;
    end else begin
        set_minutes <= 0;
        set_hours <= 0; 
        previous_increment_selection_state <= previous_increment_selection_state;
    end    

end    

endmodule
