`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Module Name: unicicloproc
// Descripcion: Procesador uniciclo
//    
// Dependencias: unidadcontrol.sv, datapath.sv
// 
//////////////////////////////////////////////////////////////////////////////////

module unicicloproc(
    input    logic              clk_i,             // Señal de reloj de 10MHz 
    input    logic              reset_i,           // Señal de reset
    input    logic  [ 31 : 0 ]  instr_i,           // Señal de instrucción
    input    logic  [ 31 : 0 ]  read_data_i,       // Señal de entrada de datos provenientes de la memoria
    output   logic  [ 31 : 0 ]  pc_o,              // Señal de pc
    output   logic              mem_write_o,       // Señal de write-enable de memoria
    output   logic  [ 31 : 0 ]  alu_result_o,      // Resultado de la ALU al realizar una operación
    output   logic  [ 31 : 0 ]  write_data_o);     // Señal de datos de salida que se escribe en memoria   
    
    logic             alu_src;
    logic             reg_write;
    logic             jump;
    logic             zero;
    logic             pc_src;
    logic  [ 1 : 0 ]  result_src;
    logic  [ 1 : 0 ]  imm_src;
    logic  [ 2 : 0 ]  alu_control;

// Instancia de la Unidad de Control
    unidadcontrol controlunit(
        .op_i             (instr_i[6:0]),
        .funct3_i         (instr_i[14:12]),
        .funct7b5_i       (instr_i[30]),
        .zero_i           (zero),
        .result_src_o     (result_src),
        .mem_write_o      (mem_write_o),
        .pc_src_o         (pc_src),
        .alu_src_o        (alu_src),
        .reg_write_o      (reg_write),
        .jump_o           (jump),
        .imm_src_o        (imm_src),
        .alu_control_o    (alu_control));


// Instancia del Datapath
    datapath datapath(
        .clk_i            (clk_i),
        .reset_i          (reset_i),
        .resultsrc_i      (result_src),
        .pc_src_i         (pc_src),
        .alu_src_i        (alu_src),
        .regwrite_i       (reg_write),
        .immsrc_i         (imm_src),
        .alucontrol_i     (alu_control),
        .zero_o           (zero),
        .pc_o             (pc_o),
        .instr_i          (instr_i),
        .aluresult_o      (alu_result_o),
        .writedata_o      (write_data_o),
        .readdata_i       (read_data_i));

endmodule
