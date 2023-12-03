`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Module Name: tb_bus_driver_lectura
// Descripcion: Testebench para el módulo bus_driver_lectura 
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_bus_driver_lectura;

    logic [ 31 : 0 ] address_i;     
    logic [ 31 : 0 ] out_ram_i;     
    logic [ 31 : 0 ] out_teclado_i; 
    logic [ 31 : 0 ] out_switch_i;
    logic [ 31 : 0 ] out_uart_i;  
    logic [ 31 : 0 ] out_timer_i;   
    logic [ 31 : 0 ] out_spi_i;     
    logic [ 31 : 0 ] d_o;  


    bus_driver_lectura DUT(
        .address_i      (address_i),     
        .out_ram_i      (out_ram_i),     
        .out_teclado_i  (out_teclado_i), 
        .out_switch_i   (out_switch_i),  
        .out_uart_i     (out_uart_i),    
        .out_timer_i    (out_timer_i),   
        .out_spi_i      (out_spi_i),     
        .d_o            (d_o));          


    initial begin
        address_i     = 'h0;
        out_ram_i     = 'h385;   
        out_teclado_i = 'h4A; 
        out_switch_i  = 'h39;
        out_uart_i    = 'h55;
        out_timer_i   = 'h4;
        out_spi_i     = 'hFF;
        #10
        address_i     = 'h1004;   //Se lee el dato proveniente de la RAM
        #10
        address_i     = 'h2000;   //Se lee el dato proveniente del teclado
        #10
        address_i     = 'h2004;   //Se lee el dato proveniente de los switches
        #10        
        address_i     = 'h2024;   //Se lee el dato proveniente del UART
        #10
        address_i     = 'h2010;   //Se lee el dato proveniente del timer
        #10
        address_i     = 'h2200;   //Se lee el dato proveniente del SPI
        #10
        $finish;                
    end
  
endmodule
