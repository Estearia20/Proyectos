`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Module Name: tb_peri_proc
// Descripcion: Testbench para el periferico del UART
//    
// Dependencias: peri_uart.sv
// 
///////////////////////////////////////////////////////////////////////////////////


module tb_peri_uart;

    logic              clk_i;
    logic              reset_i;
    logic  [ 31 : 0 ]  data_i;
    logic              we_ctrl_uart_i;
    logic              we_data_uart_i;
    logic              uart_tx_o;
    logic  [  7 : 0 ]  dato_veri;
    logic  [  7 : 0 ]  dato_info;

// Instancia del periferico del UART
    peri_uart DUT(
        .clk_i                  (clk_i),
        .reset_i                (reset_i),
        .data_i                 (data_i),
        .we_ctrl_uart_i         (we_ctrl_uart_i),
        .we_data_uart_i         (we_data_uart_i),
        .uart_tx_o              (uart_tx_o));

// Genera la señal de clock
    always begin
        #5
        clk_i = ~clk_i;
    end    

// Se inicia la prueba del periférico UART
    initial
        begin
            reset_i        = 1;
            clk_i          = 0;
            data_i         = 0;
            dato_info      = 0;
            dato_veri      = 0;
            we_ctrl_uart_i = 0;
            we_data_uart_i = 0;
            #30;
            reset_i        = 0;
            #30;
            @(posedge clk_i);
            // Se agrega un dato para el reg de datos
            we_data_uart_i = 1;
            data_i         = 8'b0101_0101;
            dato_info      = data_i;
            @(posedge clk_i);
            we_data_uart_i = 0;
            @(posedge clk_i);
            // Se agrega un dato para el reg de control
            we_ctrl_uart_i = 1;
            data_i         = 8'b0000_0001;
            @(posedge clk_i);
            we_ctrl_uart_i = 0;
            @(posedge clk_i);
            #500;
        end
        
// Se realiza la autoverificacion
    initial begin
        #15200;
        dato_veri[0] = uart_tx_o;
        #10420;
        dato_veri[1] = uart_tx_o;
        #10420;
        dato_veri[2] = uart_tx_o;
        #10420;
        dato_veri[3] = uart_tx_o;
        #10420;
        dato_veri[4] = uart_tx_o;
        #10420;
        dato_veri[5] = uart_tx_o;
        #10420;
        dato_veri[6] = uart_tx_o;
        #10420;
        dato_veri[7] = uart_tx_o;
        #10420;
        if(dato_veri != dato_info) begin
            $display("%h %h ERROR", dato_veri, dato_info); 
        end
    end

endmodule

