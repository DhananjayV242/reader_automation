`timescale 1ns / 1ps

module ALU32Bit_tb;

reg [31:0] A_in;
reg [31:0] B_in;
reg [3:0] ALU_ctrl;
wire [31:0] ALU_out;
wire zero, overflow, carry_out;

// Instantiate the ALU
ALU_32 uut (
    .A_in(A_in),
    .B_in(B_in),
    .ALU_ctrl(ALU_ctrl),
    .ALU_out(ALU_out),
    .zero(zero),
    .overflow(overflow),
    .carry_out(carry_out)
);
initial begin
    $dumpfile("test.vcd");
    $dumpvars;
end

initial begin

    // Test Case 1
    A_in = 32'h086a0c31; B_in = 32'hd785f148; ALU_ctrl = 4'b0000;
    
    // Test Case 2
    #20 A_in = 32'h086a0c31; B_in = 32'h10073fd4; ALU_ctrl = 4'b0001;
    
    // Test Case 3
    #20 A_in = 32'ha86a0c31; B_in = 32'h90073fd4; ALU_ctrl = 4'b0010;

    // Test Case 4
    #20 A_in = 32'ha86a0c31; B_in = 32'h90073fd4; ALU_ctrl = 4'b0110;

    // Test Case 5
    #20 A_in = 32'ha86a0c31; B_in = 32'h90073fd4; ALU_ctrl = 4'b0111;
    

    // Test Case 6
    #20 A_in = 32'ha86a0c31; B_in = 32'h90073fd4; ALU_ctrl = 4'b1100;
    

    // Test Case 7
    #20 A_in = 32'ha86a0c31; B_in = 32'ha86a0c31; ALU_ctrl = 4'b1111;
    

    // Test Case 8
    #20 A_in = 32'ha86a0c31; B_in = 32'h10073fd4; ALU_ctrl = 4'b1111;
    
end

endmodule