`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Fecha de ultima modificacion: 16/9/2022 
// Module Name: demux_1_2
// Descripcion: Demultiplexor de 1 a 2
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////

module demux_1_2 (                               
    input logic      wr_i,             // entrada del demux
    input logic      reg_sel_i,        // selector del demux
    output logic     wr_ctrl,          // primera salida del demux
    output logic     wr_datos);        // segunda salida del demux

//Asigna el valor del wr segun la seleccion que recibe
    assign wr_ctrl  = reg_sel_i ? 1'b0 : wr_i;
    assign wr_datos = reg_sel_i ? wr_i : 1'b0;
    
endmodule
