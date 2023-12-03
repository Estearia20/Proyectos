`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Module Name: tb_control_buses
// Descripcion: Testebench para el módulo control_buses 
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_control_buses;
    logic [ 31 : 0 ] address_i;        
    logic            we_i;              
    logic [ 31 : 0 ] out_ram_i;         
    logic [ 31 : 0 ] out_teclado_i;     
    logic [ 31 : 0 ] out_switch_i;      
    logic [ 31 : 0 ] out_bcd_i;         
    logic [ 31 : 0 ] out_bcd_reversed_i;         
    logic [ 31 : 0 ] out_uart_i;        
    logic [ 31 : 0 ] out_timer_i;       
    logic [ 31 : 0 ] out_spic_i;        
    logic [ 31 : 0 ] out_uartc_i;       
    logic [ 31 : 0 ] out_rom_menu_i;    
    logic [ 31 : 0 ] out_spi_i;             
    logic            we_ram_o;          
    logic            we_teclado_o;      
    logic            we_led_o;          
    logic            we_7seg_o;         
    logic            we_timer_o;        
    logic            we_bcd_o;          
    logic            we_bcd_reversed_o; 
    logic            we_ctrl_uart_o;   
    logic            we_data_uart_o;    
    logic            we_ctrl_spi_o;     
    logic [ 31 : 0 ] d_o;              
    

    control_buses bus_driver(
        .address_i  (address_i),         
        .we_i (we_i),              
        .out_ram_i (out_ram_i),         
        .out_teclado_i (out_teclado_i),     
        .out_switch_i (out_switch_i),      
        .out_bcd_i (out_bcd_i),         
        .out_bcd_reversed_i (out_bcd_reversed_i),         
        .out_uart_i (out_uart_i),        
        .out_timer_i (out_timer_i),      
        .out_spic_i (out_spic_i),        
        .out_uartc_i (out_uartc_i),      
        .out_rom_menu_i(out_rom_menu_i),    
        .out_spi_i (out_spi_i),          
        .we_ram_o (we_ram_o),         
        .we_teclado_o (we_teclado_o),      
        .we_led_o (we_led_o),         
        .we_7seg_o (we_7seg_o),         
        .we_timer_o (we_timer_o),        
        .we_bcd_o (we_bcd_o),          
        .we_bcd_reversed_o (we_bcd_reversed_o), 
        .we_ctrl_uart_o (we_ctrl_uart_o),    
        .we_data_uart_o (we_data_uart_o),    
        .we_ctrl_spi_o (we_ctrl_spi_o),     
        .d_o (d_o));
        
    initial begin
        address_i          = 'h0;
        out_ram_i          = 'h385;   
        out_teclado_i      = 'h4A; 
        out_switch_i       = 'h39;
        out_uart_i         = 'h55;
        out_timer_i        = 'h4;
        out_spi_i          = 'hFF;
        out_bcd_i          = 'b0101_0110_1000;     
        out_bcd_reversed_i = 'd9642;                
        out_spic_i         = 'b1;
        out_uartc_i        = 'b0;
        out_rom_menu_i     = 'h6f;
   
        we_i          = 0;
        #10 
        //Se lee dato de la RAM
        address_i     = 'h1004;
        #10
        //Escribe en LEDS
        address_i     = 'h2008;
        we_i          = 1;
        #10
        //Se lee dato del sensor de luminosidad por medio del SPI
        address_i     = 'h2200;
         we_i          =0;
        #10
        //Escribe dato en 7 segmentos
        address_i     = 'h200C;
        we_i          = 1;
        #10
        //Se escribe dato en timer
        address_i    = 'h2010;
        we_i         = 1;
        //Se lee datos de los switches
        address_i    = 'h2004;
        we_i         = 0;
        $finish;
    end               
endmodule
