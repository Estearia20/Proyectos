`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Module Name: reg_teclado
// Descripcion: Registro para activar la comunicacion con el teclado
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////

module reg_teclado (
    input    logic                clk_i,       // Señal de reloj de 10MHz
    input    logic                reset_i,     // Señal de reset 
    input    logic    [ 31 : 0 ]  data_in1_i,  // Señal 1 de entrada de dato
    input    logic    [ 31 : 0 ]  data_in2_i,  // Señal 2 para entrada de dato
    input    logic                we_1_i,      // Señal de write enable 1 proveniente de bloque control de buses
    input    logic                we_2_i,      // Señal de write enable 2 proveniente del basic_ps2_keybord
    output   logic    [ 31 : 0 ]  rs1_o);      // Señal de salida de dato

    logic  rst;

    assign rst = ~reset_i;

// Se implementa la logica para el registro, escribe si tiene write enable
    always_ff @(posedge clk_i) begin        
        if      (!rst)    rs1_o   <= 0;
        
        if      (we_2_i)  rs1_o   <= data_in2_i;
        
        else if (we_1_i)  rs1_o   <= data_in1_i;
    end
    
endmodule
