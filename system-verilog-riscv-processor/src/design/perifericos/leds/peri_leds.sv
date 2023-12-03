`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Module Name: peri_leds
// Descripcion: Modulo para el periferico de los leds.
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////

module peri_leds (
    input   logic              clk_i,             // Señal de clk de la FPGA
    input   logic              reset_i,            // Señal de reset del sistema
    input   logic  [ 15 : 0 ]  data_in_i,            // Señal de reset del sistema
    input   logic              we_led_i,            // Señal de reset del sistema
    output  logic  [ 15 : 0 ]  leds_o);        // Salida del periferico de los leds
    
   
// Instancia del registro en donde se almacenan los valores de los leds
    reg_leds registro_leds (
        .clk_i                 (clk_i),                 
        .reset_i               (reset_i),               
        .data_in_i             (data_in_i),              
        .we_led_i              (we_led_i),                
        .salida_reg_leds_o     (leds_o));     

    
endmodule