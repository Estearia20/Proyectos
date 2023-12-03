`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Fecha de ultima modificacion: 16/9/2022 
// Module Name: reg_ctrl
// Descripcion: Registro de control para enviar instrucciones de control al SPI
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////

module reg_ctrl (
    input    logic                clk_i,        // clock de 10MHz
    input    logic    [ 31 : 0 ]  in_1_i,       // entrada de fuera del SPI
    input    logic    [ 31 : 0 ]  in_2_i,       // entrada del bloque de control
    input    logic                rst_i,        // reset general del sistema
    input    logic                wr_1_i,       // write de fuera del SPI
    input    logic                wr_2_i,       // write del bloque de control
    output   logic    [ 31 : 0 ]  out_ctrl_o);  // salida del registro de control
    
    logic    rst;
    assign   rst = ~ rst_i;                            // Mapea el reset de la FPGA al reset interno

//Implementa el funcionamiento del registro de control, wr_2 tiene prioridad
    always_ff @(posedge clk_i)
        if    (!rst)                 out_ctrl_o <= 32'b0;

        else if (wr_2_i)             out_ctrl_o <= in_2_i;

        else if (!wr_2_i && wr_1_i)  out_ctrl_o <= in_1_i;
        
endmodule
