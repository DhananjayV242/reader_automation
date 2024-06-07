`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UCIrvine
// Engineer: Maryam S. Hosseini - Copyrighted
// Create Date: 01/13/2020 04:46:20 PM
// Design Name: 
// Module Name: alu_32
// Project Name: 
// Target Devices: 
// Description: 
// Dependencies: 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//////////////////////////////////////////////////////////////////////////////////

module ALU_32(
   input  [31:0] A_in,B_in,        // ALU 32 bit inputs
   input  [3:0]  ALU_ctrl,          // ALU 4 bits selection
   output [31:0] ALU_out,          // ALU 32 bits output
   output reg    carry_out,
   output        zero,             // 1 bit Zero Flag
   output reg    overflow = 1'b0   // 1 bit overflow flag has value zero as a default value and we will set it to 1 for Add and Sub if overflow occurs!
    );
  reg  [31:0] ALU_Result;
  reg [32:0] temp;
  reg [32:0] twos_com; // to hold 2'sc of second source of ALU
  
  assign ALU_out   = ALU_Result;              // ALU Out
  assign zero      = (ALU_Result == 0);      // Zero Flag
        
  always @(*)
    begin
     overflow = 1'b0;
     carry_out = 1'b0;
     case(ALU_ctrl)
        4'b0000: //  Bitwise and 
          ALU_Result = A_in & B_in;
          
        4'b0001: //  Bitwise or
          ALU_Result = A_in | B_in;
           
        4'b0010: // Signed Addition with overflow and carry_out checking
           begin
             ALU_Result = $signed(A_in) + $signed(B_in); 
             temp = {1'b0, A_in} + {1'b0, B_in};
             carry_out = temp[32];
             if ((A_in[31] & B_in[31] & ~ALU_out[31]) | (~A_in[31] & ~B_in[31] & ALU_out[31]))
                 overflow = 1'b1;
             else 
                 overflow = 1'b0;
           end 
           
        4'b0110: // Signed Subtraction with overflow checking
           begin
             ALU_Result = $signed(A_in) - $signed(B_in) ;
             twos_com = ~(B_in) + 1'b1; 
             if ((A_in[31] & twos_com[31] & ~ALU_out[31]) | (~A_in[31] & ~twos_com[31] & ALU_out[31]))
                 overflow = 1'b1;
             else 
                 overflow = 1'b0;
           end 
           
         4'b0111: // Signed less than comparison
           ALU_Result = ($signed(A_in) < $signed(B_in))?32'd1:32'd0;
           
         4'b1100: //  Bitwise nor
           ALU_Result = ~(A_in | B_in);
           
         4'b1111: // Equal comparison   
           ALU_Result = (A_in==B_in)?32'd1:32'd0 ; 
                 
         default: ALU_Result = A_in + B_in ; 
       endcase
     end
   
endmodule
