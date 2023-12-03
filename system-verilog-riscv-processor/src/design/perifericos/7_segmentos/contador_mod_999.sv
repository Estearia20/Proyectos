`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Fecha de ultima modificacion: 3/10/2022
// Module Name: contador_mod_999
// Descripcion: 
//    
// Dependencias: Módulo de un contador de 0-999 el cual reduce la frecuencia a 10kHz
// 
//////////////////////////////////////////////////////////////////////////////////

module contador_mod_999 (                                
    input     logic    clk_10MHz_i,              // Señal de clock de 10MHz
    input     logic    rst_i,                    // Reset manual para el contador
    output    logic    clk_10kHz_o);             // Señal de clock de 10kHz
    
    logic                     rst;               // Reset interno
    logic              [9:0]  cuenta;            // Valor de la cuenta que lleva el contador
    localparam logic   [9:0]  MOD = 'd999;       // Modulo del contador
    assign                    rst = ~ rst_i;     // Mapea el reset de la FPGA al reset interno

//Implementacion del contador para realizar la division de frecuencia hasta 10kHz
    always_ff @(posedge clk_10MHz_i) begin 
        if (!rst) begin
            cuenta       <= '0;
            clk_10kHz_o  <= '0;
        end 
      
        else begin
            if (cuenta == (MOD) / 2) begin
                cuenta <= 0;   
            end
            
            else
                cuenta <= cuenta + 1;
        end

        if (cuenta == 0) begin
            clk_10kHz_o <= ~ clk_10kHz_o;
        end
    end
endmodule