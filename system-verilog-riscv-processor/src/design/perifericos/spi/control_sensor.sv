`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Module Name: control_sensor
// Descripcion: Máquina de estados para la parte 3
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////

module control_sensor (
    input    logic    clk_i,              // reloj de 10MHz
    input    logic    btn_inicio_i,       // boton de inicio del sistema
    input    logic    fin_trans_i,        // señal de fin de transaccion
    input    logic    reset_i,            // reset general del sistema
    output   logic    selector_spi_o,     // selector para el reg sel del SPI
    output   logic    selector_reg_o,     // señal de seleccion del registro hacia el display 
    output   logic    we_reg_out_o,       // write enable del registro temporal hacia el display
    output   logic    we_spi_o,           // write enable del SPI
    output   logic    sendc_o,            // señal de send para el registro de control del SPI
    output   logic    csc_o,              // chip select del SPI
    output   logic    we_gen_o,           // write enable general del registro hacia el SPI
    output   logic    rst_ctrl_o,
    output   logic    addrc_o);           // address del SPI
    
    logic    rst;
    
    assign rst = ~ reset_i;

// Se definen los estados
    typedef enum logic [ 3 : 0 ] {inicio, rcb_data, espere_send, soli_data, soli_data2, espere_1c, espere_2c, soli_data3, we_gen_1} statetype;
    statetype estado, estado_sig;

// Se crea el bloque de memoria
    always_ff @(posedge clk_i) begin
        if (!rst)  estado <= inicio;
        else       estado <= estado_sig;
    end

// Se implementa la maquina de estados
    always_comb begin
        selector_spi_o  = 0;
        selector_reg_o  = 0;
        we_reg_out_o    = 0;
        we_spi_o        = 0;
        csc_o           = 0;
        sendc_o         = 0;
        addrc_o         = 0;
        rst_ctrl_o        = 0;
        
        case (estado)
            
// Estado inicial de la maquina, espera al btn_inicio_i = 1 para comenzar
            inicio: begin
                if (!btn_inicio_i)  estado_sig = inicio;

                else                estado_sig = rcb_data;
            end

// Estado en el que se solicita al SPI recibir informacion
            rcb_data: begin
                we_spi_o  = 1;
                csc_o     = 1;
                sendc_o   = 1;
                
                estado_sig = espere_send;
            end

// Espera a que el SPI termine las transacciones
            espere_send: begin
                if (fin_trans_i)  estado_sig = espere_send;

                else              estado_sig = soli_data;
            end

// Escribe el cs = 0, asi como el send = 0, para dejar de solicitar informacion
            soli_data: begin
                we_spi_o = 1;

                estado_sig = soli_data2;
            end

// Escribe en el registro de 32 bits, lo que contiene el addrc = 0 del registro de datos
            soli_data2: begin
                selector_spi_o = 1;
                we_reg_out_o   = 1;

                estado_sig = espere_1c;
            end
            
// Espera un ciclo de reloj
            espere_1c: begin
                addrc_o = 1;

                estado_sig = espere_2c;
            end

// Espera otro ciclo de reloj
            espere_2c: begin
                addrc_o = 1;

                estado_sig = soli_data3;
            end

// Escribe en el registro de 32 bits, lo que contiene el addrc = 1 del registro de datos, y mete un reset al contador de 1 seg
            soli_data3: begin
                selector_spi_o = 1;
                addrc_o        = 1;
                we_reg_out_o   = 1;
                selector_reg_o = 1;

                estado_sig = we_gen_1;
            end

            we_gen_1: begin
                we_gen_o = 1;
                rst_ctrl_o = 1;

                estado_sig = inicio;
            end
            
            default: estado_sig = inicio;
        endcase
    end
    
endmodule

