`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Module Name: mux31
// Descripcion: MUX 3 a 1
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////

module mux31 (
    input    logic  [ 31 : 0 ]  d0_i,                        // Primera entrada del MUX 3:1
    input    logic  [ 31 : 0 ]  d1_i,                        // Segunda entrada del MUX 3:1
    input    logic  [ 31 : 0 ]  d2_i,                        // Tercera entrada del MUX 3:1
    input    logic  [ 1  : 0 ]  s_i,                         // Selector del MUX 3:1
    output   logic  [ 31 : 0 ]  y_o);                        // Salida del MUX 3:1
    
    assign    y_o = s_i[1] ? d2_i : (s_i[0] ? d1_i : d0_i);  // Lógica para el funcionamiento del MUX dependiendo del valor del selector 
    
endmodule
