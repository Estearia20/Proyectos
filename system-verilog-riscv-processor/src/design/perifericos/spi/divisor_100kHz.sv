`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Fecha de ultima modificacion: 16/9/2022 
// Module Name: divisior_100kHz
// Descripcion: Este módulo es un divisor de frecuencia para generar una señal de 100k
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////

module divisor_100kHz (                                
    input     logic           clk_i,                 // Señal de clock de 10MHz
    input     logic           rst_i,                 // Reset manual para el contador
    input     logic           en_i,                  // Entrada de enable 
    output    logic           flanco_pos,            // Detector de flancos positivos   
    output    logic           flanco_neg,            // Detector de flancos negativos
    output    logic           clk_100kHz_o);         // Señal de clock de 100kHz
    
    logic                         rst;               // Reset interno
    logic              [ 6 : 0 ]  cuenta;            // Valor de la cuenta que lleva el contador
    logic              [ 1 : 0 ]  registro_en_r;     // Arreglo para sincronizar el contador con el enable   
    
    assign    rst = ~ rst_i;                         // Mapea el reset de la FPGA al reset interno

//Implementacion del contador para realizar la division de frecuencia hasta 100kHz
    always_ff @(posedge clk_i) begin 
        if (!rst) begin
            cuenta        <= '0;
            clk_100kHz_o  <= '0;
        end 
      
        else begin
            if (cuenta == 'd49) begin
                cuenta <= 0;   
            end
            
            else if (en_i)
                cuenta <= cuenta + 1;
        end

        if (cuenta == 1) begin
            clk_100kHz_o <= ~ clk_100kHz_o;
            
        end
    end

//Generacion de los pulsos positivos y negativos
    always_ff@(posedge clk_i) begin
        registro_en_r <= {registro_en_r[0], clk_100kHz_o};
    end    

    always_ff @(posedge clk_i) begin 
        if (registro_en_r == 2'b01) flanco_pos <= 1;
        else                        flanco_pos <= 0 ;

        if (registro_en_r == 2'b10) flanco_neg <= 1;
        else                        flanco_neg <= 0;
       
    end    
    
endmodule
