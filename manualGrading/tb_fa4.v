`timescale 1ns / 1ps
  
module tb_FA4();
  
   // Define input and output ports
  reg [3:0] tb_A_2;
  reg [3:0] tb_B_2;
  reg tb_Cin_2;
  wire [3:0] tb_Sum_2;
  wire tb_Cout_2;
   
  integer FA4points = 0;
  // Port Mapping
  fa4 instant
    (
     .A(tb_A_2), 
     .B(tb_B_2),
     .Cin(tb_Cin_2),
     .Sum(tb_Sum_2),
     .Cout(tb_Cout_2)
     );
  
  always
    begin
  
      tb_A_2 = 4'b0000;
      tb_B_2 = 4'b0000;
      tb_Cin_2 =1'b0;
      #10; 
      if ((tb_Sum_2 == 4'b0000) & (tb_Cout_2 == 1'b0))
        FA4points = FA4points + 2;
 
      #10;
      	  
	  tb_A_2 = 4'b0000;
      tb_B_2 = 4'b0000;
      tb_Cin_2 =1'b1;
      #10; 
      if ((tb_Sum_2 == 4'b0001) & (tb_Cout_2 == 1'b0))
        FA4points = FA4points + 2;
 
      #10;
      
      tb_A_2 = 4'b1010;
      tb_B_2 = 4'b1010;
      tb_Cin_2 = 1'b0;
      #10;
      if ((tb_Sum_2 == 4'b0100) & (tb_Cout_2 == 1'b1))
        FA4points = FA4points + 2;
      #10;
      
      tb_A_2 = 4'b1111;
      tb_B_2 = 4'b1111;
      tb_Cin_2 =1'b1;
      #10;
      if ((tb_Sum_2 == 4'b1111) & (tb_Cout_2 == 1'b1))
        FA4points = FA4points + 2;
      #10;
      
      tb_A_2 = 4'b1011;
      tb_B_2 = 4'b1110;
      tb_Cin_2 =1'b0;
      #10;
      if ((tb_Sum_2 == 4'b1001) & (tb_Cout_2 == 1'b1))
        FA4points = FA4points + 2;
      #10;
        
      tb_A_2 = 4'b0001;
      tb_B_2 = 4'b0100;
      tb_Cin_2 = 1'b0;
      #10;
      if ((tb_Sum_2 == 4'b0101) & (tb_Cout_2 == 1'b0))
        FA4points = FA4points + 2;
      #10;
      
      //$display("%s%d","The number of correct test cases for FA4 is:" , point);
	  
	  tb_A_2 = 4'b0110;
      tb_B_2 = 4'b0100;
      tb_Cin_2 = 1'b0;
      #10;
      if ((tb_Sum_2 == 4'b1010) & (tb_Cout_2 == 1'b0))
        FA4points = FA4points + 2;
      #10;
      
      //$display("%s%d","The number of correct test cases for FA4 is:" , point);
	  
	  tb_A_2 = 4'b1000;
      tb_B_2 = 4'b1001;
      tb_Cin_2 = 1'b1;
      #10;
      if ((tb_Sum_2 == 4'b0010) & (tb_Cout_2 == 1'b1))
        FA4points = FA4points + 2;
      #10;
      //$display("%d", tb_Sum_2);
      //$display("%d", tb_Cout_2);
   
      //$display("%s%d","The number of correct test cases for FA4 is:" , point);
	  
	  tb_A_2 = 4'b1110;
      tb_B_2 = 4'b0010;
      tb_Cin_2 = 1'b0;
      #10;
      if ((tb_Sum_2 == 4'b0000) & (tb_Cout_2 == 1'b1))
        FA4points = FA4points + 2;
      #10;
      
      //$display("%s%d","The number of correct test cases for FA4 is:" , point);
	  
	  tb_A_2 = 4'b1010;
      tb_B_2 = 4'b1011;
      tb_Cin_2 = 1'b0;
      #10;
      if ((tb_Sum_2 == 4'b0101) & (tb_Cout_2 == 1'b1))
        FA4points = FA4points + 2;
      #10;
      
      $display("%s%d","The number of correct test cases for FA4 is:" , FA4points);
      
      
      $finish;
    end

endmodule // tb_FA4bit
