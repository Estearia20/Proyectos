`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Module Name: mux21
// Descripcion: MUX 2 a 1
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////

module mux21 (
    input    logic [ 31 : 0 ]  d0_i,      // Primera entrada del MUX 2:1
    input    logic [ 31 : 0 ]  d1_i,      // Segunda entrada del MUX 2:1  
    input    logic             s_i,       // Selector del  MUX 2:1
    output   logic [ 31 : 0 ]  y_o);      // Salida del MUX 2:2
    
    assign    y_o = s_i ? d1_i : d0_i;    // Salida del MUX dependiendo del selector 
    
endmodule
