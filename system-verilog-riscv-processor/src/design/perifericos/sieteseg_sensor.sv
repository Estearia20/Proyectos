`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Module Name: sieteseg_sensor
// Descripcion: Modulo para interconectar el sensor con el 7 segmentos
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////

module sieteseg_sensor (
    input    logic             clk_pi,            // Señal de entrada del clock de 10MHz
    input    logic             reset_pi,          // Señal de reset del periférico
    input    logic             boton_pi,          
    input    logic             boton_7seg_pi,
    input    logic             miso_pi,
    output   logic             mosi_po,
    output   logic             sclk_po,
    output   logic             cs_po,
    output   logic  [ 6 : 0 ]  hex_number_po,
    output   logic  [ 7 : 0 ]  an_o);

    logic               clk;
    logic   [ 31 : 0 ]  salida_reg;

// Instancia del PLL
    clk_gen reloj_10M (
        .clk_10MHz             (clk),
        .clk_in1               (clk_pi));
    
// Instancia del periférico de 7 segmentos
    peri_7seg siete_seg (
        .rst_pi           (reset_pi),              // Reset del sistema
        .clk_i            (clk),                   // Clock de 10MHz
        .we_7seg          (boton_7seg_pi),         // Write enable proveniente del control de buses
        .d_i              (salida_reg [15:0]),     // Dato de entrada
        .an_o             (an_o),                  // Señal que habilita los displays
        .hex_number_po    (hex_number_po));        // Señal para habilitar los segmentos de los displays

// Instancia del perico del SPI y sensor
    peri_spi spi (
        .clk_pi           (clk),                   // reloj de 10MHz
        .boton_pi         (boton_pi),              // boton de inicio
        .reset_pi         (reset_pi),              // boton de reset general
        .miso_pi          (miso_pi),               // salida miso del SPI
        .sclk_po          (sclk_po),               // salida serial clock del SPI
        .mosi_po          (mosi_po),               // salida mosi del SPI
        .cs_po            (cs_po),                 // salida chip select del SPI
        .salida_reg       (salida_reg));
    
endmodule