`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.10.2022 13:14:15
// Design Name: 
// Module Name: tb_deco_bcd
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


module tb_peri_bcd;


    logic        clk;
    logic        rst;
    logic        we;
    logic [31:0] data;
    logic [31:0] salida;

    peri_bcd DUT (
        .clk_i    (clk),
        .rst_i    (rst),
        .we_bcd_i   (we),
        .data_i   (data),
        .salida_o (salida));


    initial begin
        clk  = 0;
        rst  = 0;
        we   = 0;
        data = 0;

        #100;

        data = 32'd345231;
        we   = 1;
        #10;
        we   = 0;
        #25;
        
        if (salida != 32'h345231) $display("%t %h ERROR: Salida no es en formato bcd", $time, salida);
        
        #25;
        data = 32'd134214;
        we   = 1;
        #10;
        we   = 0;
        #25;
        
        if (salida != 32'h134214) $display("%t %h ERROR: Salida no es en formato bcd", $time, salida);
        
        #25;
        data = 32'd999999;
        we   = 1;
        #10;
        we   = 0;
        
        if (salida != 32'h999999) $display("%t %h ERROR: Salida no es en formato bcd", $time, salida);
    end

    always begin
        clk = ~clk;
        #5;
    end



endmodule