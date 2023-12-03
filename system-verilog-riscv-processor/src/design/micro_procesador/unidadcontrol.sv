`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Module Name: unidadcontrol
// Descripcion: Unidad de control del procesador
//    
// Dependencias: decomain.sv, decoalu.sv
// 
//////////////////////////////////////////////////////////////////////////////////

module unidadcontrol(
    input    logic  [ 6 : 0 ]  op_i,            // OPCode del micro
    input    logic  [ 2 : 0 ]  funct3_i,        // entrada funct3 de la instrucción
    input    logic             funct7b5_i,      // entrada funct7 de la instrucción
    input    logic             zero_i,          // bandera de cero de la ALU
    output   logic  [ 1 : 0 ]  result_src_o,    // selector del mux de salida de RAM
    output   logic             mem_write_o,     // we de la memoria
    output   logic             pc_src_o,        // selector del mux de PC
    output   logic             alu_src_o,       // selector del mux de la segunda entrada de la ALU
    output   logic             reg_write_o,     // we del banco de registros
    output   logic             jump_o,          // no utilizada
    output   logic  [ 1 : 0 ]  imm_src_o,       // selector del extensor de signo
    output   logic  [ 2 : 0 ]  alu_control_o);  // selector de la ALU

    
    logic  [ 1 : 0 ]  alu_op;
    logic             branch;

// Instancia del deco proncipal
    decomain decoprincipal(
        .op_i             (op_i),     
        .result_src_o     (result_src_o), 
        .mem_write_o      (mem_write_o), 
        .branch_o         (branch),
        .alu_src_o        (alu_src_o), 
        .reg_write_o      (reg_write_o), 
        .jump_o           (jump_o), 
        .imm_src_o        (imm_src_o), 
        .alu_op_o         (alu_op));

// Instancia del deco de la ALU
    decoalu aludec(
        .opb5_i           (op_i[5]), 
        .funct3_i         (funct3_i), 
        .funct7b5_i       (funct7b5_i), 
        .alu_op_i         (alu_op), 
        .alu_control_o    (alu_control_o));

    assign    pc_src_o = branch & zero_i | jump_o;
    
endmodule
