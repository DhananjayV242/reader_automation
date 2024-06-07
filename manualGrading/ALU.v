`timescale 1ns / 1ps
// Module definition
module ALU_32(A_in , B_in , ALU_ctrl , ALU_out , carry_out , zero , overflow );
// Define I/O 
input[31:0] A_in;
input[31:0] B_in;
input [3:0] ALU_ctrl;
output[31:0] ALU_out;
output carry_out;
output zero;
output overflow;

reg [31:0] result;
reg carry_out = 0;
reg zero = 0;
reg overflow = 0;


assign ALU_out = result;
always @(ALU_ctrl or A_in or B_in)
begin
    carry_out = 0;
    zero = 0;
    overflow =0;
    case( ALU_ctrl)
        4'b0000 : result = A_in & B_in; //BITWISE AND
        4'b0001 : result = A_in | B_in;//BITWISE OR
        4'b0010 : {carry_out, result} = $signed(A_in) + $signed(B_in);//ADD
        4'b0110 : {carry_out, result} = $signed(A_in) - $signed(B_in);//SUBTRACT
        4'b0111 : if($signed(A_in)<$signed(B_in))//set less-than
                begin
                    result = 32'b1;
                end
           else
                begin
                    result = 32'b0;
                end
        4'b1100: result = ~(A_in | B_in); //set NOR 
        4'b1111: if(A_in == B_in)//set equal
                begin
                    result = 32'b1;
                end
           else
                begin
                    result = 32'b0;
                end //EQUAL COMPARISON
    endcase
    if(result == 32'b0)
        begin
            zero = 1;
        end
    else
        begin
            zero = 0;
        end
    if(carry_out == 1'b1)
        begin
            overflow = 1;
        end
    else
        begin
            overflow = 0;
        end
    
end
endmodule // 32-bit ALU
// Module definition
module fa32 (A , B , Cin , Sum , Cout );
// Define I / O signals
input [31:0] A ;
input [31:0] B ;
input Cin ;
output [31:0] Sum ;
output Cout ;
// Describe FA behavior
assign { Cout , Sum } = A + B + Cin ;
endmodule // 32 - bit full adder