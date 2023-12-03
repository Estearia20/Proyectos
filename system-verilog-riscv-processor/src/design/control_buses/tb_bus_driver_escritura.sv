`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Module Name: tb_bus_driver_escritura
// Descripcion: Testebench para el módulo bus_driver_escritura
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////

module tb_bus_driver_escritura;
    logic [ 31 : 0 ] address_i; 
    logic            we_i;
    logic            we_ram_o;
    logic            we_teclado_o; 
    logic            we_led_o; 
    logic            we_7seg_o; 
    logic            we_timer_o; 
    logic            we_ctrl_uart_o; 
    logic            we_data__uart_o; 
    logic            we_ctrl_spi_o;

   
    bus_driver_escritura DUT(
        .address_i       (address_i), 
        .we_i            (we_i),
        .we_ram_o        (we_ram_o),
        .we_teclado_o    (we_teclado_o), 
        .we_led_o        (we_led_o), 
        .we_7seg_o       (we_7seg_o), 
        .we_timer_o      (we_timer_o), 
        .we_ctrl_uart_o  (we_ctrl_uart_o), 
        .we_data__uart_o (we_data__uart_o), 
        .we_ctrl_spi_o   (we_ctrl_spi_o));
        
        
    initial begin
        address_i = 'h0; 
        we_i      = 1;
        #10
        address_i = 'h1000;   //Se activa el write-enable de la RAM
        #10
        address_i = 'h2000;   //Se activa el write-enable del teclado
        #10
        address_i = 'h2008;   //Se activa el write-enable de los leds
        #10
        address_i = 'h200C;   //Se activa el write-enable de los displays
        #10
        address_i = 'h2010;   //Se activa el write-enable del timer
        #10
        address_i = 'h2020;   //Se activa el write-enable del registro de control del UART
        #10
        address_i = 'h2024;   //Se activa write-enable del registro de datos del UART
        #10
        address_i = 'h2100;   //Se activa el write-enable del registro de control del SPI
        #10
        $finish;                                                    
    end  

endmodule
