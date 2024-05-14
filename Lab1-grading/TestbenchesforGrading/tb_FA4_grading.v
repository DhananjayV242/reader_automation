`timescale 1ns / 1ps
  
module tb_FA4();
  
   // Define input and output ports
  reg [3:0] tb_A;
  reg [3:0] tb_B;
  reg tb_Cin;
  wire [3:0] tb_Sum;
  wire tb_Cout;
   
  integer point = 0;
  // Port Mapping
  FA4 instant
    (
     .A(tb_A), 
     .B(tb_B),
     .Cin(tb_Cin),
     .Sum(tb_Sum),
     .Cout(tb_Cout)
     );
  
  always
    begin
  
      tb_A = 4'b0000;
      tb_B = 4'b0000;
      tb_Cin =1'b1;
      #10; 
      if ((tb_Sum == 4'b0001) & (tb_Cout == 1'b0))
        point = point + 1;
 
      #10;
      
      tb_A = 4'b1010;
      tb_B = 4'b1010;
      tb_Cin =1'b0;
      #10;
      if ((tb_Sum == 4'b0100) & (tb_Cout == 1'b1))
        point = point + 1;
      #10;
      
      tb_A = 4'b1111;
      tb_B = 4'b1111;
      tb_Cin =1'b1;
      #10;
      if ((tb_Sum == 4'b1111) & (tb_Cout == 1'b1))
        point = point + 1;
      #10;
      
      tb_A = 4'b1011;
      tb_B = 4'b1110;
      tb_Cin =1'b0;
      #10;
      if ((tb_Sum == 4'b1001) & (tb_Cout == 1'b1))
        point = point + 1;
      #10;
        
      tb_A = 4'b0001;
      tb_B = 4'b0100;
      tb_Cin =1'b0;
      #10;
      if ((tb_Sum == 4'b0101) & (tb_Cout == 1'b0))
        point = point + 1;
      #10;
      
      
      $display("%s%d","The number of correct test cases is:" , point);
      
      $finish;
    end

endmodule // tb_FA4bit
