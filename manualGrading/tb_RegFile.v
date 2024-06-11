`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/31/2021 01:10:57 PM
// Design Name: 
// Module Name: RegFile_tb
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


module RegFile_tb();

reg clk_tb = 1'b0;
reg reset_tb = 1'b0; 
reg rg_wrt_en_tb = 1'b0;
reg [4:0] rg_wrt_addr_tb;
reg [4:0] rg_rd_addr1_tb;
reg [4:0] rg_rd_addr2_tb;
reg [31:0] rg_wrt_data_tb;
wire [31:0] rg_rd_data1_tb;
wire [31:0] rg_rd_data2_tb;

integer grade = 0;

RegFile instant
(
    .clk(clk_tb),
    .reset(reset_tb), 
    .rg_wrt_en(rg_wrt_en_tb),
    .rg_wrt_addr(rg_wrt_addr_tb), 
    .rg_rd_addr1(rg_rd_addr1_tb),
    .rg_rd_addr2(rg_rd_addr2_tb), 
    .rg_wrt_data(rg_wrt_data_tb),
    .rg_rd_data1(rg_rd_data1_tb),
    .rg_rd_data2(rg_rd_data2_tb)
);

always
begin
  #20 
  clk_tb = ~clk_tb;  
end 

initial begin
$display("-- Register File Testing --");
$display("Note that if the reading from memory functionality doesn't work corectly, the module fails in all tests.");

$display("\nTest1 (5 points): check if reset is working");
reset_tb = 1'b1;
rg_wrt_en_tb = 1'b0;
rg_wrt_addr_tb = 5'b00000;
rg_rd_addr1_tb = 5'b00001;
rg_rd_addr2_tb = 5'b11111;
rg_wrt_data_tb = 32'hffffffff;
#40;
 if (rg_rd_data1_tb==0 && rg_rd_data2_tb==0) begin
    $display("passed");
     grade = grade + 5;
 end
 else
    $display("Failed");
    

$display("\nTest2 (5 points): check if writing in memory is working");
reset_tb = 1'b0;
rg_wrt_en_tb = 1'b1;
rg_wrt_addr_tb = 5'b00001;
rg_rd_addr1_tb = 5'b00001;
rg_rd_addr2_tb = 5'b11111;
rg_wrt_data_tb = 32'hffffffff;
#40;
 if (rg_rd_data1_tb==32'hffffffff && rg_rd_data2_tb==0) begin
    $display("passed");
     grade = grade + 5;
 end
 else
    $display("Failed");
    

$display("\nTest3 (5 points): check if writing happens only if the writing condition is set (enable is 1, reset is 0)");
reset_tb = 1'b0;
rg_wrt_en_tb = 1'b0;
rg_wrt_addr_tb = 5'b00011;
rg_rd_addr1_tb = 5'b00011;
rg_rd_addr2_tb = 5'b11111;
rg_wrt_data_tb = 32'h12345678;
#40;
 if (rg_rd_data1_tb==0 && rg_rd_data2_tb==0) begin
    $display("passed");
    grade = grade + 5;
 end
 else begin
    $display("Failed");  
    $display("The module failed in this test because the writing in memory happens despite the writing was disabled");
    end
       
$display("\nTest3 (5 points): check if reset is asynchronous (happens independently from clock)");
reset_tb = 1'b1;
rg_wrt_en_tb = 1'b1;
rg_wrt_addr_tb = 5'b00001;
rg_rd_addr1_tb = 5'b00001;
rg_rd_addr2_tb = 5'b00011;
rg_wrt_data_tb = 32'hffffffff;
#10;
 if (rg_rd_data1_tb==0 && rg_rd_data2_tb==0) begin
    $display("passed");
    grade = grade + 5;
 end
 else  begin
    $display("Failed");   
    $display("The module failed in this test because the reset is synchronous or reading from meory is not independent from clock");
    end
    
    
    $display("Grade for RegFile: %d", grade);
    $finish;

end

endmodule