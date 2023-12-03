`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Module Name: alu
// Descripcion: Unidad Logica Aritmetica 
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////

module alu (                                        
    input    logic  [ 31 : 0 ]  alu_a_i,            // Se define la entrada de datos A
    input    logic  [ 31 : 0 ]  alu_b_i,            // Se define la entrada de datos B
    input    logic  [ 2  : 0 ]  alu_control_i,      // Se definen los selectores de la ALU
    output   logic  [ 31 : 0 ]  alu_resultado_o,    // Se define la salida de la ALU
    output   logic              alu_flag0_o);       // Se define la ALU dectora de ceros          

    localparam logic            alu_flag_i = 0;     // Se define la bandera ALUFlag
    logic                       cout_o;             // Se define el acarreo de salida
    logic           [ 32 : 0 ]  inter_r;            // Se define variable lógica para calculo intermedio de la suma
     
    
    always_comb begin
        case (alu_control_i)                // Se crea un case, el cual hace la funció del MUX 9:1 para la selección de las distintas operaciones
             
            3'b000 : begin                  // Si el selector es 000, se realiza la operación Suma en C2
                        inter_r         = alu_a_i + alu_b_i +alu_flag_i;
                        alu_resultado_o = inter_r[31:0];
                        cout_o          = inter_r[32];
                        alu_flag0_o     = ~|(alu_resultado_o);
            end             

            3'b001 : begin              // Si el selector es 001, se realiza la operación Resta en C2
                        inter_r         = alu_a_i - alu_b_i;
                        alu_resultado_o = inter_r[31:0];
                        cout_o          = inter_r[32];
                        alu_flag0_o     = ~|(alu_resultado_o);   
            end

             
             
            3'b010 : begin              // Si el selector es 010, se realiza la operación AND
                        alu_resultado_o = alu_a_i & alu_b_i;  
                        alu_flag0_o     = ~|(alu_resultado_o);
                        inter_r         = 0;
                        cout_o          = 0;
            end
                   
            3'b011 : begin              // Si el selector es 011, se realiza la operación OR 
                        alu_resultado_o = alu_a_i | alu_b_i;
                        alu_flag0_o     = ~|(alu_resultado_o);
                        inter_r         = 0;
                        cout_o          = 0;
            end
                   
            3'b101 : begin              // Si el selector es 101, se realiza la operación set less than 
                if (alu_a_i < alu_b_i) begin 
                    alu_resultado_o = 1;
                    inter_r         = 0;
                    cout_o          = 0;
                end
                else begin
                    alu_resultado_o = 0;
                    inter_r         = 0;
                    cout_o          = 0;
                end
            end

            3'b110 : begin              // Si el selector es 110, se realiza un sll
                alu_resultado_o = alu_a_i << alu_b_i;
            end

            3'b111 : begin              // Si el selector es 111, se realiza un srl
                alu_resultado_o = alu_a_i >> alu_b_i;
            end
 
            default : alu_resultado_o = 0;
        
        endcase
     end
endmodule