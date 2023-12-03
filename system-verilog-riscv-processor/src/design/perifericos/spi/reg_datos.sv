`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Fecha de ultima modificacion: 16/9/2022 
// Module Name: reg_datos
// Descripcion: Registro de datos para enviar instrucciones de datos al SPI
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////

module reg_datos (
    input    logic              clk_i,          // clock de 10MHz
    input    logic  [ 31 : 0 ]  in1_i,          // entrada de datos de fuera del SPI
    input    logic              wr1_i,          // write enable de fuera del SPI
    input    logic  [ 9  : 0 ]  addr1_i,        // address de fuera del SPI
    input    logic  [ 31 : 0 ]  in2_i,          // entrada de datos del registro del SPI
    input    logic              wr2_i,          // write enable del bloque de control
    input    logic  [ 9  : 0 ]  addr2_i,        // address del bloque de control
    input    logic              hold_ctrl_i,    // hold control del bloque de control
    output   logic  [ 31 : 0 ]  out_o);         // salida del registro

    logic   [ 7  : 0 ]  out_inter;
    logic               we;
    logic   [ 9  : 0 ]  addr;
    logic   [ 31 : 0 ]  in;
    
    assign  out_o = {24'b0, out_inter};

//Implementa el funcionamiento del registro de datos, wr_2 tiene prioridad
    assign we   = hold_ctrl_i ? wr2_i   : wr1_i;
    assign addr = hold_ctrl_i ? addr2_i : addr1_i;
    assign in   = hold_ctrl_i ? in2_i   : in1_i;
    
//Instancia de la memoria RAM
    blk_mem_gen RAM(
        .clka   (clk_i),
        .wea    (we),
        .addra  (addr),
        .dina   (in[7:0]),
        .douta  (out_inter));
    
endmodule
