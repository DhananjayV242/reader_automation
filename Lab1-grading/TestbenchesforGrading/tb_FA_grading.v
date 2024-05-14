`timescale 1ns / 1ps
  
module tb_FA();
  
   // Define input and output ports
  reg tb_A = 0;
  reg tb_B = 0;
  reg tb_Cin = 0;
  wire tb_Sum;
  wire tb_Cout;
  
  integer point = 0;

  // Port Mapping
  FA instant
    (
     .A(tb_A), 
     .B(tb_B),
     .Cin(tb_Cin),
     .Sum(tb_Sum),
     .Cout(tb_Cout)
     );
 
  always
    begin
      tb_A = 1'b1;
      tb_B = 1'b0;
      tb_Cin =1'b0;
      #10;
      if ((tb_Sum == 1'b1) & (tb_Cout == 1'b0))
        point = point + 1;
      #10;
      
      tb_A = 1'b1;
      tb_B = 1'b1;
      tb_Cin =1'b0;
      #10;
      if ((tb_Sum == 1'b0) & (tb_Cout == 1'b1))
        point = point + 1;
      #10;
      
      tb_A = 1'b1;
      tb_B = 1'b1;
      tb_Cin =1'b1;
      #10;
      if ((tb_Sum == 1'b1) & (tb_Cout == 1'b1))
        point = point + 1;
      #10;
      
      $display("%s%d","The number of correct test cases is:" , point);
      
      $finish;
    end 
  
endmodule // tb_FA

