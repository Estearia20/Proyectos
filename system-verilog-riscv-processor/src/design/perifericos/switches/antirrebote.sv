`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Fecha de ultima modificacion: 28/8/2022
// Nombre del módulo: antirrebote
// Descripción: Este es el módulo que quita los rebote.
//    
// Dependencias:
// 
//////////////////////////////////////////////////////////////////////////////////

module antirrebote(
    input  logic   clk_i,     // Clock de 10MHz
    input  logic   reset_i,   // Reset del sistema antirrebote
    input  logic   sw_i,      // Entrada a la que se le quiere quitar el rebote
    output logic   salida_o); // Dato de salida sin el rebote
    
    logic          rst;
    logic [8:0]    estado_cont;
    logic [8:0]    estado_cont_sig;
    logic          tick;
    
// Contador para los periodos de espera de la máqunia
    always_ff @(posedge clk_i) begin
        if (!rst) estado_cont   <= 'b0;
        
        else      estado_cont   <= estado_cont_sig;
    end
    
    assign rst             = ~ reset_i;
    assign estado_cont_sig =  estado_cont + 1'b1;
    assign tick            =  (estado_cont == 0) ? 1'b1 : 1'b0;
    
// Máquina de estados para eliminar rebotes
    typedef enum logic [2:0] {cero, espera0_1, espera0_2, espera0_3, uno, espera1_1, espera1_2, espera1_3} statetype;
    statetype estado, estado_sig;
    
// Se crea el bloque de memeria    
    always_ff @(posedge clk_i) begin
        if (!rst) estado <= cero;
        else      estado <= estado_sig;
    end
// Se implementa el diagrama de estados    
    always_comb begin
        estado_sig = estado;
        salida_o   = 0;
        
        case(estado)
            cero: if (sw_i)     estado_sig = espera0_1;
            
            espera0_1: begin
                if      (!sw_i) estado_sig = cero;
                else if (tick)  estado_sig = espera0_2;
            end
            
            espera0_2: begin
                if      (!sw_i) estado_sig = cero;
                else if (tick)  estado_sig = espera0_3;
            end
            
            espera0_3: begin
                if      (!sw_i) estado_sig = cero;
                else if (tick)  estado_sig = uno;
            end
            
            uno: begin
                salida_o                   = 1'b1;
                if (!sw_i)      estado_sig = espera1_1;
            end
            
            espera1_1: begin
                salida_o                   = 1'b1;
                if       (sw_i) estado_sig = uno;
                else if  (tick) estado_sig = espera1_2;
            end
            
            espera1_2: begin
                salida_o                   = 1'b1;
                if      (sw_i) estado_sig  = uno;
                else if (tick) estado_sig  = espera1_3;
            end
            
            espera1_3: begin
                salida_o                   = 1'b1;
                if      (sw_i) estado_sig  = uno;
                else if (tick) estado_sig  = cero;
            end
            
            default:           estado_sig  = cero;
        endcase
    end
endmodule
