`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Fecha de ultima modificacion: 3/10/2022
// Module Name: contador_mod_3
// Descripcion: Módulo de contador el cual cuenta desde 0 hasta 3
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////

module contador_mod_3 (                                      
    input     logic        rst_i,                //Reset manual para el contador
    input     logic        clk_10MHz_i,          //Señal de clock de 100MHz
    input     logic        en_i,                 // Enable del contador
    output    logic [1:0]  Q_o);                 //Valor actual del contador
        
    logic       rst;                             // Señal de reset interna
    logic [1:0] registro_en_r;                   // Arreglo para sincronizar el contador con el enable
    assign      rst = ~ rst_i;                   // Mapea el reset de la FPGA al reset interno
  
//Implementacion del contador para realizar la cuenta de 0-3
    always_ff@(posedge clk_10MHz_i) begin
        registro_en_r <= {registro_en_r[0], en_i};
    end
      
    always_ff @(posedge clk_10MHz_i) begin
        if (!rst) begin
            Q_o  <= '0;
        end 
      
        else begin
            if (registro_en_r == 2'b01) Q_o <=  Q_o + 1;
        end      
    end
endmodule