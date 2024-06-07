`timescale 1ns / 1ps
// Written by: Maryam S. Hosseini @ UCIrvine - Winter 2021 - Copyrighted

// for carryout only check value for addition, we don't care what is carryout flag value for other operations!
module tb_top();
 
 reg  [3:0]  tb_alu_sel;
 reg  [31:0] tb_din_a, tb_din_b;
 wire  [31:0] tb_alu_out;
 wire  overflow;
 wire  carry_out;
 wire  zero;
 
 // to see how many tests are passed
 real point = 0;
 integer grade = 0;
 
  ALU_32 
  instant(
   .A_in       (tb_din_a),
   .B_in       (tb_din_b),
   .ALU_ctrl   (tb_alu_sel),
   .ALU_out    (tb_alu_out),
   .carry_out  (carry_out),
   .zero       (zero),
   .overflow   (overflow)
   );

 
 initial begin
 // ----------------------    AND operation  with Zero Flag (weight = 4)  ---------------------------
 tb_din_a = 32'hA5002D77;
 tb_din_b = 32'hF14C0A81;
 tb_alu_sel = 4'b0000;
 #20;
 if ((tb_alu_out == 32'hA1000801))
   begin
    grade = grade + 2;
    point = point + 0.5;
    $display("[INFO]:: %t @Line %0d : AND OPERATION PASSED", $time, `__LINE__);
    if ((zero == 1'b0))
      begin
        grade = grade + 2;
        point = point + 0.5;
       $display("[INFO]:: %t @Line %0d : AND OPERATION ZERO FLAG PASSED", $time, `__LINE__);
      end
    else  $display ("[ERROR]:: %t @Line %0d : AND OPERATION ZERO FLAG FAILED", $time, `__LINE__);
      
   end
 else begin
 $display("[ERROR]:: %t @Line %0d : AND OPERATION FAILED", $time, `__LINE__);
end
 #20;
 
 // ----------------------    OR operation  with Zero Flag (weight = 4)   ----------------------------
 tb_din_a = 32'h8086F09D;
 tb_din_b = 32'h4E1B0072;
 tb_alu_sel = 4'b0001;
 #20;
 if ((tb_alu_out == 32'hCE9FF0FF))
   begin
     grade = grade + 2;
     point = point + 0.5;
     $display("[INFO]:: %t @Line %0d : OR OPERATION PASSED", $time, `__LINE__);
      if ((zero == 1'b0))
      begin
        grade = grade + 2;
        point = point + 0.5;
       $display("[INFO]:: %t @Line %0d : OR OPERATION ZERO FLAG PASSED", $time, `__LINE__);
      end 
     else begin  $display("[ERROR]:: %t @Line %0d : OR OPERATION ZERO FLAG FAILED", $time, `__LINE__);
     end       
   end
 else begin
 $display("[ERROR]:: %t @Line %0d : OR OPERATION FAILED", $time, `__LINE__);
 end
 #20;
 
 // ----------------------    Add operation with carry and No overflow (weight = 12)----------------------------
 tb_din_a = 32'hC182F088;   
 tb_din_b = 32'hD07915C2;  
 tb_alu_sel = 4'b0010;
 #20;
  if (tb_alu_out == 32'h91FC064A)
  begin
    grade = grade + 4;
     point = point + 0.5;
     $display("[INFO]:: %t @Line %0d : FIRST TEST OF ADD OPERATION PASSED", $time, `__LINE__);
      if (carry_out == 1'b1)
      begin
        grade = grade + 4;
        point = point + 0.25;
        $display("[INFO]:: %t @Line %0d : FISRT TEST OF ADD OPERATION'S CARRY-OUT FLAG PASSED", $time, `__LINE__);
      end 
      else $display("[ERROR]:: %t @Line %0d : FISRT TEST OF ADD OPERATION'S CARRY-OUT FLAG FAILED", $time, `__LINE__);
      if (overflow == 1'b0) 
      begin
        grade = grade + 4;
        point = point + 0.25;
         $display("[INFO]:: %t @Line %0d : FISRT TEST OF ADD OPERATION'S OVERFLOW FLAG PASSED", $time, `__LINE__);
      end 
      else $display("[ERROR]:: %t @Line %0d : FISRT TEST OF ADD OPERATION'S OVERFLOW FLAG FAILED", $time, `__LINE__);
  end    
 else begin
 $display("[ERROR]:: %t @Line %0d : FIRST TEST OF ADD OPERATION FAILED", $time, `__LINE__);
 end
 #20;
 
 // ----------------------    Add operation with No carry and overflow (weight = 12)----------------------------
 tb_din_a = 32'h4182F088;
 tb_din_b = 32'h507915C3;
 tb_alu_sel = 4'b0010;
 #20;
  if ((tb_alu_out == 32'h91FC064B))
  begin
    grade = grade + 4;
     point = point + 0.5;
     $display("[INFO]:: %t @Line %0d : SECOND TEST OF ADD OPERATION PASSED", $time, `__LINE__);
      if (carry_out == 1'b0)
      begin
        grade = grade + 4;
        point = point + 0.25;
        $display("[INFO]:: %t @Line %0d : SECOND TEST OF ADD OPERATION'S CARRY-OUT FLAG PASSED", $time, `__LINE__);
      end 
      else $display("[ERROR]:: %t @Line %0d : SECOND TEST OF ADD OPERATION'S CARRY-OUT FLAG FAILED", $time, `__LINE__);
      if (overflow == 1'b1) 
      begin
        grade = grade + 4;
        point = point + 0.25;
         $display("[INFO]:: %t @Line %0d : SECOND TEST OF ADD OPERATION'S OVERFLOW FLAG PASSED", $time, `__LINE__);
      end 
      else $display("[ERROR]:: %t @Line %0d : SECOND TEST OF ADD OPERATION'S OVERFLOW FLAG FAILED", $time, `__LINE__);
  end    
 else begin
 $display("[ERROR]:: %t @Line %0d : SECOND TEST OF ADD OPERATION FAILED", $time, `__LINE__);
 end
 #20;
 
 // ----------------------   Sub operation  with No overflow (weight = 12) ----------------------------
 tb_din_a = 32'hC182F088;
 tb_din_b = 32'hD07915C2;
 tb_alu_sel = 4'b0110;
 #20;
 if ((tb_alu_out == 32'hF109DAC6))
 begin
    grade = grade + 4;
     point = point + 0.5;
     $display("[INFO]:: %t @Line %0d : FIRST TEST OF SUB OPERATION PASSED", $time, `__LINE__);
      if ((zero == 1'b0))
      begin
        grade = grade + 4;
        point = point + 0.25;
        $display("[INFO]:: %t @Line %0d : FISRT TEST OF SUB OPERATION'S ZERO FLAG PASSED", $time, `__LINE__);
      end 
      else $display("[ERROR]:: %t @Line %0d : FIRST TEST OF SUB OPERATION'S ZERO FLAG FAILED", $time, `__LINE__);
      if (overflow == 1'b0) 
      begin
        grade = grade + 4;
        point = point + 0.25;
         $display("[INFO]:: %t @Line %0d : FISRT TEST OF SUB OPERATION'S OVERFLOW FLAG PASSED", $time, `__LINE__);
      end 
      else $display("[ERROR]:: %t @Line %0d : FIRST TEST OF SUB OPERATION'S OVERFLOW FLAG FAILED", $time, `__LINE__);
 end
 else begin
 $display("[ERROR]:: %t @Line %0d : FIRST TEST OF SUB OPERATION FAILED", $time, `__LINE__);
 end
 #20;
 
 // ----------------------   Sub operation  with  Overflow (weight = 12) ----------------------------
 tb_din_a = 32'hB182F088;
 tb_din_b = 32'h707915C3;
 tb_alu_sel = 4'b0110;
 #20;
 if ((tb_alu_out == 32'h4109DAC5))
 begin
    grade = grade + 4;
     point = point + 0.5;
     $display("[INFO]:: %t @Line %0d : SECOND TEST OF SUB OPERATION PASSED", $time, `__LINE__);
      if ((zero == 1'b0))
      begin
        grade = grade + 4;
        point = point + 0.25;
       $display("[INFO]:: %t @Line %0d : SECOND TEST OF SUB OPERATION'S Zero FLAG PASSED", $time, `__LINE__);
      end 
      else $display("[ERROR]:: %t @Line %0d : SECOND TEST OF SUB OPERATION'S Zero FLAG FAILED", $time, `__LINE__);
      if (overflow == 1'b1) 
      begin
        grade = grade + 4;
        point = point + 0.25;
         $display("[INFO]:: %t @Line %0d : SECOND TEST OF SUB OPERATION'S OVERFLOW FLAG PASSED", $time, `__LINE__);
      end 
      else $display("[ERROR]:: %t @Line %0d : SECOND TEST OF SUB OPERATION'S OVERFLOW FLAG FAILED", $time, `__LINE__);
 end
 else begin
 $display("[ERROR]:: %t @Line %0d : SECOND TEST OF SUB OPERATION FAILED", $time, `__LINE__);
 end
 #20;
 
 // ----------------------   SLT operation with negative and positive numbers  (weight = 6)  ----------------------------
 tb_din_a = 32'hfffffff9;
 tb_din_b = 32'h00000006;
 tb_alu_sel = 4'b0111;
 #20;
 if ((tb_alu_out == 32'h00000001))
 begin
    grade = grade + 3;
    point = point + 0.5;
    $display("[INFO]:: %t @Line %0d : SLT OPERATION PASSED", $time, `__LINE__);
    if ((zero == 1'b0))
      begin
        grade = grade + 3;
        point = point + 0.5;
       $display("[INFO]:: %t @Line %0d : SLT OPERATION ZERO FLAG PASSED", $time, `__LINE__);
      end  
      else $display("[ERROR]:: %t @Line %0d : SLT OPERATION ZERO FLAG FAILED", $time, `__LINE__);     
 end
 else begin
 $display("[ERROR]:: %t @Line %0d : SLT OPERATION FAILED", $time, `__LINE__);
 end
 #20;
 
 // ----------------------   NOR operation  with Zero Flag (weight = 4)  ----------------------------
 tb_din_a = 32'hE491C062;
 tb_din_b = 32'h5B7E7F9D;
 tb_alu_sel = 4'b1100;
 #20;
 if ((tb_alu_out == 32'h00000000))
   begin
    grade = grade + 2;
     point = point + 0.5;
     $display("[INFO]:: %t @Line %0d : NOR OPERATION PASSED", $time, `__LINE__);
      if ((zero == 1'b1))
      begin
        grade = grade + 2;
        point = point + 0.5;
       $display("[INFO]:: %t @Line %0d : NOR OPERATION ZERO FLAG PASSED", $time, `__LINE__);
      end 
      else  $display("[ERROR]:: %t @Line %0d : NOR OPERATION ZERO FLAG FAILED", $time, `__LINE__);      
  end
  else begin
 $display("[ERROR]:: %t @Line %0d : NOR OPERATION FAILED", $time, `__LINE__);
 end
 #20;
 
 // ----------------------   Equal Comparison operation (weight = 4) ----------------
 tb_din_a = 32'h00000001;
 tb_din_b = 32'h00000001;
 tb_alu_sel = 4'b1111;
 #20;
if ((tb_alu_out == 32'h00000001))
  begin
    grade = grade + 2;
     point = point + 0.5;
     $display("[INFO]:: %t @Line %0d : Equal Comp OPERATION PASSED", $time, `__LINE__);
      if ((zero == 1'b0))
      begin
        grade = grade + 2;
        point = point + 0.5;
       $display("[INFO]:: %t @Line %0d : Equal Comp OPERATION ZERO FLAG PASSED", $time, `__LINE__);
      end  
      else $display("[ERROR]:: %t @Line %0d : Equal Comp OPERATION ZERO FLAG FAILED", $time, `__LINE__);      
   end
   else begin
  $display("[ERROR]:: %t @Line %0d : Equal Comp OPERATION FAILED", $time, `__LINE__);
 end
 #20;
 
 // ---------------------------   finished operations ----------------------
   
 //$display( "The number of correct test cases are: %d, out of 9 " , point);
 $display( "The total grade of this student is: %d, out of 70 " , grade);

 $finish;
 
 end 
  
endmodule
