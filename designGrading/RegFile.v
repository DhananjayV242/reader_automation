`timescale 1ns / 1ps

module RegFile (
    input clk, reset, rg_wrt_en,
    input [4:0] rg_wrt_addr,
    input [4:0] rg_rd_addr1, rg_rd_addr2,
    input [31:0] rg_wrt_data,
    output reg [31:0] rg_rd_data1, rg_rd_data2
);
    reg [31:0] register_file [31:0]; // Array of registers
    
    integer i = 0;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 32; i = i + 1) begin
                register_file[i] <= 32'h00000000;
            end
        end else if (rg_wrt_en) begin
            register_file[rg_wrt_addr] <= rg_wrt_data;
        end
    end
    
    always @* begin
        rg_rd_data1 = register_file[rg_rd_addr1];
        rg_rd_data2 = register_file[rg_rd_addr2];
    end
    
endmodule
