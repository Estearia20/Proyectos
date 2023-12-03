`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Fecha de ultima modificacion: 16/9/2022 
// Module Name: control
// Descripcion: Maquina de estados necesaria para el funcionamiento del control e interfaz del SPI Maestro
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////

module control (
    input    logic             clk_i,           // clock de 10MHz
    input    logic             rst_i,           // reset general del sistema
    input    logic             send_i,          // bit de send del registro de control
    input    logic             fin_trans_i,     // señal de fin de transaccion del sistema
    input    logic             en_bit_i,        // salida del contador 7 - 0
    input    logic  [ 9 : 0 ]  cuenta_i,        // cuenta del contador de n tx end
    output   logic             hold_ctrl_o,     // hold control del registro de datos
    output   logic  [ 9 : 0 ]  addr2_o,         // address del registro de datos
    output   logic             en_cont_o,       // enable del divisor de frecuencia para el serial clock
    output   logic             in_ctrl_o,       // bit de enable para el registro de control
    output   logic             wr_data_o,       // write enable del registro de datos
    output   logic             wr_ctrl_o,       // write control del registro de control
    output   logic             rst_fin_o,       // reset de fin
    output   logic             we_out_o);       // write enable del registro paralelo serie

    logic   rst;
    logic   fin_trans_r;
    logic   fin_trans_rr;
    
    assign rst  = ~rst_i;

    always_ff @(posedge clk_i) begin
        fin_trans_r <= fin_trans_i;
    end
    
    always_ff @(posedge clk_i) begin
        fin_trans_rr <= fin_trans_r;
    end

//Se definen los estados
    typedef enum logic [ 3 : 0 ] {inicio, aguante1, aguante2, load, send_mosi, aguante3, aguante4, rcb_miso, intermedio, fin} statetype;
    statetype estado, estado_sig;
    
//Se crea el bloque de memoria
    always_ff @(posedge clk_i) begin
        if (!rst)  estado <= inicio;
        else       estado <= estado_sig;
    end

//Se implementa la maquina de estados
    always_comb begin
        hold_ctrl_o = 0;
        en_cont_o   = 0;
        addr2_o     = 0;
        in_ctrl_o   = 0;
        wr_data_o   = 0;
        wr_ctrl_o   = 0;
        we_out_o    = 0;
        rst_fin_o   = 0;

        case (estado)
//Estado inicial de la maquina, espera send = 1 para comenzar
            inicio: begin
                if (!send_i)  estado_sig = inicio;
                if (send_i)   estado_sig = aguante1;
            end
            
            aguante1: begin
                addr2_o     = cuenta_i;
                hold_ctrl_o = 1;
                
                estado_sig = aguante2;
            end
            
            aguante2: begin
                addr2_o     = cuenta_i;
                hold_ctrl_o = 1;
                
                estado_sig = load;
            end
            
//Carga el dato en un registro temporal, para despues ser enviado
            load: begin
                we_out_o    = 1;
                hold_ctrl_o = 1;
                addr2_o     = cuenta_i;

                estado_sig  = send_mosi;
            end

//Habilita señales para enviar por la mosi
            send_mosi: begin
                en_cont_o = 1;
                
                if (!en_bit_i)  estado_sig  = send_mosi;
                if (en_bit_i)   estado_sig  = aguante3;        
            end
            
            aguante3: begin
                addr2_o     = cuenta_i - 1;
                hold_ctrl_o = 1;
                
                estado_sig = aguante4;
            end
            
            aguante4: begin
                addr2_o     = cuenta_i - 1;
                hold_ctrl_o = 1;
                
                estado_sig = rcb_miso;
            end

//Recibe el miso y escribe en el registro de datos
            rcb_miso: begin
                hold_ctrl_o = 1;
                addr2_o     = cuenta_i - 1;
                wr_ctrl_o   = 1;
                wr_data_o   = 1;
                in_ctrl_o   = 1;
                en_cont_o   = 1;

                if (fin_trans_rr)  estado_sig = intermedio;
                else               estado_sig = inicio;
            end

            intermedio: begin
                rst_fin_o = 1;
                
                estado_sig = fin;
            end

//Escribe en el registro de control y vuelve a inicio
            fin: begin
                wr_ctrl_o  = 1;

                estado_sig = inicio;
            end

            default: estado_sig = inicio;
        endcase
    end
    
endmodule
