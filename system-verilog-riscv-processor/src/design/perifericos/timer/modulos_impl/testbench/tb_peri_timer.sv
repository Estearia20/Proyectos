`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Module Name: tb_peri_timer
// Descripcion: Modulo de testbench para el timer
//    
// Dependencias: peri_timer.sv
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_peri_timer;

    logic            clk;       // Señal de reloj
    logic            reset;     // Señal de reset general
    logic [ 31 : 0 ] datos;     // Entrada de datos, segun la cual cuenta
    logic            cargar;    // Señal que indica cuando empezar a contar
    logic [ 31 : 0 ] cuenta;    // Cuenta por la que va el contador


    peri_timer DUT(
        .clk_i    (clk),
        .rst_i    (reset),
        .data_i   (datos),
        .load_i   (cargar),
        .cuenta_o (cuenta));

    always begin
        #5
        clk = ~clk;
    end

    initial begin
        clk    = 0;
        reset  = 1;
        datos  = 0;
        cargar = 0;
        
        #20
        @(negedge clk);
        
        reset = 0;
        datos = 0;
        
        @(posedge clk);
        
        cargar  = 1;
        
        @(negedge clk);
        
        cargar = 0;
        
        @(cuenta == 0);
        #50;
        @(posedge clk);
        
        datos = 32'hffff;
        cargar = 1;
        
        @(posedge clk);
        
        cargar = 0;
        
        @(cuenta == 0);
        #40
        
        $finish;
    end
endmodule
