`timescale 1ns / 1ps

module FlipFlop(
    clk, reset,
    d,
    q
    );
    
    //Defining input and output signals
    input clk, reset;
    input [7:0] d;
    output reg[7:0] q; //reg for holding value
    
    //Defining full adder modules' behavior
    always @(posedge clk) // posedge positive edge
    begin
    if(reset==1'b1)
        q<=8'b00000000; //parallel execute (<=)
    else
        q<=d;
    end
endmodule

