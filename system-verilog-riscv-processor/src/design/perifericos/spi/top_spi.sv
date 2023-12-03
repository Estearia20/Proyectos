`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Fecha de ultima modificacion: 16/9/2022 
// Module Name: top_spi
// Descripcion: Modulo top para el spi
//    
// Dependencias: clk_gen.xci, interfaz_control.sv, reg_ctrl.sv, reg_datos.sv, mux_salida.sv,
//               demux_1_2.sv
//////////////////////////////////////////////////////////////////////////////////


module top_spi (
    input    logic              clk_pi,          // clock de 10MHz
    input    logic              reset_pi,        // reset general del sistema
    input    logic              wr_pi,           // write enable del SPI
    input    logic              reg_sel_pi,      // señal reg sel del SPI
    input    logic  [ 31 : 0 ]  entrada_pi,      // entrada de datos del SPI
    input    logic  [ 9  : 0 ]  addr_in_pi,      // address del registro de datos del SPI
    input    logic              miso_pi,         // señal miso del SPI
    output   logic  [ 31 : 0 ]  salida_po,       // salida de datos del SPI
    output   logic              mosi_o,          // señal mosi del SPI
    output   logic              sclk_po,         // señal serial clock del SPI
    output   logic              cs_po);          // señal chip select del SPI


    // definicion de señales intermedias necesarias para el SPI
    logic              wr1_ctrl;
    logic              wr1_data;
    logic  [ 31 : 0 ]  out_ctrl;
    logic  [ 31 : 0 ]  out_dato;
    logic              wr2_ctrl;
    logic              wr2_dato;
    logic              hold_ctrl;
    logic  [ 31 : 0 ]  in2_ctrl;
    logic  [ 31 : 0 ]  in2_data;
    logic  [ 9  : 0 ]  addr2;
    
//Instancia de la interfaz de control para el SPI
    interfaz_control control(
        .clk_i         (clk_pi),   
        .out_ctrl_i    (out_ctrl),
        .out_dato_i    (out_dato),
        .miso_i        (miso_pi),
        .rst_i         (reset_pi),
        .hold_ctrl_o   (hold_ctrl), 
        .addr2_o       (addr2),
        .wr2_data_o    (wr2_dato),
        .in2_data_o    (in2_data),
        .in2_ctrl_o    (in2_ctrl),
        .wr2_ctrl_o    (wr2_ctrl),
        .sclk_o        (sclk_po),
        .cs_o          (cs_po),
        .mosi_o        (mosi_o));

//Instancia del registro de control
    reg_ctrl registro_ctrl(
        .clk_i         (clk_pi), 
        .in_1_i        (entrada_pi),
        .in_2_i        (in2_ctrl),
        .rst_i         (reset_pi),
        .wr_1_i        (wr1_ctrl),
        .wr_2_i        (wr2_ctrl),
        .out_ctrl_o    (out_ctrl));

//Instancia del registro de datos
    reg_datos registro_data(
        .clk_i         (clk_pi),
        .in1_i         (entrada_pi),
        .wr1_i         (wr1_data),
        .addr1_i       (addr_in_pi),
        .in2_i         (in2_data),
        .wr2_i         (wr2_dato),
        .addr2_i       (addr2),
        .hold_ctrl_i   (hold_ctrl),
        .out_o         (out_dato));

//Instancia del MUX 2 1
    mux_salida mux_sal (
        .out_ctrl      (out_ctrl),           
        .out_datos     (out_dato),
        .reg_sel_i     (reg_sel_pi),
        .salida_o      (salida_po));

//Instancia del DEMUX 1 2
    demux_1_2 demux (
        .wr_i          (wr_pi),             
        .reg_sel_i     (reg_sel_pi),
        .wr_ctrl       (wr1_ctrl),
        .wr_datos      (wr1_data));


endmodule
