`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.10.2022 13:49:31
// Design Name: 
// Module Name: reg_bcd
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


module reg_bcd(
    input  logic             clk_i,
    input  logic             rst_i,
    input  logic             we_i,
    input  logic [ 31 : 0 ]  data_i,
    output logic [ 31 : 0 ]  salida_o);
    
    logic  rst;
    assign rst = ~rst_i;
    
    
    always_ff @(posedge clk_i) begin
        if      (!rst) salida_o <= 32'b0;
        
        else if (we_i) salida_o <= data_i;
    end
    
    
    
    
endmodule
