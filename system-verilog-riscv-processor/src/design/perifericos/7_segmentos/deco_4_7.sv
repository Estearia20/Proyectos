`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Fecha de ultima modificacion: 3/10/2022 
// Module Name: deco_7seg
// Descripcion: Decodificador de 4 bits a display 7 segmentos 
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////


module deco_4_7 (
    input   logic  [3 : 0]       d_i,               // Entrada del deco proveniente del MUX
    output  logic  [6 : 0]       hex_number_o);     // Salida del deco el cual van a los diplays 
 
    always_comb begin
      case (d_i)                                    //Este case implementa la tabla de verdad 
            4'b0000  : hex_number_o = 7'b000_0001;  //del deco, aunque para que funcione en la
            4'b0001  : hex_number_o = 7'b100_1111;  //FPGA cada segmento es activo en bajo   
            4'b0010  : hex_number_o = 7'b001_0010;  //por lo que se niegan los resultados
            4'b0011  : hex_number_o = 7'b000_0110;  //obtenidos en la tabla de verdad
            4'b0100  : hex_number_o = 7'b100_1100;
            4'b0101  : hex_number_o = 7'b010_0100;
            4'b0110  : hex_number_o = 7'b010_0000;
            4'b0111  : hex_number_o = 7'b000_1111;
            4'b1000  : hex_number_o = 7'b000_0000;
            4'b1001  : hex_number_o = 7'b000_0100;
            4'b1010  : hex_number_o = 7'b000_1000;
            4'b1011  : hex_number_o = 7'b110_0000;
            4'b1100  : hex_number_o = 7'b011_0001;
            4'b1101  : hex_number_o = 7'b100_0010;
            4'b1110  : hex_number_o = 7'b011_0000;
            4'b1111  : hex_number_o = 7'b011_1000;
            default  : hex_number_o = 7'b111_1111;   //Este es el caso default, muestra  
        endcase                                      //una E rotada 180 grados horizontalmente
    end
    
endmodule