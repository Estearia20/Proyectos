`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Module Name: decoalu
// Descripcion: Decodificador para que la ALU determine que operacion realizar
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////

module decoalu(
    input    logic             opb5_i,            // OPCODE bit 5
    input    logic  [ 2 : 0 ]  funct3_i,          // Valor de funct3 de la instruccion
    input    logic             funct7b5_i,        // Valor del bit 5 de funct7 de la instruccion
    input    logic  [ 1 : 0 ]  alu_op_i,          // Valor de ALUOP indicada por el deco principal
    output   logic  [ 2 : 0 ]  alu_control_o);    // Operacion que debe hacer el bloque de la ALU
    
    logic    r_type_sub;
    
    assign   r_type_sub = funct7b5_i & opb5_i; 

// Se implemeta logica del deco
    always_comb
        case(alu_op_i)
            2'b00:                  alu_control_o = 3'b000;   // suma
            2'b01:                  alu_control_o = 3'b001;   // resta
            default: case(funct3_i)                           // R-type / I-type ALU
                        3'b000: if (r_type_sub)
                                    alu_control_o = 3'b001;   // sub
                                else 
                                    alu_control_o = 3'b000;   // add, addi
                
                        3'b010:     alu_control_o = 3'b101;   // slt, slti
                        3'b110:     alu_control_o = 3'b011;   // or, ori
                        3'b111:     alu_control_o = 3'b010;   // and, andi
                        3'b001:     alu_control_o = 3'b110;   // sll
                        3'b101:     alu_control_o = 3'b111;   // slr
                        default:    alu_control_o = 3'bxxx;   // ???
                     endcase
        endcase
    
endmodule
