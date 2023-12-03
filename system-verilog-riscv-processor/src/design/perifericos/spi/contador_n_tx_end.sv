`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Fecha de ultima modificacion: 16/9/2022 
// Module Name: contador_n_tx_end
// Descripcion: 
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////

module contador_n_tx_end (
    input      logic              clk_i,        // clock de 10MHz
    input      logic  [ 8 : 0 ]   n_tx_end,     // bits de n tx end del registro de control
    input      logic              rst_i,        // reset general del sistema
    input      logic              en_i,         // enable del contador
    output     logic              fin_trans,    // señal de fin de transaccion
    output     logic  [ 9 : 0 ]   out_o);       // salida del contador

    logic  rst;
    
    assign rst = ~rst_i;

//Implementa la cuenta hasta n_tx_end
    always_ff @(posedge clk_i) begin
        if (!rst) out_o <= 0;
        
        else begin
            if (en_i) begin
                out_o <= out_o + 1;
            end
        end
    end
    
    always_comb begin
        if  (out_o == n_tx_end + 'd1) fin_trans = 1;
        else                          fin_trans = 0;
    end
    
endmodule
