`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Fecha de ultima modificacion: 16/9/2022 
// Module Name: contador_7_0
// Descripcion: Este es un contador decreciente de 7 hasta 0. 
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////

module contador_7_0 (
    input      logic             clk_i,         // clock de 10MHz
    input      logic             rst_i,         // reset general del sistema
    input      logic             en_i,          // enable del contador
    output     logic             en_bit_o);     // pulso de salida

    logic             rst;
    logic  [ 2 : 0 ]  out_o;
    
    assign rst = ~rst_i;

//Realiza el conteo de forma decreciente
    always_ff @(posedge clk_i) begin
        if (!rst) out_o   <= 3'b111;
        
        if (en_i) begin     
            out_o     <= out_o - 1;
            en_bit_o  <= 0;
            
            if  (out_o == 0) begin
                en_bit_o  <= 1;    
            end
        end
        
        else    en_bit_o <= 0;
    end
    
endmodule
