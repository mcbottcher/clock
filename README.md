# Clock
A digital alarm clock based on my Casio Watch -- Small project to learn some HDL

---

Alarm clock written using Verilog targeted at the Basys3 FPGA development board

Clock uses 3 modes:
1. Regular Clock Mode
2. Set time Mode
3. Stop-Watch Mode

Modes are controlled by position of Switches [1:0]

### Regular Clock Mode
Does what it says on the tin. Basys3 has only 4 7-segment displays, so hours and minutes are shown as standard, and by pressing the centre button user can display the seconds count

### Set Time Mode
Only the hours and minutes are set with the Set Time Mode. The seconds counter will keep counting, but will not increment the minutes value when it reaches 60 seconds. To set the time press the Up Button to increment either hours or minutes. Using the Right Button the user can switch between incrementing the hours or incrementing the minutes

### Stop-Watch Mode
In Stop-Watch mode, the regular clock maintains counting the time. However, displayed on the 7-seg display is a stop-watch counter which counts seconds and hundreths of seconds. To start and stop the stop-watch press the Centre Button and to reset the stop-watch press the Right Button

### Alarm Mode
This could be updated, but in it current form the alarm is simply a comparator between the hours and minutes output from the regular clock and an alarm time specified by the on board switches. Switches [15:10] give the alarm hours and switches [9:4] give the alarm minutes. A trigger of the alarm just lights the LEDs, since I don't actually want to be woken up.
