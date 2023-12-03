`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Module Name: reg_ctrl_uart
// Descripcion: Registro de control para el UART
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////

module reg_ctrl_uart (
    input    logic    clk_i,      // Señal de reloj de 10MHz
    input    logic    reset_i,    // Señal de reset 
    input    logic    d_1_i,      // Señal 1 de entrada de dato
    input    logic    d_2_i,      // Señal 2 para entrada de dato, siempre es 0
    input    logic    we_1_i,     // Señal de write enable 1
    input    logic    we_2_i,     // Señal de write enable 2
    output   logic    q_o);       // Señal de salida de dato

    logic  rst;

    assign rst = ~reset_i;

// Se implementa la logica para el registro, escribe si tiene write enable
    always_ff @(posedge clk_i) begin        
        if      (!rst)    q_o <= 0;
        
        if      (we_2_i)  q_o <= d_2_i;
        
        else if (we_1_i)  q_o <= d_1_i;
    end
    
endmodule