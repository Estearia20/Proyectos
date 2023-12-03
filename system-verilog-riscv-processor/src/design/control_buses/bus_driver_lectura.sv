`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Module Name: bus_driver_lectura
// Descripcion: Modulo para el bus de datos, que va hacia los perifericos
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////

module bus_driver_lectura(
    input   logic  [ 31 : 0 ]  address_i,         //Dirección en memoria proveninte del procesador
    input   logic  [ 31 : 0 ]  out_ram_i,         //Entrada de datos provenientes de la RAM
    input   logic  [ 31 : 0 ]  out_teclado_i,     //Entrada de datos provenientes del teclado
    input   logic  [ 31 : 0 ]  out_switch_i,      //Entrada de datos provenientes de los switches
    input   logic  [ 31 : 0 ]  out_uart_i,        //
    input   logic  [ 31 : 0 ]  out_bcd_i,         //Entrada de datos proviente del BCD
    input   logic  [ 31 : 0 ]  out_bcd_reversed_i,//Entrada de datos proviente del BCD 
    input   logic  [ 31 : 0 ]  out_timer_i,       //Entrada de datos provenientes del timer
    input   logic  [ 31 : 0 ]  out_spi_i,         //Entrada de datos provenientes del SPI
    input   logic  [ 31 : 0 ]  out_rom_menu_i,    //Entrada proveniente del la ROM de periférico para imprimir el menu
    input   logic  [ 31 : 0 ]  out_uartc_i,       //Entrada proveniente del registro de control del uart
    input   logic  [ 31 : 0 ]  out_spic_i,        //Entrada proveniente del registro de control de spi
    output  logic  [ 31 : 0 ]  d_o);              //Salida de datos que va hacia el procesador
    
    //Se implementa la lógica combinacional del bus drives de lectura
    always_comb begin
        if ((address_i >= 'h1000) && (address_i <= 'h13FC)) d_o = out_ram_i; //Si se cumple lee datos de la RAM
        
        else if (address_i == 'h2000) d_o = out_teclado_i; //Si se cumple lee datos del teclado
        
        else if (address_i == 'h2004) d_o = out_switch_i;  //Si se cumple lee datos de los switches 
               
        else if (address_i == 'h2024) d_o = out_uart_i;    //Si cumple lee registro de datos uart
        
        else if (address_i == 'h2010) d_o = out_timer_i;   //Si se cumple lee dato del timer
        
        else if (address_i == 'h2200) d_o = out_spi_i;     //Si se cumple lee datos del spi
        
        else if (address_i == 'h2014) d_o = out_bcd_i;
        
        else if (address_i == 'h2018) d_o = out_bcd_reversed_i;
        
        else if (address_i >= 'h3000) d_o = out_rom_menu_i; //Si cumple lee rom de periférico 
        
        else if (address_i == 'h2020) d_o = out_uartc_i;  //Si cumple lee registro de control uart
        
        else if (address_i == 'h2100) d_o = out_spic_i;   //Si cumple lee registro de control del spi
        
        else                          d_o = 0;
    end
    
endmodule
