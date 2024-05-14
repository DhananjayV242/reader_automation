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
  reg tb_D0 = 0;
  reg tb_D1 = 0;

  reg tb_S = 1'b0;
  wire tb_Y;
  
  integer point = 0; 
  
  // Port Mapping
  Mux_2_To_1 instant
    (
     .D1(tb_D0), 
     .D2(tb_D1),

     .S(tb_S),
     .Y(tb_Y)
     );
 
  always
    begin
      tb_D0 = 1'b1;
      tb_D1 = 1'b0;
      tb_S = 1'b0;
      #10;
      if (tb_Y == 1'b1)
        point = point + 1;
      #10;
      
      tb_S = 1'b1;
      #10;
      if (tb_Y == 1'b0)
        point = point + 1;
      #10;
    
    $display("%s%d","The number of correct test cases is:" , point);
      
    $finish;
end 
endmodule // tb_MUX21
