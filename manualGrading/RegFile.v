`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2024 02:45:41 AM
// Design Name: 
// Module Name: RegFile
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

// Module definition
module RegFile (

// Define the input and output signals
input  clk,
input  reset,
input  rg_wrt_en,
input  [4:0] rg_wrt_addr,
input  [4:0] rg_rd_addr1,
input  [4:0] rg_rd_addr2,
input  [31:0] rg_wrt_data,

output wire [31:0] rg_rd_data1,
output wire [31:0] rg_rd_data2

);
// Define the Register File module behavior
reg [31:0] registers [31:0]; //32 registers x 32-bit wide array
integer i;

always @(posedge clk or posedge reset)
begin
   if (reset) //if reset is enabled, every bit in the register will be 0
   begin
        for (i = 0; i < 32; i = i + 1) 
            begin
                registers[i] <= 32'b0;
            end
        end 
        else if (rg_wrt_en == 1) //when reset is 0 AND write is enabled, it can write ino a selected register 
        begin 
            registers[rg_wrt_addr] <= rg_wrt_data;  //assign data that we want to write into it to the right address
        end
    end

    assign rg_rd_data1 = registers[rg_rd_addr1]; //assign read data to appropriate read register at right address
    assign rg_rd_data2 = registers[rg_rd_addr2]; //assign read data to appropriate read register at right address
   
    
endmodule // RegFile