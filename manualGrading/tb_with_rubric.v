`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Maryam S. Hosseini @UCIrvine
// 
// Create Date: 02/11/2020 08:04:30 PM
// Design Name: 
// Module Name: dp_tb_top
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


module dp_tb_top();

  /** Clock & reset **/
  reg clk, rst;
 // wire tb_Result;
  
  always begin
    #10;
    clk = ~clk;
  end

  initial begin
    clk = 0;
    @(posedge clk);
    rst = 1;
    @(posedge clk);
    rst = 0;        
  end

real point =0.0;
real grade=0.0;

  /** DUT Instantiation **/
  wire         reg_write  ;
  wire         mem2reg    ;
  wire         alu_src    ;
  wire         mem_write  ;
  wire         mem_read   ;
  wire  [3:0]  alu_cc     ;
  wire  [6:0]  opcode     ;
  wire  [6:0]  funct7     ;
  wire  [2:0]  funct3     ;
  wire [31:0]  alu_result ;

  data_path dp_inst(
    .clk        ( clk        ),
    .reset      ( rst        ),
    .reg_write  ( reg_write  ),
    .mem2reg    ( mem2reg    ),
    .alu_src    ( alu_src    ),
    .mem_write  ( mem_write  ),  
    .mem_read   ( mem_read   ),           
    .alu_cc     ( alu_cc     ),
    .opcode     ( opcode     ),
    .funct7     ( funct7     ),
    .funct3     ( funct3     ),
    .alu_result ( alu_result )
  );  

  /** Stimulus **/
  wire [6:0] R_TYPE, LW, SW, RTypeI;

  assign  R_TYPE = 7'b0110011;
  assign  LW     = 7'b0000011;
  assign  SW     = 7'b0100011;
  assign  RTypeI = 7'b0010011; //addi,ori,andi    


  assign alu_src   = (opcode==LW || opcode==SW || opcode == RTypeI);
  assign mem2reg   = (opcode==LW);
  assign reg_write = (opcode==R_TYPE || opcode==LW || opcode == RTypeI);
  assign mem_read  = (opcode==LW);
  assign mem_write = (opcode==SW);

  assign alu_cc = ((opcode==R_TYPE || opcode == RTypeI) && (funct7 == 7'b0000000) && (funct3 == 3'b000)) ? 4'b0010 : 
                  ((opcode==R_TYPE || opcode == RTypeI) && funct7 == 7'b0100000) ? 4'b0110 : 
                  ((opcode==R_TYPE || opcode == RTypeI) && (funct7 == 7'b0000000) && (funct3 == 3'b100)) ? 4'b1100 : 
                  ((opcode==R_TYPE || opcode == RTypeI) && (funct7 == 7'b0000000) && (funct3 == 3'b110)) ? 4'b0001 :
                  ((opcode==R_TYPE || opcode == RTypeI) && (funct7 == 7'b0000000) && (funct3 == 3'b111)) ? 4'b0000 :
                  ((opcode==R_TYPE || opcode == RTypeI) && (funct7 == 7'b0000000) && (funct3 == 3'b010)) ? 4'b0111 :  
                  ((opcode==R_TYPE || opcode == RTypeI) && (funct3 == 3'b100)) ? 4'b1100 : 
                  ((opcode==R_TYPE || opcode == RTypeI) && (funct3 == 3'b110)) ? 4'b0001 :
                  ((opcode==R_TYPE || opcode == RTypeI) && (funct3 == 3'b010)) ? 4'b0111 :
                  ((opcode==LW || opcode == SW) && (funct3 == 3'b010))? 4'b0010 : 0;
                  

initial 
begin
    #25;
    #20;
    if (alu_result == 32'h00000000) // and
    begin
        point = point + 1;
    end
    else  $display("[ERROR]:: %t @Line %0d : add instcrution doesn't work properly", $time, `__LINE__);
  // ------------------------------------------------------------------------------------------------------------  
    #20;
    if (alu_result == 32'h00000001) // addi
    begin
        point = point + 1;
    end
    else  $display("[ERROR]:: %t @Line %0d : first addi instcrution doesn't work properly", $time, `__LINE__);
  // ------------------------------------------------------------------------------------------------------------  
    #20;
    if (alu_result == 32'h00000002) // addi
    begin
        point = point + 1;
    end
    else  $display("[ERROR]:: %t @Line %0d : second addi instcrution doesn't work properly", $time, `__LINE__);
   // ------------------------------------------------------------------------------------------------------------- 
    #20;
    if (alu_result == 32'h00000004) // addi
    begin 
        point = point + 1;
    end
    else  $display("[ERROR]:: %t @Line %0d : third addi instcrution doesn't work properly", $time, `__LINE__);
    // ------------------------------------------------------------------------------------------------------------
    #20;
    if (alu_result == 32'h00000005) // addi
    begin
        point = point + 1;
    end
    else  $display("[ERROR]:: %t @Line %0d : 4th addi instcrution doesn't work properly", $time, `__LINE__);
    // -----------------------------------------------------------------------------------------------------------    
    #20;
    if (alu_result == 32'h00000007) // addi
    begin
        point = point + 1;
    end
    else  $display("[ERROR]:: %t @Line %0d : 5th addi instcrution doesn't work properly", $time, `__LINE__);
    //--------------------------------------------------------------------------------------------------------------
    #20;
    if (alu_result == 32'h00000008) //addi
    begin
        point = point + 1;
    end
    else  $display("[ERROR]:: %t @Line %0d : 6th addi instcrution doesn't work properly", $time, `__LINE__);
    // -------------------------------------------------------------------------------------------------------------
    # 20;
    if (alu_result == 32'h0000000b)// addi
    begin
        point = point + 1;
    end
    else  $display("[ERROR]:: %t @Line %0d : 7th addi instcrution doesn't work properly", $time, `__LINE__);
    // -----------------------------------------------------------------------------------------------------------
    # 20;
    if (alu_result == 32'h00000003) // add
    begin
       point = point + 1;
    end
    else  $display("[ERROR]:: %t @Line %0d : add instcrution doesn't work properly", $time, `__LINE__);
    // ----------------------------------------------------------------------------------------------------------
    # 20; 
    if (alu_result == 32'hfffffffe) // sub
    begin
       point = point + 1;
    end
    else  $display("[ERROR]:: %t @Line %0d : sub instcrution doesn't work properly", $time, `__LINE__);
    // -----------------------------------------------------------------------------------------------------------
    # 20;
    if (alu_result == 32'h00000000) // and 
    begin
        point = point + 1;
    end
    else  $display("[ERROR]:: %t @Line %0d : and instcrution doesn't work properly", $time, `__LINE__);
    // -----------------------------------------------------------------------------------------------------------
    # 20;
    if (alu_result == 32'h00000005) // or
    begin
        point = point + 1;
    end
    else $display("[ERROR]:: %t @Line %0d : or instcrution doesn't work properly", $time, `__LINE__);
    // ------------------------------------------------------------------------------------------------------------
    # 20;
    if (alu_result == 32'h00000001)// SLT
    begin
        point = point + 1;
    end
    else $display("[ERROR]:: %t @Line %0d : slt instcrution doesn't work properly", $time, `__LINE__);
    // -------------------------------------------------------------------------------------------------------------
    #20;
    if (alu_result == 32'hfffffff4) // NOR
    begin
        point = point + 1;
    end
    else  $display("[ERROR]:: %t @Line %0d : nor instcrution doesn't work properly", $time, `__LINE__);
    // ------------------------------------------------------------------------------------------------------------
    #20;
    if (alu_result == 32'h000004D2) // andi
    begin  
       point = point + 1;
    end
    else  $display("[ERROR]:: %t @Line %0d : andi instcrution doesn't work properly", $time, `__LINE__);
    // --------------------------------------------------------------------------------------------------------------
    #20;
    if (alu_result == 32'hfffff8d7) // ori
    begin
       point = point + 1;
    end
    else  $display("[ERROR]:: %t @Line %0d : ori instcrution doesn't work properly", $time, `__LINE__);
    // -------------------------------------------------------------------------------------------------------------
    #20;
    if (alu_result == 32'h00000001) // SLT
    begin
       point = point + 1;
    end
    else $display("[ERROR]:: %t @Line %0d : slt instcrution doesn't work properly", $time, `__LINE__);
    // ---------------------------------------------------------------------------------------------------------------
    # 20;
    if (alu_result == 32'hfffffb2c) // nori
    begin
        point = point + 1;
    end
    else  $display("[ERROR]:: %t @Line %0d : nori instcrution doesn't work properly", $time, `__LINE__);
    // ---------------------------------------------------------------------------------------------------------------------
    # 20;
    if ((alu_result == 32'h00000030) && (mem_write == 1'b1)) // sw
    begin
        point = point + 1;
    end
    else if ((mem_write != 1'b1))
     begin
        point = point + 0.5;
        $display("[ERROR]:: %t @Line %0d : store instcrution doesn't work properly", $time, `__LINE__);
     end
    // ------------------------------------------------------------------------------------------------------------------------
    # 20;
    if ((alu_result == 32'h00000030) && (mem_read == 1'b1)) // lw 
    begin
        point = point + 1;
    end
    else if (mem_read != 1'b1)
    begin
        point = point + 0.5;
        $display("[ERROR]:: %t @Line %0d : load instcrution doesn't work properly", $time, `__LINE__);
    end
    // ----------------------------------------------------------------------------------------------------------------------------
    $display("%s%d","The number of correct test cases is:" , point);
    grade = point * 3.0;
    $display("%s%d","Student grade is:" , grade);
    $finish;
end

  initial begin
   
    $monitor("%t opcode = %x , F7 = %x, F3 = %x", $time, opcode, funct7, funct3);
    #410;
  end 

endmodule
