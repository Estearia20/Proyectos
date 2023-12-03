`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Fecha de ultima modificacion: 16/9/2022 
// Module Name: mux_4_1
// Descripcion: Multiplexor de 4 a 1, ancho de datos 8 bits
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////

module mux_4_1 (                                
    input    logic  [ 7 : 0 ]  data_i,      // entrada de datos
    input    logic             all_0s_i,    // señal all 0s del registro de control
    input    logic             all_1s_i,    // señal all 1s del registro de control
    output   logic  [ 7 : 0 ]  y_o);        // salida del mux

    logic  [ 1 : 0 ] sel_i;
    
    assign           sel_i = {all_1s_i, all_0s_i};
    
//Se implementa funcionamiento del MUX
    always_comb begin
        case (sel_i)              
            2'h0    :  y_o = data_i;
            2'h1    :  y_o = 8'b0;
            2'h2    :  y_o = 8'hFF;
            2'h3    :  y_o = 8'hFF;
            default :  y_o = 8'b0;
        endcase
    end
    
endmodule