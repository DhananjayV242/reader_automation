`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/01/2021 10:55:56 AM
// Design Name: 
// Module Name: InstMem_tb
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


module InstMem_tb();
    
reg [7:0] addr_tb;
wire [31:0] instruction_tb;

integer grade = 0;

InstMem instant
(
    .addr(addr_tb),
    .instruction(instruction_tb)
);

initial begin
    $display("\nTest1 (10 points): check if we can read from memory");
    addr_tb = 8'b00000000;
    #20;
    if (instruction_tb==32'h00007033) begin
        $display("passed");
        grade = grade + 10;
    end
    else
        $display("Failed");
    
    $display("\nTest2 (10 points): check if the addressing in memory is correct");
    addr_tb = 8'b00001100;
    #20;
    if (instruction_tb==32'h00308193) begin
        $display("passed");
        grade = grade + 10;
    end
    else
        $display("Failed");

    
    $display("Grade for InstMem: %d", grade);
    $finish;
        
end


endmodule
