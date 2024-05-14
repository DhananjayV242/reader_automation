`timescale 1ns / 1ps

// Module definition
module fa(
   A,
   B,
   Cin,
   Sum,
   Cout
   );
 
   // Define the input and output signals
   input  A;
   input  B;
   input Cin;
   output Sum;
   output Cout;
 
  // Define the full adder module behaviour
  assign Sum   = A ^ B ^ Cin;
  assign Cout = (A & B) | (A & Cin) | (B & Cin);
 

endmodule //FA

