`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.09.2022 21:29:34
// Design Name: 
// Module Name: deco_bcd
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


module deco_bcd_reversed (
    input   logic [3  : 0] cien_millar_i,
    input   logic [3  : 0] diez_millar_i,
    input   logic [3  : 0] millar_i,
    input   logic [3  : 0] centena_i,
    input   logic [3  : 0] decena_i,
    input   logic [3  : 0] unidad_i,
    output  logic [19 : 0] rs2_o);

    logic  [ 3 : 0 ]  cien_millar;
    logic  [ 3 : 0 ]  diez_millar;
    logic  [ 3 : 0 ]  millar;
    logic  [ 3 : 0 ]  centena;
    logic  [ 3 : 0 ]  decena;
    logic  [ 3 : 0 ]  unidad; 
    
    integer i;
    
    always_comb begin
    
        rs2_o       = 20'b0;
        cien_millar = cien_millar_i;
        diez_millar = diez_millar_i;
        millar      = millar_i;
        centena     = centena_i;
        decena      = decena_i;
        unidad      = unidad_i;
        

        for (i = 19; i >= 0; i = i - 1) begin
                
                rs2_o          = rs2_o >> 1'b1;
                rs2_o[19]      = unidad[0];
                unidad         = unidad >> 1'b1;
                unidad[3]      = decena[0];
                decena         = decena >> 1'b1;
                decena[3]      = centena[0];
                centena        = centena >> 1'b1;
                centena[3]     = millar[0];
                millar         = millar >> 1'b1;
                millar[3]      = diez_millar[0];
                diez_millar    = diez_millar >> 1'b1;
                diez_millar[3] = cien_millar[0];
                cien_millar    = cien_millar >> 1'b1;
                
                if (cien_millar >= 8) cien_millar = cien_millar - 3;
        
                if (diez_millar >= 8) diez_millar = diez_millar - 3;
        
                if (millar >= 8) millar = millar - 3;
                
                if (centena >= 8)   centena = centena - 3;
                
                if (decena >= 8)    decena  = decena - 3;
                
                if (unidad >= 8)    unidad  = unidad - 3;
        end
    end
    
endmodule
