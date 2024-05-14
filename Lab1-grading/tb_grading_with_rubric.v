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

  
module tb_grading();

  // Define input and output ports
  reg tb_D0_1 = 0;
  reg tb_D1_1 = 0;
  reg tb_S_1 = 1'b0;
  wire tb_Y_1;
  
  reg tb_D0_2 = 0;
  reg tb_D1_2 = 0;
  reg tb_D2_2 = 0;
  reg tb_D3_2 = 0;
  reg [1:0] tb_S_2 = 2'b00;
  wire tb_Y_2;
  
  reg tb_A_1 = 0;
  reg tb_B_1 = 0;
  reg tb_Cin_1 = 0;
  wire tb_Sum_1;
  wire tb_Cout_1;
  
  reg [3:0] tb_A_2;
  reg [3:0] tb_B_2;
  reg tb_Cin_2;
  wire [3:0] tb_Sum_2;
  wire tb_Cout_2;
  
  integer totalpoint = 0;
  integer MUX21points = 0; 
  integer MUX41points = 0; 
  integer FApoints = 0;
  integer FA4points = 0; 
  
  // Port Mapping
  Mux_2_To_1 instant1
    (
     .D1(tb_D0_1), 
     .D2(tb_D1_1),

     .S(tb_S_1),
     .Y(tb_Y_1)
     );
	 
  Mux_4_To_1 instant2
    (
     .D1(tb_D0_2), 
     .D2(tb_D1_2),
     .D3(tb_D2_2), 
     .D4(tb_D3_2),

     .S(tb_S_2),
     .Y(tb_Y_2)
     );
	 
  FA instant3
    (
     .A(tb_A_1), 
     .B(tb_B_1),
     .Cin(tb_Cin_1),
     .Sum(tb_Sum_1),
     .Cout(tb_Cout_1)
     );
	 
  FA4 instant4
    (
     .A(tb_A_2), 
     .B(tb_B_2),
     .Cin(tb_Cin_2),
     .Sum(tb_Sum_2),
     .Cout(tb_Cout_2)
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
	  
	  // FA4 BEGIN

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
	  
	  // FA4 END
	  // MUX21 BEGIN
	  
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
	  
	  // MUX21 END	        
	  // MUX41 BEGIN
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
	  
	  // MUX41 END
	  
	  


	  
	  
	  
          
    $display("%s%d","The number of correct test cases is:" , FA4points+ FApoints+ MUX21points+ MUX41points);
      
    $finish;
end 
endmodule // tb_grading
