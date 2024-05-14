`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/11/2020 03:33:03 PM
// Design Name: 
// Module Name: tb_MUX21
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

  
module tb_MUX21();

  // Define input and output ports
  reg tb_D0_1 = 0;
  reg tb_D1_1 = 0;

  reg tb_S_1 = 1'b0;
  wire tb_Y_1;
  
  integer MUX21points = 0; 
  
  // Port Mapping
  mux21 instant
    (
     .D1(tb_D0_1), 
     .D2(tb_D1_1),

     .S(tb_S_1),
     .Y(tb_Y_1)
     );
 
  always
    begin
      tb_D0_1 = 1'b1;
      tb_D1_1 = 1'b0;
      tb_S_1 = 1'b0;
      #10;
      if (tb_Y_1 == 1'b1)
        MUX21points = MUX21points + 2;
      #10;
      
      tb_S_1 = 1'b1;
      #10;
      if (tb_Y_1 == 1'b0)
        MUX21points = MUX21points + 2;
      #10;
	  
	  tb_D0_1 = 1'b0;
      tb_D1_1 = 1'b1;
	  tb_S_1 = 1'b0;
      #10;
      if (tb_Y_1 == 1'b0)
        MUX21points = MUX21points + 2;
      #10;
	  
	  tb_D0_1 = 1'b0;
      tb_D1_1 = 1'b1;
	  tb_S_1 = 1'b1;
      #10;
      if (tb_Y_1 == 1'b1)
        MUX21points = MUX21points + 2;
      #10;
	  
	  $display("%s%d","The number of correct test cases for MUX21 is:" , MUX21points);
      
    $finish;
end 
endmodule // tb_MUX21
