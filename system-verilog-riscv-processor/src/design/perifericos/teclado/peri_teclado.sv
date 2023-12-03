`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Module Name: peri_teclado
// Descripcion: Módulo que conecta todos los módulos necesarios para el funcionamiento del periférico del teclado 
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////

module peri_teclado (
    input    logic              clk_i,                // Señal de reloj de 10MHz
    input    logic              rst_i,                // Señal de entrada de reset
    input    logic              we_teclado_i,         // Señal write enable que habilita el registro del periférico
    input    logic  [ 31 : 0 ]  data_in_i,            // Señal de entrada desde el procesador
    input    logic              ps2_reloj_i,          // 
    input    logic              ps2_data_i,           // 
    output   logic  [  7 : 0 ]  ps2_code,             // Cambio para probar el teclado y el UART
    output   logic  [ 31 : 0 ]  out_teclado_o);       // Salida del periferico del teclado

    logic  [ 31 : 0 ]  salida_ascii_hex;
    logic              ps2_code_new;
    logic  [ 31 : 0 ]  ps2_largo;

// Instancia del deco_ascii
    deco_ascii ascii_hex(
        .dato_i                        (ps2_code),            // Dato de entrada del deco
        .dato_salida_o                 (salida_ascii_hex));   // Salida del PS2 en Ascii en hex  
    
// Instancia del registro de salida
    reg_teclado registro_teclado (
        .clk_i                         (clk_i),               // Señal de reloj de 10MHz
        .reset_i                       (rst_i),               // Señal de reset 
        .data_in1_i                    (data_in_i),            // Señal 1 de entrada de dato
        .data_in2_i                    (salida_ascii_hex),    // Señal 2 para entrada de dato
        .we_1_i                        (we_teclado_i),        // Señal de write enable 1 proveniente de bloque control de buses
        .we_2_i                        (ps2_code_new),        // Señal de write enable 2 proveniente del basic_ps2_keybord
        .rs1_o                         (out_teclado_o));      // Salida del periferico del teclado

// Instancia el basic_ps2_keyborad
    basic_ps2_keyboard teclado (
        .clk                           (clk_i),               // Señal de clock de 10MHz 
        .rst                           (!rst_i),              // Entrada de reset
        .ps2_clk                       (ps2_reloj_i),           
        .ps2_data                      (ps2_data_i),
        .long_keycodeout               (ps2_largo),           // Dato PS2 en 32 bits
        .ps2_code_new                  (ps2_code_new),        // Indicador de dato nuevo por el PS/2
        .ps2_code                      (ps2_code));           // Code proveniente del PS/2

endmodule
