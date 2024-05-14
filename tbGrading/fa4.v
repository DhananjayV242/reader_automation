`timescale 1ns / 1ps

// Module definition
module fa4(
   A,
   B,
   Cin,
   Sum,
   Cout
   );
 
	// Define the input and output signals
	input  [3:0] A;
	input  [3:0] B;
	input Cin;
	output [3:0] Sum;
	output Cout;

	wire [2:0] carry; 
 
	// Define the 4-bit full adder module behaviour  
	assign Sum[0] = A[0] ^ B[0] ^ Cin;
	assign carry[0] = (A[0] & B[0]) | (A[0] & Cin) | (B[0] & Cin);

	assign Sum[1] = A[1] ^ B[1] ^ carry[0];
	assign carry[1] = (A[1] & B[1]) | (A[1] & carry[0]) | (B[1] & carry[0]);

	assign Sum[2] = A[2] ^ B[2] ^ carry[1];
	assign carry[2] = (A[2] & B[2]) | (A[2] & carry[1]) | (B[2] & carry[1]);

	assign Sum[3] = A[3] ^ B[3] ^ carry[2];
	assign Cout = (A[3] & B[3]) | (A[3] & carry[2]) | (B[3] & carry[2]);


endmodule //FA4bit

