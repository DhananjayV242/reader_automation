`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2024 12:31:38 PM
// Design Name: 
// Module Name: ALU
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


module ALU_32(
input [31:0] A_in, [31:0] B_in, [3:0] ALU_ctrl, 
output reg [31:0] ALU_out, 
output reg zero, reg overflow, reg carry_out
    );
    
    always @(*)
        begin
            if(overflow == 1 | carry_out == 1)
                begin
                    overflow=0;
                    carry_out=0;
                end
            case(ALU_ctrl)
                4'b0000: ALU_out <= A_in & B_in;//AND
                
                4'b0001: ALU_out <= A_in | B_in;//OR
                
                4'b0110: begin 
                ALU_out = A_in + (~B_in + 32'b1);
                if({ALU_out[31],A_in[31],B_in[31]} == 3'b010 |{ALU_out[31],A_in[31],B_in[31]} == 3'b101) overflow=1;
                else overflow = 0;
                end //SUBTRACT
                
                4'b0111: begin
                if(A_in<B_in) ALU_out <= 32'b1;
                else ALU_out <=32'b0;
                end //SLT
                
                4'b1100: ALU_out <= ~(A_in | B_in); 
                
                4'b1111: begin
                    if(A_in == B_in) ALU_out <= 32'b1;
                    else ALU_out <= 32'b0;
                end //Equal comparison
                
                default: begin 
                {carry_out, ALU_out} = A_in + B_in;
                end //default case is addition 
            endcase
            if(ALU_out==32'b0) zero = 1;
            else zero = 0;
        end
endmodule
