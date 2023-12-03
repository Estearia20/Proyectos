`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Fecha de ultima modificacion: 16/9/2022 
// Module Name: reg_para_serie
// Descripcion: Registro de carga paralela y salida serie, ancho de 8 bits
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////

module reg_para_serie (
    input    logic                clk_i,        // clock de 10MHz
    input    logic                rst_i,        // reset general
    input    logic                we_i,         // write enable del registro
    input    logic                shift_i,      // señal shift del registro
    input    logic    [ 7 : 0 ]   in_i,         // entrada del registro
    output   logic                mosi_o);      // mosi de salida del SPI

    logic                 rst; 
    logic    [ 8 : 0 ]    estado;
    logic    [ 8 : 0 ]    siguiente_estado;
    
    assign rst = ~rst_i;                            // Mapea el reset de la FPGA al reset interno

//Se implementa el bloque para cambiar de estado
    always_ff @(posedge clk_i) begin
        if (!rst)  estado <= 8'b0;
        
        else       estado <= siguiente_estado;
    end

//Realiza la accion de corrimiento
    always_ff @(posedge clk_i) begin
        if (we_i == 1)     siguiente_estado <= {1'b0, in_i};

        else if (shift_i)  siguiente_estado <= {estado[ 7 : 0 ], 1'b0};
    end

//Asigna el mosi igual al bit que acaba de correr
    always_ff @(posedge clk_i) begin
        mosi_o <= estado[8];
    end
            
endmodule
