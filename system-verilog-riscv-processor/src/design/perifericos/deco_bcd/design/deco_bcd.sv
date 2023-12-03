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


module deco_bcd (
    input  logic [19 : 0] rs2_i,
    output logic [3  : 0] cien_millar,
    output logic [3  : 0] diez_millar,
    output logic [3  : 0] millar,
    output logic [3  : 0] centena,
    output logic [3  : 0] decena,
    output logic [3  : 0] unidad);

    integer i;
    
    always @(rs2_i) begin

        cien_millar = 4'd0;
        diez_millar = 4'd0;
        millar      = 4'd0;
        centena     = 4'd0;
        decena      = 4'd0;
        unidad      = 4'd0;
        
        for (i = 19; i >= 0; i = i - 1) begin
        
                if (cien_millar >= 5) cien_millar = cien_millar + 3;
        
                if (diez_millar >= 5) diez_millar = diez_millar + 3;
        
                if (millar >= 5) millar = millar + 3;
                
                if (centena >= 5)   centena = centena + 3;
                
                if (decena >= 5)    decena  = decena + 3;
                
                if (unidad >= 5)    unidad  = unidad + 3;
    
                cien_millar    = cien_millar << 1'b1;
                cien_millar[0] = diez_millar[3];
                diez_millar    = diez_millar << 1'b1;
                diez_millar[0] = millar[3];
                millar         = millar << 1'b1;
                millar[0]      = centena[3];
                centena        = centena << 1'b1;
                centena[0]     = decena[3];
                decena         = decena << 1'b1;
                decena[0]      = unidad[3];
                unidad         = unidad << 1'b1;
                unidad[0]      = rs2_i[i];    
        end
    end
    
endmodule
