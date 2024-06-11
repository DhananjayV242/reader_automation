`timescale 1ns / 1ps

module InstMem(
    input [7:0] addr,
    output reg [31:0] instruction
);

    reg [31:0] memory [63:0]; // Declare memory as reg type
    
    initial begin
        memory[0] = 32'h00007033; // and r0,r0,r0
        memory[1] = 32'h00100093; // addi r1,r0,1
        memory[2] = 32'h00200113; // addi r2,r0,2
        memory[3] = 32'h00308193; // addi r3,r1,3
        memory[4] = 32'h00408213; // addi r4,r1,4
        memory[5] = 32'h00510293; // addi x5, x2, 5
        memory[6] = 32'h00610313; // addi x6, x2, 6
        memory[7] = 32'h00718393; // addi x7, x3, 7
        memory[8] = 32'h00208433; // add x8, x1, x2
        memory[9] = 32'h404404b3; // sub x9, x8, x4
        memory[10] = 32'h00317533; // and x10, x2, x3
        memory[11] = 32'h0041e5b3; // or x11, x3, x4
        memory[12] = 32'h0041a633; // if x3 is less than x4, then x12 = 1
        memory[13] = 32'h007346b3; // nor x13, x6, x7
        memory[14] = 32'h4d34f713; // andi x14, x9, 0x4D3
        memory[15] = 32'h8d35e793; // ori x15, x11, 0x8D3
        memory[16] = 32'h4d26a813; // if x13 is less than 0x4D2, then x16 = 1
        memory[17] = 32'h4d244893; // nori x17, x8, 0x4D2
    end
    
    always @* begin
        instruction = memory[addr]; // Read memory based on address
    end
    
endmodule
