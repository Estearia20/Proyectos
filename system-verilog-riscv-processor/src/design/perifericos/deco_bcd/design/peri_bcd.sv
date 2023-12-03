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


module peri_bcd(
    input  logic            clk_i,
    input  logic            rst_i,
    input  logic            we_bcd_i,
    input  logic [ 31 : 0 ] data_i,
    output logic [ 31 : 0 ] salida_o);
    
    logic [ 31 : 0 ] entrada_deco;
    logic [ 23 : 0 ] salida_deco;

    deco_bcd deco_decimal (
        .rs2_i        (entrada_deco[19:0]),
        .cien_millar  (salida_deco[23:20]),
        .diez_millar  (salida_deco[19:16]),
        .millar       (salida_deco[15:12]),
        .centena      (salida_deco[11:8]),
        .decena       (salida_deco[7:4]),
        .unidad       (salida_deco[3:0]));

    reg_bcd reg_entrada (
        .clk_i    (clk_i),
        .rst_i    (rst_i),
        .we_i     (we_bcd_i),
        .data_i   (data_i),
        .salida_o (entrada_deco));
        
        
    reg_bcd reg_salida (
        .clk_i    (clk_i),
        .rst_i    (rst_i),
        .we_i     (1'b1),
        .data_i   ({8'b0,salida_deco}),
        .salida_o (salida_o));

endmodule
