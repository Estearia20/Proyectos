`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Nombre del módulo: tb_deco_ascii
// Descripción: Este módulo es el testbench del módulo del DECO ASCII para el teclado.
//    
// Dependencias: deco_ascii.sv
// 
//////////////////////////////////////////////////////////////////////////////////

module tb_deco_ascii;
    logic  [ 7  : 0 ]  dato_i;            
    logic  [ 31 : 0 ]  dato_salida_o;    
    logic  [ 7  : 0 ]  dato_salida_8;
    logic              check;

    assign dato_salida_8 = dato_salida_o [7:0];

//Se genera instancia
    deco_ascii DUT(
        .dato_i         (dato_i),      
        .dato_salida_o  (dato_salida_o));     

//Define valores iniciales
    initial begin
        check = 0;
    end


    initial begin                            
        dato_i = 8'h5a; // ENTER
        #10
        check  = 1;
        #1
        check  = 0;
        #20
        dato_i = 8'h1c; // A
        #10
        check  = 1;
        #1
        check  = 0;
        #20
        dato_i = 8'h33; // H
        #10
        check  = 1;
        #1
        check  = 0;
        #20
        dato_i = 8'h6c; // 7
        #10
        check  = 1;
        #1
        check  = 0;
        #20
        $finish;
    end

// Se realiza la auto verificacion
    always @(posedge check) begin
        case (dato_i)

            8'h5a    :  begin
                            if (dato_salida_8 != 8'h0d) //ENTER
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end

            8'h29    :  begin
                            if (dato_salida_8 != 8'h20) //ESPACIO   
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end

            8'h76    :  begin
                            if (dato_salida_8 != 8'h1b) //ESC   
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end
                  
            8'h05    :  begin
                            if (dato_salida_8 != 8'h05) //F1 
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end
                  
            8'h06    :  begin
                            if (dato_salida_8 != 8'h06) //F2
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end
                  
            8'h04    :  begin
                            if (dato_salida_8 != 8'h04) //F3
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end
                  
            8'h79    :  begin
                            if (dato_salida_8 != 8'h2b) //+
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end

            8'h7b    :  begin
                            if (dato_salida_8 != 8'h2d) //-
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end

            8'h7c    :  begin
                            if (dato_salida_8 != 8'h2a) //*
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end
                  
            8'h1c    :  begin
                            if (dato_salida_8 != 8'h41) //A
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end

            8'h32    :  begin
                            if (dato_salida_8 != 8'h42) //B
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end
                  
            8'h21    :  begin
                            if (dato_salida_8 != 8'h43) //C
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end
                  
            8'h23    :  begin
                            if (dato_salida_8 != 8'h44) //D
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end
                  
            8'h24    :  begin
                            if (dato_salida_8 != 8'h45) //E
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end
                  
            8'h2b    :  begin
                            if (dato_salida_8 != 8'h46) //F
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end
                  
            8'h34    :  begin
                            if (dato_salida_8 != 8'h47) //G
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end
                  
            8'h33    :  begin
                            if (dato_salida_8 != 8'h48) //H
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end
                  
            8'h43    :  begin
                            if (dato_salida_8 != 8'h49) //I
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end
                  
            8'h3b    :  begin
                            if (dato_salida_8 != 8'h4a) //J
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end
                  
            8'h42    :  begin
                            if (dato_salida_8 != 8'h4b) //K
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end
                  
            8'h4b    :  begin
                            if (dato_salida_8 != 8'h4c) //L
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end
                  
            8'h3a    :  begin
                            if (dato_salida_8 != 8'h4d) //M
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end
                  
            8'h31    :  begin
                            if (dato_salida_8 != 8'h4e) //N
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end
                  
            8'h44    :  begin
                            if (dato_salida_8 != 8'h4f) //O
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end
                  
            8'h4d    :  begin
                            if (dato_salida_8 != 8'h50) //P
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end
                  
            8'h15    :  begin
                            if (dato_salida_8 != 8'h51) //Q
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end
                  
            8'h2d    :  begin
                            if (dato_salida_8 != 8'h52) //R
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end
                  
            8'h1b    :  begin
                            if (dato_salida_8 != 8'h53) //S
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end
                  
            8'h2c    :  begin
                            if (dato_salida_8 != 8'h54) //T
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end
                  
            8'h3c    :  begin
                            if (dato_salida_8 != 8'h55) //U
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end
                  
            8'h2a    :  begin
                            if (dato_salida_8 != 8'h56) //V
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end
                  
            8'h1d    :  begin
                            if (dato_salida_8 != 8'h57) //W
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end
                  
            8'h22    :  begin
                            if (dato_salida_8 != 8'h58) //X
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end
                    
            8'h35    :  begin
                            if (dato_salida_8 != 8'h59) //Y
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end
                  
            8'h1a    :  begin
                            if (dato_salida_8 != 8'h5a) //Z
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end
                  
            8'h70    :  begin
                            if (dato_salida_8 != 8'h30) //0
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end
                  
            8'h69    :  begin
                            if (dato_salida_8 != 8'h31) //1
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end

            8'h72    :  begin
                            if (dato_salida_8 != 8'h32) //2
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end
                  
            8'h7a    :  begin
                            if (dato_salida_8 != 8'h33) //3
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end
                  
            8'h6b    :  begin
                            if (dato_salida_8 != 8'h34) //4
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end  
                  
            8'h73    :  begin
                            if (dato_salida_8 != 8'h35) //5
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end 
                  
            8'h74    :  begin
                            if (dato_salida_8 != 8'h36) //6
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end 
                  
            8'h6c    :  begin
                            if (dato_salida_8 != 8'h37) //7
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end
                  
            8'h75    :  begin
                            if (dato_salida_8 != 8'h38) //8
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end  
                  
            8'h7d    :  begin
                            if (dato_salida_8 != 8'h39) //9
                                $display("t %h %h ERROR", $time, dato_i , dato_salida_8);
                        end
        endcase 
    end

endmodule