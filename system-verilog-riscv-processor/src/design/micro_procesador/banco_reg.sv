`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Nombre del módulo: banco_reg
// Descripción: Este es el módulo que genera el banco de registros.
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////

module banco_reg (
    input    logic              clk_i,        // Clock del sistema
    input    logic              we_i,         // Write enable para escritura
    input    logic              rst_i,        // Reset del registro
    input    logic  [ 4  : 0 ]  addr_rs1_i,   // Address 1 del banco
    input    logic  [ 4  : 0 ]  addr_rs2_i,   // Address 2 del banco
    input    logic  [ 4  : 0 ]  addr_rd_i,    // Address de escritura del banco
    input    logic  [ 31 : 0 ]  data_in_i,    // Dato por escribir
    output   logic  [ 31 : 0 ]  rs1_o,        // Dato en address 1
    output   logic  [ 31 : 0 ]  rs2_o);       // Dato en address 2

    logic  [31:0][31:0]  mem;        // Matriz que genera el banco 32 x 32
    logic                rst;
    logic  [ 5 : 0 ]     i;          // Indice para el puntero que recorre el banco
    
    assign rst = ~rst_i;

// Recorre el registro escribiendo el valor en data_in_i
    always_ff @(posedge clk_i) begin
        if (!rst) begin
            for (i = 0; i <= 31; i = i + 1)
                mem[i] <= 'b0;
        end

        else if (we_i) mem[addr_rd_i] <= data_in_i;
    end

// Se asignan las salidas al valor que se encuentra en dicho address en memoria
    assign rs1_o = (addr_rs1_i != 0) ? mem[addr_rs1_i] : 0;
    assign rs2_o = (addr_rs2_i != 0) ? mem[addr_rs2_i] : 0;

endmodule