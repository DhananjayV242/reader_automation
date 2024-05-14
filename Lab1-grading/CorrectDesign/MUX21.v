`timescale 1ns / 1ps

module Mux_2_To_1 (
        D1 , D2 , S , Y
);

	// Define the input and output signals
	input  S;
	input  D1;
	input  D2;
	output Y;
	   
	// Define the MUX2:1 module behaviour  
	assign Y = (!S & D1) | (S & D2);
 

endmodule // Mux21

