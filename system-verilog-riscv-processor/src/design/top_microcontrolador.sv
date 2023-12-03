`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Module Name: top_microcontrolador
// Descripcion: Modulo top para el procesador
//    
// Dependencias: unicicloproc.sv
// 
//////////////////////////////////////////////////////////////////////////////////

module top_microcontrolador (
    input    logic              clk_pi,              // Señal de clock de 100MHz
    input    logic              reset_pi,            // Señal de entrada del reset 
    input    logic  [ 15 : 0 ]  switches_pi,         // Señal de entrada de los switches de la FPGA
    input    logic              ps2_clk_pi,          // CLK del bloque PS2
    input    logic              ps2_data_pi,         // Dato de entrada del PS2
    input    logic              miso_pi,             // salida miso del SPI
    output   logic              sclk_po,             // salida serial clock del SPI
    output   logic              mosi_po,             // salida mosi del SPI
    output   logic              cs_po,               // Salida chip select del SPI
    output   logic  [  6 : 0 ]  hex_number_po,       // Señal para habilitar los segmentos de los displays
    output   logic  [  7 : 0 ]  an_po,               // Señal que habilita los displays
    output   logic              uart_tx_po,          // Salida del UART
    output   logic  [ 15 : 0 ]  leds_po);            // Señal de salida de que va hacia los leds en la FPGA

    logic              clk_10M;
    logic  [ 31 : 0 ]  pc;              // Señal del PC
    logic  [ 31 : 0 ]  instr; 
    logic  [ 31 : 0 ]  read_data;
    logic  [ 31 : 0 ]  write_data;      // Señal de datos de salida 
    logic  [ 31 : 0 ]  data_adr;        // Señal de direcciones de memoria
    logic  [  7 : 0 ]  ps2_code;        // Datos de salida del PS2


//Logics para bus control de buses            
    logic  [ 31 : 0 ]  out_ram;
    logic  [ 31 : 0 ]  out_teclado;   
    logic  [ 31 : 0 ]  out_switch;  
    logic  [ 31 : 0 ]  out_uart;     
    logic  [ 31 : 0 ]  out_timer;    
    logic  [ 31 : 0 ]  out_spi;
    logic  [ 31 : 0 ]  out_rom_menu;
    logic  [ 31 : 0 ]  out_bcd;
    logic  [ 31 : 0 ]  out_bcd_reversed;
    logic  [ 31 : 0 ]  out_spic;
    logic  [ 31 : 0 ]  out_uartc;
    logic              mem_write;                
    logic              we_ram;
    logic              we_bcd;   
    logic              we_bcd_reversed;      
    logic              we_teclado;     
    logic              we_led;         
    logic              we_7seg;        
    logic              we_timer;      
    logic              we_ctrl_uart;   
    logic              we_data_uart;  
    logic              we_ctrl_spi; 
    
// Instancia del módulo que contiene la unidad de control y el datapath
    unicicloproc rvsingle(
        .clk_i           (clk_10M), 
        .reset_i         (reset_pi),
        .pc_o            (pc),
        .instr_i         (instr),
        .mem_write_o     (mem_write),
        .alu_result_o    (data_adr),
        .write_data_o    (write_data),
        .read_data_i     (read_data));

// Instancia del clk_pll
    clk_gen U1 (
        .clk_10MHz       (clk_10M),
        .clk_in1         (clk_pi));    

// Instancia de la RAM
    RAM RAAM (
        .clk             (clk_10M),
        .we              (we_ram),
        .a               (data_adr[9:2]),
        .d               (write_data),
        .spo             (out_ram));

// Instancia de la ROM    
    ROM ROOM (
        .a               (pc[10:2]),
        .spo             (instr));

// Instancia del control de buses
    control_buses driver (
        .address_i          (data_adr),
        .we_i               (mem_write),
        .out_ram_i          (out_ram),
        .out_teclado_i      (out_teclado),
        .out_switch_i       (out_switch),
        .out_uart_i         (out_uart),
        .out_timer_i        (out_timer),
        .out_bcd_i          (out_bcd),
        .out_bcd_reversed_i (out_bcd_reversed),
        .out_rom_menu_i     (out_rom_menu),
        .out_spi_i          (out_spi),
        .we_ram_o           (we_ram),
        .we_teclado_o       (we_teclado),
        .we_bcd_o           (we_bcd),
        .we_bcd_reversed_o  (we_bcd_reversed),
        .we_led_o           (we_led),
        .we_7seg_o          (we_7seg),
        .we_timer_o         (we_timer),
        .we_ctrl_uart_o     (we_ctrl_uart),
        .we_data_uart_o     (we_data_uart),
        .we_ctrl_spi_o      (we_ctrl_spi),
        .out_spic_i         (out_spic),
        .out_uartc_i        (out_uartc),
        .d_o                (read_data));

// Instancia del periferico de los LEDS
    peri_leds leds (
        .clk_i           (clk_10M),
        .reset_i         (reset_pi), 
        .data_in_i       (write_data [15:0]),
        .we_led_i        (we_led),
        .leds_o          (leds_po));

// Instancia del periferico de los switches    
    peri_switches switches (
        .clk_i           (clk_10M),
        .reset_i         (reset_pi),
        .switches_i      (switches_pi),
        .switches_o      (out_switch));
        
// Instancia del timer
    peri_timer timer (
        .clk_i           (clk_10M),
        .rst_i           (reset_pi),
        .data_i          (write_data),
        .load_i          (we_timer),
        .cuenta_o        (out_timer));

// Instancia del periferico del 7 segmentos
    peri_7seg sieteseg (
        .rst_i           (reset_pi),
        .clk_i           (clk_10M),
        .we_7seg_i       (we_7seg),
        .d_i             (write_data [15:0]),
        .an_o            (an_po),
        .hex_number_o    (hex_number_po));

// Instancia del sensor y SPI
    peri_spi spi (
        .clk_i           (clk_10M),
        .boton_i         (we_ctrl_spi),
        .reset_i         (reset_pi),
        .miso_i          (miso_pi),
        .data_i          (write_data),
        .sclk_o          (sclk_po),
        .mosi_o          (mosi_po),
        .cs_o            (cs_po),
        .salida_reg_o    (out_spi),
        .salida_ctrl_o   (out_spic));

// Instancia del teclado
    peri_teclado teclado (
        .clk_i           (clk_10M),
        .rst_i           (reset_pi),
        .we_teclado_i    (we_teclado),
        .data_in_i       (write_data),
        .ps2_reloj_i     (ps2_clk_pi),
        .ps2_data_i      (ps2_data_pi),
        .ps2_code        (ps2_code),
        .out_teclado_o   (out_teclado));

// Instancia del UART
    peri_uart uart (
        .clk_i           (clk_10M),
        .reset_i         (reset_pi),
        .data_i          (write_data),
        .we_ctrl_uart_i  (we_ctrl_uart),
        .we_data_uart_i  (we_data_uart),
        .uart_tx_o       (uart_tx_po),
        .data_out_ctrl_o (out_uartc));

// Instancia de la ROM periferico
    ROM_peri rom_menu (
        .a               (data_adr[8:2]),
        .spo             (out_rom_menu));

// Instancia del periferico para convertir a bcd
    peri_bcd bcd (
        .clk_i           (clk_10M),
        .rst_i           (reset_pi),
        .we_bcd_i        (we_bcd),
        .data_i          (write_data),
        .salida_o        (out_bcd));
        
// Instancia del periferico para convertir de bcd a binario
    peri_bcd_reversed bcd_reversed (
        .clk_i           (clk_10M),
        .rst_i           (reset_pi),
        .we_bcd_i        (we_bcd_reversed),
        .data_i          (write_data),
        .salida_o        (out_bcd_reversed));
    
endmodule