`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Fecha de ultima modificacion: 
// Module Name: deco_ascii
// Descripcion: Decodifica el P2S proveniente del teclado a ascii en hexadecimal
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////

module deco_ascii (
    input    logic  [ 7  : 0 ]  dato_i,             // Entrada del deco 
    output   logic  [ 31 : 0 ]  dato_salida_o);     // Salida del deco 

    logic  [ 7 : 0 ]  dato_salida_8;
    
    always_comb begin
        case (dato_i)                                                 // Se implementa lógica del decodificador
            8'h5a    : dato_salida_8 = 8'h0d; //ENTER     
            8'h29    : dato_salida_8 = 8'h20; //ESPACIO   
            8'h76    : dato_salida_8 = 8'h1b; //ESC
            8'h05    : dato_salida_8 = 8'h05; //F1                    // Se pasa directo ya que no va a mostrarse en el putty
            8'h06    : dato_salida_8 = 8'h06; //F2                    // Se pasa directo ya que no va a mostrarse en el putty
            8'h04    : dato_salida_8 = 8'h04; //F3                    // Se pasa directo ya que no va a mostrarse en el putty
            8'h79    : dato_salida_8 = 8'h2b; //+   
            8'h7b    : dato_salida_8 = 8'h2d; //-   
            8'h7c    : dato_salida_8 = 8'h2a; //*   
            8'h1c    : dato_salida_8 = 8'h41; //A 
            8'h32    : dato_salida_8 = 8'h42; //B   
            8'h21    : dato_salida_8 = 8'h43; //C 
            8'h23    : dato_salida_8 = 8'h44; //D   
            8'h24    : dato_salida_8 = 8'h45; //E 
            8'h2b    : dato_salida_8 = 8'h46; //F   
            8'h34    : dato_salida_8 = 8'h47; //G 
            8'h33    : dato_salida_8 = 8'h48; //H   
            8'h43    : dato_salida_8 = 8'h49; //I 
            8'h3b    : dato_salida_8 = 8'h4a; //J   
            8'h42    : dato_salida_8 = 8'h4b; //K 
            8'h4b    : dato_salida_8 = 8'h4c; //L   
            8'h3a    : dato_salida_8 = 8'h4d; //M   
            8'h31    : dato_salida_8 = 8'h4e; //N   
            8'h44    : dato_salida_8 = 8'h4f; //O   
            8'h4d    : dato_salida_8 = 8'h50; //P   
            8'h15    : dato_salida_8 = 8'h51; //Q 
            8'h2d    : dato_salida_8 = 8'h52; //R   
            8'h1b    : dato_salida_8 = 8'h53; //S 
            8'h2c    : dato_salida_8 = 8'h54; //T   
            8'h3c    : dato_salida_8 = 8'h55; //U 
            8'h2a    : dato_salida_8 = 8'h56; //V   
            8'h1d    : dato_salida_8 = 8'h57; //W 
            8'h22    : dato_salida_8 = 8'h58; //X   
            8'h35    : dato_salida_8 = 8'h59; //Y 
            8'h1a    : dato_salida_8 = 8'h5a; //Z   
            8'h70    : dato_salida_8 = 8'h30; //0   
            8'h69    : dato_salida_8 = 8'h31; //1
            8'h72    : dato_salida_8 = 8'h32; //2   
            8'h7a    : dato_salida_8 = 8'h33; //3  
            8'h6b    : dato_salida_8 = 8'h34; //4   
            8'h73    : dato_salida_8 = 8'h35; //5
            8'h74    : dato_salida_8 = 8'h36; //6   
            8'h6c    : dato_salida_8 = 8'h37; //7
            8'h75    : dato_salida_8 = 8'h38; //8   
            8'h7d    : dato_salida_8 = 8'h39; //9
            default  : dato_salida_8 = 8'h0; // Este es el caso default 
        endcase                              
    end

// Concatena la salida a 32 bits
    assign dato_salida_o = {24'b0000_0000_0000_0000_0000_0000, dato_salida_8}; //Se envia el dato en 32 bits
    
endmodule
