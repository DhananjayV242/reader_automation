`timescale 1ns / 1ps

module Mux_4_To_1 (
        D1 , D2 , D3, D4 , S , Y
);

	// Define the input and output signals 
	input [1:0] S;
	input D1;
	input D2;
	input D3;
	input D4; 
	output Y;
	
	// Define the MUX4:1 module behaviour
	assign Y = (!S[1] & !S[0] & D1) | (!S[1] & S[0] & D2) | (S[1] & !S[0] & D3)| (S[1] & S[0] & D4);

endmodule // Mux21

