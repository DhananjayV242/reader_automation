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

  
module tb_MUX41();

  // Define input and output ports
  reg tb_D0_2 = 0;
  reg tb_D1_2 = 0;
  reg tb_D2_2 = 0;
  reg tb_D3_2 = 0;
  
  reg [1:0] tb_S_2 = 2'b00;
  wire tb_Y_2;
  
  integer MUX41points = 0; 
  
  // Port Mapping
  mux41 instant
    (
     .D1(tb_D0_2), 
     .D2(tb_D1_2),
     .D3(tb_D2_2), 
     .D4(tb_D3_2),

     .S(tb_S_2),
     .Y(tb_Y_2)
     );
 
  always
    begin
      tb_D0_2 = 1'b1;
      tb_D1_2 = 1'b0;
      tb_D2_2 = 1'b0;
      tb_D3_2 = 1'b1; 
           
      tb_S_2 = 2'b00;
      #10;
      if (tb_Y_2 == 1'b1)
        MUX41points = MUX41points + 2;
	
      #10;
      
      tb_S_2 = 2'b01;
      #10;
      if (tb_Y_2 == 1'b0)
        MUX41points = MUX41points + 2;
      #10;

      tb_S_2 = 2'b10;
      #10;
      if (tb_Y_2 == 1'b0)
        MUX41points = MUX41points + 2;
      #10;     

      tb_S_2 = 2'b11;
      #10;
      if (tb_Y_2 == 1'b1)
        MUX41points = MUX41points + 2;
      #10;
	  
	  tb_D0_2 = 1'b0;
      tb_D1_2 = 1'b1;
      tb_D2_2 = 1'b0;
      tb_D3_2 = 1'b1; 
           
      tb_S_2 = 2'b00;
      #10;
      if (tb_Y_2 == 1'b0)
        MUX41points = MUX41points + 2;
      #10;
	  
	  tb_S_2 = 2'b01;
      #10;
      if (tb_Y_2 == 1'b1)
        MUX41points = MUX41points + 2;
      #10;
	  
	  tb_S_2 = 2'b10;
      #10;
      if (tb_Y_2 == 1'b0)
        MUX41points = MUX41points + 2;
      #10;
	  
	  tb_S_2 = 2'b11;
      #10;
      if (tb_Y_2 == 1'b1)
        MUX41points = MUX41points + 2;
      #10;
      
      $display("%s%d","The number of correct test cases for MUX41 is:" , MUX41points);
      
    $finish;
end 
endmodule // tb_MUX21
