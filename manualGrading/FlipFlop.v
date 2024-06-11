`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2024 01:34:36 PM
// Design Name: 
// Module Name: FlipFlop
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

//Module definition
module FlipFlop(clk, reset, d, q);

//Define input and output signals
    input wire [7:0] d; //data value to be stored
    input wire clk; //indicates when to read and store value of d input on rising edge
    input wire reset; //signal to reset the output to initialized value of 0 on next rising edge (synchronous reset)
    output reg [7:0] q; //stored value of the internal state
    
//Define the D Flip flop module's behavior

    always @(posedge clk) //run if clk is at the rising positive edge
    begin
    if (reset == 1'b1)
        q <= 8'b0;  //reset has been enabled, it will reset the output to 0 on rising edge
     else 
        q <= d;  //stores the value of d on rising edge
    end
      
endmodule //FlipFlop
