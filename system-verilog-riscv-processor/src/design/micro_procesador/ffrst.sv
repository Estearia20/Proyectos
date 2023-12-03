`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Module Name: ffrst
// Descripcion: Flip Flop con reset 
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////

module ffrst (
    input    logic              clk_i,      // Señal de reloj de 10MHz
    input    logic              reset_i,    // Señal de reset 
    input    logic  [ 31 : 0 ]  d_i,        // Señal de entrada de dato
    output   logic  [ 31 : 0 ]  q_o);       // Señal de salida de dato

    logic  rst;

    assign rst = ~reset_i;

// Se implenta lógica del FF con reset
    always_ff @(posedge clk_i) begin        
        if (!rst)    q_o <= 0;
        else         q_o <= d_i;
    end
    
endmodule
