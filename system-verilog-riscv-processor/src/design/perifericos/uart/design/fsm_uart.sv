`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institucion: Instituto Tecnologico de Costa Rica 
// Curso: Taller de Diseño Digital
// Grupo: 1
// 
// Nombre del módulo: fsm_uart
// Descripción: Maquina de estados para manejar el bloque UART
//    
// Dependencias: 
// 
//////////////////////////////////////////////////////////////////////////////////

module fsm_uart (
    input    logic    clk_i,     // Entrada de reloj de 10MHz para la máquina de estados
    input    logic    rst_i,     // Entrada de reset de la máquina de estados
    input    logic    in_i,      // Bit in que inicia hace que el bit de send se envie al bloque uart
    input    logic    ready_i,   // Bit de ready el cual indica cuando la transacción está completada
    output   logic    we_o,      // Bit de write-enable que hace que se escriba un 0 en el registro de control 
    output   logic    send_o);   // Bit de send que inicia la transmisión de uart

    logic   rst;
    assign  rst  = ~rst_i;

//Se definen los estados
    typedef enum logic [ 3 : 0 ] {inicio, send, espera, resetea} statetype;
    statetype estado, estado_sig;
    
//Se crea el bloque de memoria
    always_ff @(posedge clk_i) begin
        if (!rst)  estado <= inicio;
        
        else       estado <= estado_sig;
    end

// Se implementan los estados de la FSM
    always_comb begin
        we_o   = 0;
        send_o = 0;

        case(estado)
            //Estado de inicio que espera que llegue el bit de in para enviar el bit de send al uart
            inicio: begin
                if (!in_i) estado_sig = inicio;
                else       estado_sig = send;
            end

            // Envia la señal de send al módulo de uart
            send: begin
                send_o     = 1;
                estado_sig = espera;
            end

            // Espera al final de la transacción de uart
            espera: begin 
                if (!ready_i) estado_sig = espera;
                else          estado_sig = resetea; 
            end
            
            // Estado final, el cual pone un 0 en el registro de control para resetearlo
            resetea: begin
                we_o       = 1;
                estado_sig = inicio;
            end
            
            //Caso default, en este caso se mantendrá en el estado de inicio 
            default: estado_sig = inicio;
        endcase
    end

endmodule