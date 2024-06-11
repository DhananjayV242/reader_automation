`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/01/2021 10:55:56 AM
// Design Name: 
// Module Name: tb_with_rubric
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

module tb_top();

// Flip Flop TB signals
reg [7:0]tb_d;
reg tb_clk = 1'b0;
reg tb_reset;
wire [7:0] tb_q;

// Instruction Memory TB signals
reg [7:0] addr_tb;
wire [31:0] instruction_tb;

// RegFile TB signals
reg clk_tb = 1'b0;
reg reset_tb = 1'b0; 
reg rg_wrt_en_tb = 1'b0;
reg [4:0] rg_wrt_addr_tb;
reg [4:0] rg_rd_addr1_tb;
reg [4:0] rg_rd_addr2_tb;
reg [31:0] rg_wrt_data_tb;
wire [31:0] rg_rd_data1_tb;
wire [31:0] rg_rd_data2_tb;

// Grading variables
integer grade = 0;
integer grade_ff = 0;
integer grade_im = 0;
integer grade_regfile = 0;

FlipFlop instantFF
(
    .d(tb_d),
    .clk(tb_clk),
    .reset(tb_reset),
    .q(tb_q)
);

InstMem instantIM
(
    .addr(addr_tb),
    .instruction(instruction_tb)
);

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
  tb_clk = ~tb_clk;  
end 

always
begin
  #20 
  clk_tb = ~clk_tb;  
end 

initial begin 

    // --------------------------- FLIP FLOP TESTING ----------------------------------

    $display("\nTest1 (5 points): check if reset is working");
    tb_reset= 1'b1;
    tb_d = 8'b00111000;
    #80;
    if (tb_q==0) begin
       $display("Passed");
       grade = grade + 5;
       grade_ff = grade_ff + 5;
    end
    else
       $display("Failed");
    
    $display("\nTest2 (5 points): check if q<=d is working");
    tb_reset=1'b0;
    tb_d = 8'b00111000;
    #30;
    if (tb_q==tb_d) begin
       $display("Passed");
       grade = grade + 5;
       grade_ff = grade_ff + 5;
    end
    else
       $display("Failed");
    
    $display("\nTest3 (5 points): check if reset is synchronous (happens only on posedge of clock)");
    tb_reset= 1'b1;
    #10;
     if (tb_q==tb_d) begin
       $display("Passed");
       grade = grade + 5;
       grade_ff = grade_ff + 5;
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
       grade_ff = grade_ff + 5;
    end
    // --------------------------- INSTRUCTION MEMORY TESTING ----------------------------------

    $display("\nTest1 (10 points): check if we can read from memory");
    addr_tb = 8'b00000000;
    #20;
    if (instruction_tb==32'h00007033) begin
        $display("Passed");
        grade = grade + 10;
        grade_im = grade_im + 10;
    end
    else
        $display("Failed");
    
    $display("\nTest2 (10 points): check if the addressing in memory is correct");
    addr_tb = 8'b00001100;
    #20;
    if (instruction_tb==32'h00308193) begin
        $display("Passed");
        grade = grade + 10;
        grade_im = grade_im + 10;
    end
    else
        $display("Failed");
    

    // --------------------------- REGISTER FILE TESTING ----------------------------------

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
        $display("Passed");
        grade = grade + 5;
        grade_regfile = grade_regfile + 5;
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
        $display("Passed");
        grade = grade + 5;
        grade_regfile = grade_regfile + 5;
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
        $display("Passed");
        grade = grade + 5;
        grade_regfile = grade_regfile + 5;
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
        $display("Passed");
        grade = grade + 5;
        grade_regfile = grade_regfile + 5;
     end
     else  begin
        $display("Failed");   
        $display("The module failed in this test because the reset is synchronous or reading from meory is not independent from clock");
        end

    // --------------------------- FINAL GRADE PRINTING ----------------------------------
    $display("Grading complete!!");
    $display("Grade for FlipFlop design: %d", grade_ff );
    $display("Grade for InstMem  design: %d", grade_im );
    $display("Grade for RegFile  design: %d", grade_regfile );
    $display("Grade for Total    Lab:    %d", grade );

    $finish;

end 


endmodule