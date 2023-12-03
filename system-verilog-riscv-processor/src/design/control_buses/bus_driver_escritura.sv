`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Module Name: bus_driver_escritura
// Descripcion: Modulo para el bus de datos, que viene de los perifericos
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////
module bus_driver_escritura(
    input   logic  [ 31 : 0 ]  address_i,         //Dirección de memoria proveniente del procesador
    input   logic              we_i,              //Write-enable proveniente del procesador
    output  logic              we_ram_o,          //Write-enable para la RAM
    output  logic              we_bcd_o,          //Write-enable para el BCD
    output  logic              we_bcd_reversed_o, //Write-enable para el BCD reversed
    output  logic              we_teclado_o,      //Write-enable para escirbir en el periférico del teclado
    output  logic              we_led_o,          //Write-enable para escirbir en el periférico de leds
    output  logic              we_7seg_o,         //Write-enable para escirbir en el periférico del 7 segmentos
    output  logic              we_timer_o,        //Write-enable para escirbir en el periférico del timer
    output  logic              we_ctrl_uart_o,    //Write-enable para escirbir en el registro de control del uart
    output  logic              we_data__uart_o,   //Write-enable para escirbir en el registro de datos del uart
    output  logic              we_ctrl_spi_o);    //Write-enable para escirbir en el regsitro de control del spi
    
//Se implementa la lógica combinacional del bus drives de escritura    
    always_comb begin
        if ((address_i >= 'h1000) && (address_i <= 'h13FC)) begin  //Si se cumple habilita escritura en RAM
            we_ram_o          = we_i;
            we_teclado_o      = 0; 
            we_led_o          = 0;
            we_7seg_o         = 0;
            we_timer_o        = 0;
            we_ctrl_uart_o    = 0; 
            we_data__uart_o   = 0; 
            we_ctrl_spi_o     = 0;    
            we_bcd_o          = 0;
            we_bcd_reversed_o = 0;       
        end
    
        else if (address_i == 'h2000) begin          //Si se cumple habilita escritura en teclado
            we_ram_o          = 0;
            we_teclado_o      = we_i; 
            we_led_o          = 0;
            we_7seg_o         = 0;
            we_timer_o        = 0;
            we_ctrl_uart_o    = 0; 
            we_data__uart_o   = 0; 
            we_ctrl_spi_o     = 0;  
            we_bcd_o          = 0;
            we_bcd_reversed_o = 0;      
        end
        
        else if (address_i == 'h2008) begin           //Si se cumple habilita escritura en LEDS
            we_ram_o          = 0;
            we_teclado_o      = 0; 
            we_led_o          = we_i;
            we_7seg_o         = 0;
            we_timer_o        = 0;
            we_ctrl_uart_o    = 0; 
            we_data__uart_o   = 0; 
            we_ctrl_spi_o     = 0;    
            we_bcd_o          = 0;
            we_bcd_reversed_o = 0;    
        end
        
        else if (address_i == 'h200C) begin           //Si se cumple habilita escritura en display
            we_ram_o          = 0;
            we_teclado_o      = 0; 
            we_led_o          = 0;
            we_7seg_o         = we_i;
            we_timer_o        = 0;
            we_ctrl_uart_o    = 0; 
            we_data__uart_o   = 0; 
            we_ctrl_spi_o     = 0;
            we_bcd_o          = 0;
            we_bcd_reversed_o = 0;        
        end
        
        else if (address_i == 'h2010) begin           //Si se cumple habilita escritura en timer
            we_ram_o          = 0;
            we_teclado_o      = 0; 
            we_led_o          = 0;
            we_7seg_o         = 0;
            we_timer_o        = we_i;
            we_ctrl_uart_o    = 0; 
            we_data__uart_o   = 0; 
            we_ctrl_spi_o     = 0;  
            we_bcd_o          = 0;
            we_bcd_reversed_o = 0;      
        end        

        else if (address_i == 'h2020) begin            //Si se cumple habilita escritura en registro control del uart  
            we_ram_o          = 0;
            we_teclado_o      = 0; 
            we_led_o          = 0;
            we_7seg_o         = 0;
            we_timer_o        = 0;
            we_ctrl_uart_o    = we_i; 
            we_data__uart_o   = 0; 
            we_ctrl_spi_o     = 0; 
            we_bcd_o          = 0;
            we_bcd_reversed_o = 0;       
        end
        
        else if (address_i == 'h2024) begin           //Si se cumple habilita escritura en registro de datos del uart     
            we_ram_o          = 0;
            we_teclado_o      = 0; 
            we_led_o          = 0;
            we_7seg_o         = 0;
            we_timer_o        = 0;
            we_ctrl_uart_o    = 0; 
            we_data__uart_o   = we_i; 
            we_ctrl_spi_o     = 0; 
            we_bcd_o          = 0;
            we_bcd_reversed_o = 0;       
        end
        
        else if (address_i == 'h2100) begin          //Si se cumple habilita escritura en registro control del spi  
            we_ram_o          = 0;
            we_teclado_o      = 0; 
            we_led_o          = 0;
            we_7seg_o         = 0;
            we_timer_o        = 0;
            we_ctrl_uart_o    = 0; 
            we_data__uart_o   = 0; 
            we_ctrl_spi_o     = we_i;
            we_bcd_o          = 0;
            we_bcd_reversed_o = 0;
         end
            
        else if (address_i == 'h2014) begin
            we_ram_o          = 0;
            we_teclado_o      = 0; 
            we_led_o          = 0;
            we_7seg_o         = 0;
            we_timer_o        = 0;
            we_ctrl_uart_o    = 0; 
            we_data__uart_o   = 0; 
            we_ctrl_spi_o     = 0;
            we_bcd_o          = we_i;
            we_bcd_reversed_o = 0;               
        end
        
        else if (address_i == 'h2018) begin
            we_ram_o            = 0;
            we_teclado_o        = 0; 
            we_led_o            = 0;
            we_7seg_o           = 0;
            we_timer_o          = 0;
            we_ctrl_uart_o      = 0; 
            we_data__uart_o     = 0; 
            we_ctrl_spi_o       = 0;
            we_bcd_o            = 0;      
            we_bcd_reversed_o   = we_i;           
        end
        
        else begin                                   
            we_ram_o          = 0;
            we_teclado_o      = 0; 
            we_led_o          = 0;
            we_7seg_o         = 0;
            we_timer_o        = 0;
            we_ctrl_uart_o    = 0; 
            we_data__uart_o   = 0; 
            we_ctrl_spi_o     = 0; 
            we_bcd_o          = 0;
            we_bcd_reversed_o = 0; 
        end                
    end
    
endmodule
