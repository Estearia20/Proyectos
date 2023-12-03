`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Fecha de ultima modificacion: 3/10/2022 
// Module Name: deco_2_7
// Descripcion: Decodificador de 2 bits a 7 bits, para activar los displays 7 segmentos de la FPGA
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////

module deco_2_7 (
    input   logic  [ 1 : 0 ]  Q_i,    // Entrada del deco, preveniente del contador de 0-3 
    output  logic  [ 7 : 0 ]  an_o);  // Salida del deco para habilitar los displays 
    
//Se implementa la tabla de verdad para el deco de 2 - 7
    always_comb begin
        case (Q_i)                          
            2'b00    : an_o = 8'b1111_1110;  
            2'b01    : an_o = 8'b1111_1101; 
            2'b10    : an_o = 8'b1111_1011; 
            2'b11    : an_o = 8'b1111_0111; 
            default  : an_o = 8'b1111_1111;   
        endcase                              
    end
    
endmodule