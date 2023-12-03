`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Module Name: top_proc
// Descripcion: Modulo top para el procesador
//    
// Dependencias: unicicloproc.sv
// 
//////////////////////////////////////////////////////////////////////////////////

module top_proc(
    input    logic              clk_pi,             // Señal de clock de 100MHz
    input    logic              reset_pi,           // Señal de entrada del reset 
    output   logic  [ 31 : 0 ]  write_data_po,      // Señal de datos de salida 
    output   logic  [ 31 : 0 ]  data_adr_po,        // Señal de direcciones de memoria 
    output   logic              mem_write_po);      // Señal de we de memoria 


    logic              clk_10M;
    logic  [ 31 : 0 ]  pc;
    logic  [ 31 : 0 ]  instr;
    logic  [ 31 : 0 ]  read_data;
    
// Instancia del módulo que contiene la unidad de control y el datapath
    unicicloproc rvsingle(
        .clk_i           (clk_10M), 
        .reset_i         (reset_pi),
        .pc_o            (pc),
        .instr_i         (instr),
        .mem_write_o     (mem_write_po),
        .alu_result_o    (data_adr_po),
        .write_data_o    (write_data_po),
        .read_data_i     (read_data));

// Instancia del clk_pll
    clk_gen U1 (
        .clk_10MHz       (clk_10M),
        .clk_in1         (clk_pi));    

// Instancia de la RAM
    RAM RAAM (
        .clk             (clk_10M),           // input wire clka
        .we              (mem_write_po),      // input wire [0 : 0] wea
        .a               (data_adr_po[9:2]),  // input wire [7 : 0] addra
        .d               (write_data_po),     // input wire [31 : 0] dina
        .spo             (read_data));        // output wire [31 : 0] douta

// Instancia de la ROM    
    ROM ROOM (
        .a               (pc[10:2]),           // input wire [8 : 0] addra
        .spo             (instr));            // output wire [31 : 0] douta
  
endmodule
