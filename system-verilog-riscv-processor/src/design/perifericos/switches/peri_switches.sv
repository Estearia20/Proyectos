`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Module Name: peri_switches
// Descripcion: Modulo para el periferico de los switches, este mapea los switches de la FPGA a un registro interno
//    
// Dependencias: reg_switches.sv, antirrebote.sv
// 
//////////////////////////////////////////////////////////////////////////////////

module peri_switches (
    input   logic              clk_i,              // Señal de clk de 10MHz
    input   logic              reset_i,            // Señal de reset del sistema
    input   logic  [ 15 : 0 ]  switches_i,         // Switches de la FPGA
    output  logic  [ 31 : 0 ]  switches_o);        // Salida del periferico de los switches
    
    logic  [ 15 : 0 ]  switches_sinrebotes;
        
// Instancia del registro en donde se almacenan los valores de los switches
    reg_switches registro_switches(
        .clk_i          (clk_i),                    // Señal de clk del modulo (10MHz)
        .data_i         (switches_i),               // Dato de entrada
        .data_o         (switches_o));              // Dato de salida
    
// A continuacion de generan 15 instancias del antirebote para cada uno de loos switches
// Instancia del anti rebotes
    antirrebote a0(
        .clk_i          (clk_i),                    // Clock de 10MHz
        .reset_i        (reset_i),                  // Reset del sistema antirrebote
        .sw_i           (switches_i[0]),            // Entrada a la que se le quiere quitar el rebote
        .salida_o       (switches_sinrebotes[0]));  // Dato de salida sin el rebote

// Instancia del anti rebotes
    antirrebote a1(
        .clk_i          (clk_i),                    // Clock de 10MHz
        .reset_i        (reset_i),                  // Reset del sistema antirrebote
        .sw_i           (switches_i[1]),            // Entrada a la que se le quiere quitar el rebote
        .salida_o       (switches_sinrebotes[1]));  // Dato de salida sin el rebote
        
 // Instancia del anti rebotes
    antirrebote a2(
        .clk_i          (clk_i),                    // Clock de 10MHz
        .reset_i        (reset_i),                  // Reset del sistema antirrebote
        .sw_i           (switches_i[2]),            // Entrada a la que se le quiere quitar el rebote
        .salida_o       (switches_sinrebotes[2]));  // Dato de salida sin el rebote
        
 // Instancia del anti rebotes
    antirrebote a3(
        .clk_i          (clk_i),                    // Clock de 10MHz
        .reset_i        (reset_i),                  // Reset del sistema antirrebote
        .sw_i           (switches_i[3]),            // Entrada a la que se le quiere quitar el rebote
        .salida_o       (switches_sinrebotes[3]));  // Dato de salida sin el rebote

// Instancia del anti rebotes
    antirrebote a4(
        .clk_i          (clk_i),                    // Clock de 10MHz
        .reset_i        (reset_i),                  // Reset del sistema antirrebote
        .sw_i           (switches_i[4]),            // Entrada a la que se le quiere quitar el rebote
        .salida_o       (switches_sinrebotes[4]));  // Dato de salida sin el rebote

// Instancia del anti rebotes
    antirrebote a5(
        .clk_i          (clk_i),                    // Clock de 10MHz
        .reset_i        (reset_i),                  // Reset del sistema antirrebote
        .sw_i           (switches_i[5]),            // Entrada a la que se le quiere quitar el rebote
        .salida_o       (switches_sinrebotes[5]));  // Dato de salida sin el rebote
        
 // Instancia del anti rebotes
    antirrebote a6(
        .clk_i          (clk_i),                    // Clock de 10MHz
        .reset_i        (reset_i),                  // Reset del sistema antirrebote
        .sw_i           (switches_i[6]),            // Entrada a la que se le quiere quitar el rebote
        .salida_o       (switches_sinrebotes[6]));  // Dato de salida sin el rebote
        
 // Instancia del anti rebotes
    antirrebote a7(
        .clk_i          (clk_i),                    // Clock de 10MHz
        .reset_i        (reset_i),                  // Reset del sistema antirrebote
        .sw_i           (switches_i[7]),            // Entrada a la que se le quiere quitar el rebote
        .salida_o       (switches_sinrebotes[7]));  // Dato de salida sin el rebote
        
// Instancia del anti rebotes
    antirrebote a8(
        .clk_i          (clk_i),                    // Clock de 10MHz
        .reset_i        (reset_i),                  // Reset del sistema antirrebote
        .sw_i           (switches_i[8]),            // Entrada a la que se le quiere quitar el rebote
        .salida_o       (switches_sinrebotes[8]));  // Dato de salida sin el rebote

// Instancia del anti rebotes
    antirrebote a9(
        .clk_i          (clk_i),                    // Clock de 10MHz
        .reset_i        (reset_i),                  // Reset del sistema antirrebote
        .sw_i           (switches_i[9]),            // Entrada a la que se le quiere quitar el rebote
        .salida_o       (switches_sinrebotes[9]));  // Dato de salida sin el rebote
        
 // Instancia del anti rebotes
    antirrebote a10(
        .clk_i          (clk_i),                    // Clock de 10MHz
        .reset_i        (reset_i),                  // Reset del sistema antirrebote
        .sw_i           (switches_i[10]),           // Entrada a la que se le quiere quitar el rebote
        .salida_o       (switches_sinrebotes[10])); // Dato de salida sin el rebote
        
 // Instancia del anti rebotes
    antirrebote a11(
        .clk_i          (clk_i),                    // Clock de 10MHz
        .reset_i        (reset_i),                  // Reset del sistema antirrebote
        .sw_i           (switches_i[11]),           // Entrada a la que se le quiere quitar el rebote
        .salida_o       (switches_sinrebotes[11])); // Dato de salida sin el rebote
        
// Instancia del anti rebotes
    antirrebote a12(
        .clk_i          (clk_i),                    // Clock de 10MHz
        .reset_i        (reset_i),                  // Reset del sistema antirrebote
        .sw_i           (switches_i[12]),           // Entrada a la que se le quiere quitar el rebote
        .salida_o       (switches_sinrebotes[12])); // Dato de salida sin el rebote
        
// Instancia del anti rebotes
    antirrebote a13(
        .clk_i          (clk_i),                    // Clock de 10MHz
        .reset_i        (reset_i),                  // Reset del sistema antirrebote
        .sw_i           (switches_i[13]),           // Entrada a la que se le quiere quitar el rebote
        .salida_o       (switches_sinrebotes[13])); // Dato de salida sin el rebote
        
// Instancia del anti rebotes
    antirrebote a14(
        .clk_i          (clk_i),                    // Clock de 10MHz
        .reset_i        (reset_i),                  // Reset del sistema antirrebote
        .sw_i           (switches_i[14]),           // Entrada a la que se le quiere quitar el rebote
        .salida_o       (switches_sinrebotes[14])); // Dato de salida sin el rebote
        
// Instancia del anti rebotes
    antirrebote a15(
        .clk_i          (clk_i),                    // Clock de 10MHz
        .reset_i        (reset_i),                  // Reset del sistema antirrebote
        .sw_i           (switches_i[15]),           // Entrada a la que se le quiere quitar el rebote
        .salida_o       (switches_sinrebotes[15])); // Dato de salida sin el rebote
                                                
endmodule
