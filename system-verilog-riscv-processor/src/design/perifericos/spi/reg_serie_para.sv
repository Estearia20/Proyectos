`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Fecha de ultima modificacion: 16/9/2022 
// Module Name: reg_serie_para
// Descripcion: Registro de entrada en serie y salida paralela
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////

module reg_serie_para (
    input    logic             clk_i,       // clock de 10MHz
    input    logic             miso_i,      // entrada miso del SPI
    input    logic             shift_i,     // señal de shift del registro
    input    logic             reset_i,     // reset del registro
    output   logic  [ 7 : 0 ]  out_o);      // salida del registro

    logic  rst;
    
    assign rst = ~reset_i;

//Se implementa el registro de corrimiento
    always_ff @(posedge clk_i) begin
        if (!rst)    out_o <= 8'b0;
        
        if (shift_i) out_o <= {out_o[6:0], miso_i};
    end
    
endmodule
