`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Module Name: tb_top_proc
// Descripcion: Modulo top para el procesador
//    
// Dependencias: top_proc.sv
// 
//////////////////////////////////////////////////////////////////////////////////

module tb_top_proc;
    logic              clk;
    logic              reset;
    logic  [ 31 : 0 ]  write_data;
    logic  [ 31 : 0 ]  data_adr;
    logic              mem_write;
    
// Instancia del modulo top
    top_proc dut(
        .clk_pi             (clk),
        .reset_pi           (reset),
        .write_data_po      (write_data),
        .data_adr_po        (data_adr),
        .mem_write_po       (mem_write));
    
// Se inica el test
    initial
        begin
            reset = 1;
            clk   = 0;
            #3000;
            reset = 0;
        end
    
// Genera la señal de clock
    always begin
        #5
        clk = ~clk;
    end
/*   
// Autoverificación
    always @(negedge clk)
        begin
            if(mem_write) begin
                if(data_adr == 100 & mem_write == 25) begin
                    $display("Simulation succeeded");
                    $stop;
                end 
            
                else if (data_adr != 96) begin
                    $display("Simulation failed");
                    $stop;
                end
            end
        end
*/    
endmodule
