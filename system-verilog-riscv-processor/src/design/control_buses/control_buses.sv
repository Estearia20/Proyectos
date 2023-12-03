`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Module Name: control_buses
// Descripcion: Módulo top para el control de buses de datos 
//    
// Dependencias: bus_driver_escritura- bus_driver_lectura
// 
//////////////////////////////////////////////////////////////////////////////////


module control_buses(
    input   logic [ 31 : 0 ] address_i,         //Dirección de memoria proveniente del procesador
    input   logic            we_i,              //Write-enable proveniente del procesador
    input   logic [ 31 : 0 ] out_ram_i,         //Entrada de datos provenientes de la RAM
    input   logic [ 31 : 0 ] out_teclado_i,     //Entrada de datos provenientes del teclado
    input   logic [ 31 : 0 ] out_switch_i,      //Entrada de datos provenientes de los switches
    input   logic [ 31 : 0 ] out_bcd_i,         //Entrada de datos proviente del BCD
    input   logic [ 31 : 0 ] out_bcd_reversed_i,         //Entrada de datos proviente del BCD 
    input   logic [ 31 : 0 ] out_uart_i,        //
    input   logic [ 31 : 0 ] out_timer_i,       //Entrada de datos provenientes del timer
    input   logic [ 31 : 0 ] out_spic_i,        //Entrada proveniente del registro de control de spi
    input   logic [ 31 : 0 ] out_uartc_i,       //Entrada proveniente del registro de control del uart
    input   logic [ 31 : 0 ] out_rom_menu_i,    //Entrada proveniente de la ROM de periférico para imprimir el menú
    input   logic [ 31 : 0 ] out_spi_i,         //Entrada de datos provenientes del SPI    
    output  logic            we_ram_o,          //Write-enable para la RAM
    output  logic            we_teclado_o,      //Write-enable para escirbir en el periférico del teclado
    output  logic            we_led_o,          //Write-enable para escirbir en el periférico de leds
    output  logic            we_7seg_o,         //Write-enable para escirbir en el periférico del 7 segmentos
    output  logic            we_timer_o,        //Write-enable para escirbir en el periférico del timer
    output  logic            we_bcd_o,          //Write-enable para el BCD
    output  logic            we_bcd_reversed_o, //Write-enable para el BCD reversed
    output  logic            we_ctrl_uart_o,    //Write-enable para escirbir en el registro de control del uart
    output  logic            we_data_uart_o,    //Write-enable para escirbir en el registro de datos del uart
    output  logic            we_ctrl_spi_o,     //Write-enable para escirbir en el regsitro de control del spi
    output  logic [ 31 : 0 ] d_o);              //Salida de datos que va hacia el procesador

//Instancia del bus drives de escritura
    bus_driver_escritura escritura(
        .address_i         (address_i),        
        .we_i              (we_i),              
        .we_ram_o          (we_ram_o),          
        .we_teclado_o      (we_teclado_o),      
        .we_led_o          (we_led_o),          
        .we_7seg_o         (we_7seg_o),         
        .we_timer_o        (we_timer_o),        
        .we_ctrl_uart_o    (we_ctrl_uart_o),    
        .we_data__uart_o   (we_data_uart_o),
        .we_bcd_o          (we_bcd_o),
        .we_bcd_reversed_o (we_bcd_reversed_o),   
        .we_ctrl_spi_o     (we_ctrl_spi_o));    

//Instancia del bus drives de lectura
    bus_driver_lectura lectura(
        .address_i           (address_i),     
        .out_ram_i           (out_ram_i),      
        .out_teclado_i       (out_teclado_i), 
        .out_switch_i        (out_switch_i),  
        .out_uart_i          (out_uart_i),    
        .out_timer_i         (out_timer_i),   
        .out_spi_i           (out_spi_i),
        .out_rom_menu_i      (out_rom_menu_i),
        .out_uartc_i         (out_uartc_i),
        .out_spic_i          (out_spic_i),
        .out_bcd_i           (out_bcd_i),
        .out_bcd_reversed_i  (out_bcd_reversed_i),
        .d_o                 (d_o));          
    
endmodule
