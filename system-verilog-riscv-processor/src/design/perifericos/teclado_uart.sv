`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Module Name: top_teclado_uart
// Descripcion: Modulo que interconecta el teclado y el UART
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////

module teclado_uart(
    input    logic            clk_i,
    input    logic            reset_i,
    input    logic            boton_we_ctrl_i, 
    input    logic            ps2_clk_i,
    input    logic            ps2_data_i,
    output   logic [ 7 : 0 ]  ps2_code,
    output   logic            uart_tx_o);

    logic                  clk;
    logic    [ 31 : 0 ]    teclado_uart;

// Instancia del PLL
    clk_gen reloj_10M (
        .clk_10MHz             (clk),
        .clk_in1               (clk_i));

// Instancia del UART    
    peri_uart uart (
        .clk_i                 (clk),
        .reset_i               (reset_i),
        .data_i                (teclado_uart),
        .we_ctrl_uart_i        (boton_we_ctrl_i),
        .we_data_uart_i        (1'b1),
        .uart_tx_o             (uart_tx_o));

// Instancia del teclado
    peri_teclado teclado (
        .clk_i                 (clk),
        .rst_i                 (reset_i),
        .we_teclado_i          (1'b0),
        .data_in_i             (32'h0000_0000),
        .ps2_reloj_i           (ps2_clk_i),
        .ps2_data_i            (ps2_data_i),
        .ps2_code              (ps2_code),
        .out_teclado_o         (teclado_uart));
    
endmodule
