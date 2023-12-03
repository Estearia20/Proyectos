`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Fecha de ultima modificacion: 16/9/2022 
// Module Name: mux_salida
// Descripcion: Multiplexor de 2 a 1, con ancho de datos de 32 bits
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////

module mux_salida (                               
    input    logic  [ 31 : 0 ]     out_ctrl,          // primera entrada del mux   
    input    logic  [ 31 : 0 ]     out_datos,         // segunda entrada del mux
    input    logic                 reg_sel_i,         // selector del mux
    output   logic  [ 31 : 0 ]     salida_o);         // salida del mux

//Implementa el funcionamiento del mux
    assign salida_o = reg_sel_i ? out_datos : out_ctrl;
    
endmodule
