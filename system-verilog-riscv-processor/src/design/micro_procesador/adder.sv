`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Module Name: adder
// Descripcion: Sumador 
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////

module adder (
    input    logic  [ 31 : 0 ]  a_i,     // Sumando a
    input    logic  [ 31 : 0 ]  b_i,     // Sumando b
    output   logic  [ 31 : 0 ]  y_o);    // Resultado de la suma

// Se realiza la operacion de suma
    assign     y_o = a_i + b_i;
    
endmodule