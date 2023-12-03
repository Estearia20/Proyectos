`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Module Name: peri_spi
// Descripcion: Modulo top para el periferico del sensor y SPI
//    
// Dependencias: clk_gen.xci, contador_mod_10M.sv, control_7_seg.sv, reg_dato.sv, top_spi.sv, control.sv
//               
//////////////////////////////////////////////////////////////////////////////////

module peri_spi (
    input    logic              clk_i,          // reloj de 10MHz
    input    logic              boton_i,        // boton de inicio
    input    logic              reset_i,        // boton de reset general
    input    logic              miso_i,         // salida miso del SPI
    input    logic  [ 31 : 0 ]  data_i,
    output   logic              sclk_o,         // salida serial clock del SPI
    output   logic              mosi_o,         // salida mosi del SPI
    output   logic  [ 31 : 0 ]  salida_reg_o,   // salida del registro temporal de datos, lo que muestra el display
    output   logic  [ 31 : 0 ]  salida_ctrl_o,
    output   logic              cs_o);          // salida chip select del SPI
    

    logic              we_spi;          // write enable del SPI
    logic              we_reg_out;      // write enable de registro temporal de datos
    logic              we_gen;          // write enable general del registro de datos
    logic              selector_reg;    // selector para el registro temporal de datos, para cncatenar 2 registros en uno
    logic              fin_trans;       // señal que indica fin de transaccion del SPI
    logic  [ 31 : 0 ]  salida_spi;      // salida del SPI
    logic  [ 31 : 0 ]  entrada_spi;     // entrada del SPI
    logic              sendc;           // bit 0 de la entrada del SPI
    logic              csc;             // bit 1 de la entrada del SPI
    logic              selector_spi;    // entrada reg_sel del SPI
    logic              addrc;           // bit mas bajo del address del registro de datos del SPI
    logic  [  9 : 0 ]  addr_spi;        // address del registro de datos del SPI
    logic              rst_ctrl;
    
    
    // se asignan variables intermedidas necesarias para el sistema
    assign    fin_trans           = salida_spi[0];
    assign    entrada_spi[0]      = sendc;
    assign    entrada_spi[1]      = csc;
    assign    entrada_spi[4]      = 1'b1;
    assign    entrada_spi[3:2]    = 2'b00;
    assign    entrada_spi[31:5]   = 27'b0;
    assign    addr_spi[0]         = addrc;
    assign    addr_spi[9:1]       = 9'b0;
    assign    salida_reg_o[31:8]  = 24'b0000_0000_0000_0000_0000_0000;
    assign    salida_ctrl_o[31:1] = 31'b0;
    
// Instancia del registro de datos  
    reg_dato registro_datos (
        .clk_i             (clk_i),
        .we_sub_i          (we_reg_out),
        .we_gen_i          (we_gen),
        .selector_i        (selector_reg),
        .data_i            (salida_spi),
        .reset_i           (reset_i),
        .salida_o          (salida_reg_o[7:0]));

    reg_ctrl_uart ctrl_spi (
        .clk_i             (clk_i),              // Señal de reloj de 10MHz
        .reset_i           (reset_i),            // Señal de reset 
        .d_1_i             (data_i[0]),          // Señal 1 de entrada de dato
        .d_2_i             (1'b0),               // Señal 1 de entrada de 
        .we_1_i            (boton_i),            // Señal de write enable 1
        .we_2_i            (rst_ctrl),           // Señal de write enable 2
        .q_o               (salida_ctrl_o[0]));     // Señal de salida de dato

// Instancia al SPI   
    top_spi spi(
        .clk_pi            (clk_i),
        .reset_pi          (reset_i),
        .wr_pi             (we_spi),
        .reg_sel_pi        (selector_spi),
        .entrada_pi        (entrada_spi),
        .addr_in_pi        (addr_spi),
        .miso_pi           (miso_i),
        .salida_po         (salida_spi),
        .mosi_o            (mosi_o),
        .sclk_po           (sclk_o),
        .cs_po             (cs_o));
    
// Instancia al módulo de control 
    control_sensor control(                        
        .clk_i             (clk_i),
        .btn_inicio_i      (salida_ctrl_o[0]),
        .fin_trans_i       (fin_trans),
        .reset_i           (reset_i),
        .selector_spi_o    (selector_spi),
        .selector_reg_o    (selector_reg),
        .we_reg_out_o      (we_reg_out),
        .we_spi_o          (we_spi),
        .we_gen_o          (we_gen),
        .sendc_o           (sendc),
        .csc_o             (csc),
        .rst_ctrl_o        (rst_ctrl),
        .addrc_o           (addrc));
    
endmodule