`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Module Name: peri_timer
// Descripcion: Periferico de timer, cuanta hacia abajo segun el numero que se le cargue y se enclava en cero
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////


module peri_timer (
    input   logic              clk_i,       // Señal de reloj del sistema
    input   logic              rst_i,       // Señal de reset general
    input   logic [ 31 : 0 ]   data_i,      // Dato de entrada con la que se define el valor desde el que empieza a contar
    input   logic              load_i,      // Señal de load, da el inicio de la cuenta atras
    output  logic [ 31 : 0 ]   cuenta_o);   // Valor en el que se encuentra el contador
    
    logic rst;
    
    assign rst = ~rst_i;
    
    // Logica del contador
    always_ff @(posedge clk_i) begin
        if      (!rst)              cuenta_o <= 32'h0;
        
        else if (load_i)            cuenta_o <= (data_i << 16) + 16'hffff;
        
        else if (cuenta_o != 32'h0) cuenta_o <= cuenta_o - 1'b1;
    end
endmodule
