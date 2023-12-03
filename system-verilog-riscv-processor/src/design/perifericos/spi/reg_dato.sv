`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Fecha de ultima modificacion: 
// Nombre del módulo: reg_dato
// Descripción: Registro de 32 bits que se encarga de concatenar los datos del sensor de luminosidad
//    
// Dependencias:
// 
//////////////////////////////////////////////////////////////////////////////////

module reg_dato (
    input    logic              clk_i,          // reloj de 10MHz
    input    logic              we_sub_i,       // write enable del registro temporal de datos
    input    logic              we_gen_i,       // write enable general del registro de datos
    input    logic              selector_i,     // señal selectora para concatenar 2 registros en 1
    input    logic  [ 31 : 0 ]  data_i,         // entrada del registro
    input    logic              reset_i,        // reset general del registro
    output   logic  [ 7  : 0 ]  salida_o);      // salida con el dato concatenado del registro
    
    logic              rst;
    logic  [ 15 : 0 ]  inter_dato;

    assign rst = ~ reset_i;
    
    
    // definicion del funcionamiento del registro 
    always_ff @(posedge clk_i) begin
        if (!rst)                          inter_dato       <= 0;
   
        else if (!selector_i && we_sub_i)  inter_dato[15:8] <= data_i[7:0];

        else if (selector_i && we_sub_i)   inter_dato[7 :0] <= data_i[7:0];

        if (we_gen_i)                      salida_o         <= inter_dato[11:4];
    end
    
endmodule