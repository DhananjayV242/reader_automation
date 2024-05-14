`timescale 1ns / 1ps
  
module tb_FA();
  
   // Define input and output ports
  reg tb_A_1 = 0;
  reg tb_B_1 = 0;
  reg tb_Cin_1 = 0;
  wire tb_Sum_1;
  wire tb_Cout_1;
  
  integer FApoints = 0;

  // Port Mapping
  fa instant
    (
     .A(tb_A_1), 
     .B(tb_B_1),
     .Cin(tb_Cin_1),
     .Sum(tb_Sum_1),
     .Cout(tb_Cout_1)
     );
 
  always
    begin
      // FA BEGIN
	  tb_A_1 = 1'b0;
      tb_B_1 = 1'b0;
      tb_Cin_1 =1'b0;
      #10;
      if ((tb_Sum_1 == 1'b0) & (tb_Cout_1 == 1'b0))
        FApoints = FApoints + 2;
      #10;

	  tb_A_1 = 1'b1;
      tb_B_1 = 1'b0;
      tb_Cin_1 =1'b0;
      #10;
      if ((tb_Sum_1 == 1'b1) & (tb_Cout_1 == 1'b0))
        FApoints = FApoints + 2;
      #10;
    
      tb_A_1 = 1'b1;
      tb_B_1 = 1'b1;
      tb_Cin_1 =1'b0;
      #10;
      if ((tb_Sum_1 == 1'b0) & (tb_Cout_1 == 1'b1))
        FApoints = FApoints + 2;
      #10;
      
      tb_A_1 = 1'b1;
      tb_B_1 = 1'b1;
      tb_Cin_1 =1'b1;
      #10;
      if ((tb_Sum_1 == 1'b1) & (tb_Cout_1 == 1'b1))
        FApoints = FApoints + 2;
      #10;
	  
	  tb_A_1 = 1'b0;
      tb_B_1 = 1'b1;
      tb_Cin_1 =1'b0;
      #10;
      if ((tb_Sum_1 == 1'b1) & (tb_Cout_1 == 1'b0))
        FApoints = FApoints + 2;
      #10;
	  

	  tb_A_1 = 1'b1;
      tb_B_1 = 1'b1;
      tb_Cin_1 =1'b1;
      #10;
      if ((tb_Sum_1 == 1'b1) & (tb_Cout_1 == 1'b1))
        FApoints = FApoints + 2;
      #10;
	  
	  // FA END
	  
	  $display("%s%d","The number of correct test cases for FA is:" , FApoints);
      
      $finish;
    end 
  
endmodule // tb_FA

