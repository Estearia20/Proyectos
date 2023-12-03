`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Module Name: reg_switches
// Descripcion: Registro en donde se almacenan los valores de los switches
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////

module reg_switches (
    input   logic              clk_i,    // Señal de clk del modulo (10MHz)
    input   logic  [ 15 : 0 ]  data_i,   // Dato de entrada
    output  logic  [ 31 : 0 ]  data_o);  // Dato de salida
    
    logic  [ 31 : 0 ]  data_i_32;
    
    assign data_i_32 = {16'b0, data_i};  // Toma el dato de entrada (16 bits) y lo expando a 32 bits
    
// Se implementa la logica de un registro, es un registro sin write enable
    always_ff @(posedge clk_i) begin
        data_o <= data_i_32;
    end
    
endmodule
