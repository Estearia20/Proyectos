`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Module Name: datapath
// Descripcion: Flujo de datos del sistema, en el se hacen las conexiones
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////

module datapath (
    input    logic              clk_i,            // Señal de clock del sistema
    input    logic              reset_i,          // Señal de reset del sistema
    input    logic              pc_src_i,         // Señal proveniente de módulo de control
    input    logic              alu_src_i,        // Señal proveniente de módulo de control
    input    logic              regwrite_i,       // Señal proveniente de módulo de control
    input    logic  [ 1  : 0 ]  resultsrc_i,      // Señal proveniente de módulo de control
    input    logic  [ 1  : 0 ]  immsrc_i,         // Señal proveniente de módulo de control
    input    logic  [ 2  : 0 ]  alucontrol_i,     // Señal proveniente de módulo de control
    input    logic  [ 31 : 0 ]  instr_i,          // Entrada de dirección de la ROM
    input    logic  [ 31 : 0 ]  readdata_i,       // Salida de datos de la RAM
    output   logic              zero_o,           // Bandera de cero de la ALU
    output   logic  [ 31 : 0 ]  pc_o,             // salida del program counter
    output   logic  [ 31 : 0 ]  aluresult_o,      // salida de la ALU
    output   logic  [ 31 : 0 ]  writedata_o);     // Segunda salida del banco de registros

    
    logic  [ 31 : 0 ]  pcnext;
    logic  [ 31 : 0 ]  pcplus4;
    logic  [ 31 : 0 ]  pctarget;
    logic  [ 31 : 0 ]  immext;
    logic  [ 31 : 0 ]  srca;
    logic  [ 31 : 0 ]  srcb;
    logic  [ 31 : 0 ]  result;
    
// Logica de siguiente estado para PC
    ffrst pcreg(
        .clk_i             (clk_i), 
        .reset_i           (reset_i), 
        .d_i               (pcnext), 
        .q_o               (pc_o));

// Sumador +4 del PC
    adder pcadd4(
        .a_i               (pc_o), 
        .b_i               (32'd4), 
        .y_o               (pcplus4));

// Sumador de pctarget
    adder pcaddbranch(
        .a_i               (pc_o), 
        .b_i               (immext), 
        .y_o               (pctarget));

// Multiplexor del PC
    mux21 pcmux(
        .d0_i              (pcplus4),
        .d1_i              (pctarget),
        .s_i               (pc_src_i),
        .y_o               (pcnext));
    
// Banco de registros del micro
    banco_reg rf(
        .clk_i             (clk_i),
        .we_i              (regwrite_i),
        .addr_rs1_i        (instr_i[19:15]),
        .addr_rs2_i        (instr_i[24:20]),
        .addr_rd_i         (instr_i[11:7]),
        .data_in_i         (result),
        .rs1_o             (srca),
        .rs2_o             (writedata_o),
        .rst_i             (reset_i));

// Bloque extensor de signo
    extensor ext(
        .instr_i           (instr_i[31:7]),
        .immsrc_i          (immsrc_i),
        .immext_o          (immext));
    
// Multiplexor para segunda entrada de ALU
    mux21 srcbmux(
        .d0_i              (writedata_o),
        .d1_i              (immext),
        .s_i               (alu_src_i),
        .y_o               (srcb));

// Instancia de la ALU
    alu aluu(
        .alu_a_i           (srca),
        .alu_b_i           (srcb),
        .alu_control_i     (alucontrol_i),
        .alu_resultado_o   (aluresult_o),
        .alu_flag0_o       (zero_o));

// Multiplexor de la salida del banco de memoria
    mux31 resultmux(
        .d0_i              (aluresult_o),
        .d1_i              (readdata_i),
        .d2_i              (pcplus4),
        .s_i               (resultsrc_i),
        .y_o               (result));
    
endmodule
