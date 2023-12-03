`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Fecha de ultima modificacion: 16/9/2022 
// Module Name: interfaz_control
// Descripcion: Interconecta lo requerido para que la parte de control funcione
//    
// Dependencias: contador_7_0.sv, contador_n_tx_end.sv, control.sv, divisor_100kHz.sv, 
//               reg_para_serie.sv, reg_serie_para.sv, mux_4_1.sv
//////////////////////////////////////////////////////////////////////////////////

module interfaz_control (
    input    logic              clk_i,            // señal de 10MHz
    input    logic  [ 31 : 0 ]  out_ctrl_i,       // registro de control del SPI
    input    logic  [ 31 : 0 ]  out_dato_i,       // registro de datos del SPI
    input    logic              miso_i,           // señal miso del SPI
    input    logic              rst_i,            // reset general del SPI
    output   logic              hold_ctrl_o,      // señal hold control del registro de datos
    output   logic  [ 9 : 0 ]   addr2_o,          // señal de address del control hacia el registro de datos
    output   logic              wr2_data_o,       // write enable del control hacia el registro de datos
    output   logic  [ 31 : 0 ]  in2_data_o,       // entrada de datos del control hacia el registro de datos
    output   logic  [ 31 : 0 ]  in2_ctrl_o,       // entrada de datos del control hacia el registro de datos
    output   logic              wr2_ctrl_o,       // write enable del control hacia el registro de control
    output   logic              sclk_o,           // serial clock del SPI 
    output   logic              cs_o,             // señal chip select del SPI
    output   logic              mosi_o);          // señal mosi del SPI


    // señales intermedias necesarias del módulo de control
    logic  [ 7 : 0 ]  salida_mux;
    logic             salida_ntx;
    logic             salida_flanco_pos;
    logic             salida_flanco_neg;
    logic             salida_en_cont;
    logic             salida_we_out;
    logic             salida_enbit;
    logic  [ 9 : 0 ]  salida_cuenta;
    logic  [ 7 : 0 ]  in2_data_8;
    logic             reset_inter;
    logic             reset_fin;


    // se asignan las variables intermedias
    assign   reset_inter             = rst_i | reset_fin;
    assign   cs_o                    = ~ out_ctrl_i   [ 1 ];
    assign   in2_ctrl_o [ 31 : 26 ]  = out_ctrl_i     [ 31 : 26 ];
    assign   in2_ctrl_o [ 25 : 16 ]  = salida_cuenta;
    assign   in2_ctrl_o [ 15 : 1  ]  = out_ctrl_i     [ 15 : 1 ];
    assign   in2_data_o              = {24'b0, in2_data_8};
        
//Instancia del contador de 0 a 7
    contador_7_0 cont_7_0 (
        .clk_i        (clk_i),
        .rst_i        (reset_inter),
        .en_i         (salida_flanco_neg),
        .en_bit_o     (salida_enbit));

//Instancia del contador hasta n_tx
    contador_n_tx_end conta_ntx (
        .clk_i        (clk_i),
        .n_tx_end     (out_ctrl_i[ 12 : 4 ]),  
        .rst_i        (reset_inter),
        .en_i         (salida_enbit),
        .fin_trans    (salida_ntx),
        .out_o        (salida_cuenta));

//Instancia de la maquina de estados
    control ctrl (
        .clk_i        (clk_i),
        .rst_i        (rst_i),
        .send_i       (out_ctrl_i[ 0 ]),
        .fin_trans_i  (salida_ntx),
        .en_bit_i     (salida_enbit),
        .cuenta_i     (salida_cuenta),
        .hold_ctrl_o  (hold_ctrl_o),
        .addr2_o      (addr2_o),
        .en_cont_o    (salida_en_cont),
        .in_ctrl_o    (in2_ctrl_o[ 0 ]),
        .wr_data_o    (wr2_data_o),
        .wr_ctrl_o    (wr2_ctrl_o),
        .rst_fin_o    (reset_fin),
        .we_out_o     (salida_we_out));

//Instancia del divisor de frecuencia de 100kHz     
    divisor_100kHz divisor (                                
        .clk_i        (clk_i), 
        .en_i         (salida_en_cont),
        .rst_i        (rst_i),        
        .flanco_pos   (salida_flanco_pos),           
        .flanco_neg   (salida_flanco_neg),        
        .clk_100kHz_o (sclk_o));         

//Instancia del registro para enviar por la MOSI
    reg_para_serie reg_mosi (
        .clk_i        (clk_i),
        .rst_i        (rst_i),
        .we_i         (salida_we_out),
        .shift_i      (salida_flanco_pos),
        .in_i         (salida_mux),
        .mosi_o       (mosi_o));
    
//Instancia del registro para recibir del MISO
    reg_serie_para reg_miso (
        .clk_i        (clk_i),
        .miso_i       (miso_i),
        .shift_i      (salida_flanco_neg),
        .reset_i      (rst_i),
        .out_o        (in2_data_8));

//Instancia del MUX 4-1
    mux_4_1 mux_41 (                                
        .data_i       (out_dato_i[ 7 : 0 ]),    
        .all_0s_i     (out_ctrl_i[ 3 ]),
        .all_1s_i     (out_ctrl_i[ 2 ]),
        .y_o          (salida_mux));
    
endmodule