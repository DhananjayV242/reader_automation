`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2020 03:33:22 PM
// Design Name: 
// Module Name: tb_FlipFlop
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

module tb_FlipFlop();

reg [7:0]tb_d;
reg tb_clk = 1'b0;
reg tb_reset;
wire [7:0] tb_q;

integer grade = 0;
FlipFlop instant
(
    .d(tb_d),
    .clk(tb_clk),
    .reset(tb_reset),
    .q(tb_q)
);

always
begin
  #20 
  tb_clk = ~tb_clk;  
end 


initial begin 
 $display("\nTest1 (5 points): check if reset is working");
 tb_reset= 1'b1;
 tb_d = 8'b00111000;
 #80;
 if (tb_q==0) begin
    $display("passed");
    grade = grade + 5;
 end
 else
    $display("Failed");
    
 $display("\nTest2 (5 points): check if q<=d is working");
 tb_reset=1'b0;
 tb_d = 8'b00111000;
 #30;
 if (tb_q==tb_d) begin
    $display("passed");
     grade = grade + 5;
 end
 else
    $display("Failed");
    
 $display("\nTest3 (5 points): check if reset is synchronous (happens only on posedge of clock)");
 tb_reset= 1'b1;
 #10;
  if (tb_q==tb_d) begin
    $display("passed");
     grade = grade + 5;
  end
 else
    $display("Failed");
    
 $display("\nTest4 (5 points): check if q<=d is synchronous (happens only on posedge of clock)");
 tb_d = 8'b11110000;
 tb_reset= 1'b0;
 #10;
  if (tb_q==tb_d) 
    $display("Failed");
 else begin
    $display("Passed");
     grade = grade + 5;
 end
   
   $display("Grade for FF Design: %d", grade);
   $finish;
end 
endmodule 
