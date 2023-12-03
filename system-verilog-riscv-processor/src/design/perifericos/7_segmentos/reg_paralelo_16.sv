`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Fecha de ultima modificacion: 3/10/2022 
// Module Name: reg_paralelo_16
// Descripcion: Registro paralelo de 16 para almacenar los valor
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////

module reg_paralelo_16 (      
    input logic           clk_10MHz_i,   // Entrada de reloj de 10MHz
    input logic           we_i,          // Entrada de write-enable
    input logic  [15:0]   d_i,           // Entrada del registro
    output logic [15:0]   d_o);          // Salida del registro

// Implementación del registro de 16 bits    
    always_ff @(posedge clk_10MHz_i) begin
        if (we_i) begin
            d_o <= d_i;
        end 
    end
    
endmodule