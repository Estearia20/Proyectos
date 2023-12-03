`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Module Name: decomain
// Descripcion: Decodificador de instrucciones
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////

module decomain (
    input    logic  [ 6 : 0 ]  op_i,            // OPCODE de la instruccion
    output   logic  [ 1 : 0 ]  result_src_o,    // Selector del MUX 31
    output   logic             mem_write_o,     // Write enable de la MEMORIA
    output   logic             branch_o ,       // Señal para indicar branch
    output   logic             alu_src_o,       // Selector del source b de la ALU
    output   logic             reg_write_o,     // Write enable del banco de registros
    output   logic             jump_o,          // Señal para realizar jump
    output   logic  [ 1 : 0 ]  imm_src_o,       // Señal para indicar que hacer al extensor de signo
    output   logic  [ 1 : 0 ]  alu_op_o);       // Señal para indicar al deco de la ALU que hacer
 
    logic  [ 10 : 0 ]  controls;

// Se concatenan los resultados
    assign {reg_write_o, imm_src_o, alu_src_o, mem_write_o, 
            result_src_o, branch_o, alu_op_o, jump_o} = controls;

// Se implementa el codigo que debe mostrar la unidad de control segun la isntruccion que recibe
    always_comb
        case(op_i)
    // RegWrite_ImmSrc_ALUSrc_MemWrite_ResultSrc_Branch_ALUOp_Jump
            7'b0000011: controls = 11'b1_00_1_0_01_0_00_0; // lw
            7'b0100011: controls = 11'b0_01_1_1_00_0_00_0; // sw
            7'b0110011: controls = 11'b1_xx_0_0_00_0_10_0; // R–type
            7'b1100011: controls = 11'b0_10_0_0_00_1_01_0; // beq
            7'b0010011: controls = 11'b1_00_1_0_00_0_10_0; // I–type ALU
            7'b1101111: controls = 11'b1_11_0_0_10_0_00_1; // jal
        default:
            controls = 11'bx_xx_x_x_xx_x_xx_x; // ???
        endcase
    
endmodule