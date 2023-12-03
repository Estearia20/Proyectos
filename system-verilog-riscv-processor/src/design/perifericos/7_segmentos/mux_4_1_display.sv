`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Fecha de ultima modificacion: 3/10/2022 
// Module Name: mux_4_1
// Descripcion: Multiplexor de 4 a 1
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////

module mux_4_1_display (                                 //Parametrización de entradas y salidas del MUX
    input logic  [3 : 0]     d0_i,               //Entradas del MUX
    input logic  [3 : 0]     d1_i,               
    input logic  [3 : 0]     d2_i,
    input logic  [3 : 0]     d3_i,
    input logic  [1 : 0]     sel_i,              //Bit de seleccion del MUX
    output logic [3 : 0]     y_o);               //Salida del MUX
    
    always @ (*) begin
        case (sel_i)                             //Se crea un case el cual hace el comportamiento del MUX
            2'h0    :  y_o = d0_i;               //Si el selector toma el valor de 00 , la salida del MUX es D0
            2'h1    :  y_o = d1_i;               //Si el selectot toma el valor de 01 , la salida del MUX es D1
            2'h2    :  y_o = d2_i;               //Si el selector toma el valor de 10 , la salida del MUX es D2
            2'h3    :  y_o = d3_i;               //Si el selector toma el valor de 11 , la salida del MUX es D3
            default :  y_o = 1'bx;               //Para el caso especial de si el selector es X o Z
        endcase
    end
    
endmodule
