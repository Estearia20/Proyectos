`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Module Name: peri_7seg
// Descripcion: Modulo top para el periferico de 7 segmentos
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////

module peri_7seg (
    input    logic              rst_i,             // Reset del sistema
    input    logic              clk_i,             // Clock de 10MHz
    input    logic              we_7seg_i,         // Write enable proveniente del control de buses
    input    logic  [ 15 : 0 ]  d_i,               // Dato de entrada
    output   logic  [  7 : 0 ]  an_o,              // Señal que habilita los displays
    output   logic  [  6 : 0 ]  hex_number_o);    // Señal para habilitar los segmentos de los displays


    logic  [  3 : 0 ]    y_o;
    logic  [  1 : 0 ]    Q_o;
    logic                clk_10kHz_o;
    logic  [ 15 : 0 ]    d_o;
    
// Instancia del contador de 0 a 1000
    contador_mod_999 contador_999 (                                 
        .clk_10MHz_i         (clk_i),           // Señal de clock de entrada de 10MHz
        .rst_i               (rst_i),           // Reset manual para el contador
        .clk_10kHz_o         (clk_10kHz_o));    // Señal de clock de salida de 10kHz

// Instancia del contador de 0 a 3
    contador_mod_3 contador_3 (                    
        .Q_o                 (Q_o),             // Valor Q del conteo realizado de 0-3
        .rst_i               (rst_i),           // Reset manual para el contador
        .clk_10MHz_i         (clk_i),           // Señal de clock de 10MHz como entrada del contador
        .en_i                (clk_10kHz_o));    // Señal de enable de 10kHz

// Instancia del deco 2 - 7
    deco_2_7 deco_habilita_displays (
        .Q_i                 (Q_o),             // Entrada del deco 2 a 7 el cual depende del valor Q del contador de 0-3
        .an_o                (an_o));           // Salida habilitadora de los enables

// Instancia del mux 4 - 1
    mux_4_1_display mux (                      
        .d0_i                (d_o[3:0]),        // Entrada d0 del MUX
        .d1_i                (d_o[7:4]),        // Entrada d1 del MUX
        .d2_i                (d_o[11:8]),       // Entrada d2 del MUX
        .d3_i                (d_o[15:12]),      // Entrada d3 del MUX
        .sel_i               (Q_o),             // Selector del MUX
        .y_o                 (y_o));            // Salida del MUX

// Instancia del deco 4 - 7
    deco_4_7 deco_displays (
        .d_i                 (y_o),             // Entrada de datos del deco 4-7 proveninte del MUX       
        .hex_number_o        (hex_number_o));  // Salida del deco 4-7 para mostrar un valor en displays

// Instancia del registro 16 bits
    reg_paralelo_16 reg_16 (
        .clk_10MHz_i         (clk_i),           // Entrada de clock de 10MHz del registro
        .we_i                (we_7seg_i),       // Entrada de write-enable
        .d_i                 (d_i),             // Entrada de datos del registro 
        .d_o                 (d_o));            // Salida del registro

endmodule