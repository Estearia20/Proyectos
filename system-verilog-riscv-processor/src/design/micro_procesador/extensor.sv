`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Module Name: extensor
// Descripcion: Sumador 
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////

module extensor(
    input    logic  [ 31 : 7 ]  instr_i,    // Señal de instrucción
    input    logic  [ 1  : 0 ]  immsrc_i,   // Señal que da formato a las instrucciones (ver tabla 3 del planteamiento)
    output   logic  [ 31 : 0 ]  immext_o);  // Señal de salida con el formato seleccionado
    
    always_comb
        case(immsrc_i)                      // Se implementa lógica del extensor
            // I-type
            2'b00: immext_o = {{20{instr_i[31]}}, instr_i[31:20]};
            
            // S-type (stores)
            2'b01: immext_o = {{20{instr_i[31]}}, instr_i[31:25], instr_i[11:7]};
            
            // B-type (branches)
            2'b10: immext_o = {{20{instr_i[31]}}, instr_i[7], instr_i[30:25], instr_i[11:8], 1'b0};
            
            // J-type (jal)
            2'b11: immext_o = {{12{instr_i[31]}}, instr_i[19:12], instr_i[20], instr_i[30:21], 1'b0};

            // undefined
            default: immext_o = 32'bx;
        endcase
    
endmodule

