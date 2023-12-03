///////////////////////////////////////////////////
// Definición del tipo de transacciones posibles //
///////////////////////////////////////////////////

// Possible transactions
typedef enum {envio_aleatorio, envio_especifico, broadcast_type, reset, envio_spcf_rand} tipo_trans;

// Generate report, or avg report
typedef enum {retraso_promedio, reporte} tipo_report;

// Paquete de transacciones del agente hacia el checker
class pkg_agt_chk;
    bit [7:0]   id;

    // Class constructor
    function new();
        this.id = 0;
    endfunction

    // Print function
    function void print();
        $display("[%g] El agente pasa al checker el ID = %2d", $time, this.id);
    endfunction
endclass

// Paquete de transacciones del monitor hacia el checker
class pkg_mnt_chk #(parameter drvrs  = 4,
                    parameter pkg_sz = 16);
    logic   [pkg_sz-1:0]        dato_out [drvrs-1:0];
    bit     [7:0]               id_source;
    int                         t_envio;
    int                         t_recibo;
    real                        latencia;
    real                        bw;
    tipo_trans                  tipo;

    // Class constructor
    function new();
        this.id_source = 0;
        this.t_envio   = 0;
        this.t_recibo  = 0;
        this.latencia  = 0;
        this.bw        = 0;
        this.tipo      = envio_aleatorio;
    endfunction

    // For calculating the delay for a transaction
    function calc_latencia();
        this.latencia = this.t_recibo - this.t_envio;
    endfunction

    // For calculating the bandwidth
    function real calc_bw(int pkg);
        bw = pkg / this.latencia; 
        return bw;
    endfunction

    // Prints the delay
    function void show_latencia();
        $display(this.latencia);
    endfunction

    // Prints the bw
    function void show_bw();
        $display("%f Gbps", this.bw);
    endfunction

    // Function to print elements on class
    function void print;
        $display("Dato = %h, ID = %d, Tiempo envio = %g, Tiempo recibo = %g", this.dato_out[this.id_source], this.id_source, this.t_envio, this.t_recibo);
    endfunction

    // Debug print for the checker
    function print_chk;
        $display("%h, %d", this.dato_out[this.id_source], this.id_source);
    endfunction

endclass

// Paquete de transacciones del driver hacia el monitor
class pkg_drv_mnt #(parameter pkg_sz = 16);
    bit [7:0]   id_source;
    bit [7:0]   fuente;
    int         t_envio;
    tipo_trans  tipo;

    // Class constructor
    function new();
        this.id_source  = 0;
	    this.fuente     = 0;
        this.t_envio    = $time;
	    this.tipo	= envio_aleatorio;
    endfunction

    // Print function for debug
    function void print;
        $display("ID = %d, Tiempo envio = %g", this.id_source, this.t_envio);
    endfunction

endclass

// Paquete de transacciones del agente hacia el driver
class pkg_agt_drv #(parameter bits      = 1,
                    parameter drvrs     = 4,
                    parameter pkg_sz    = 16);

    bit [(pkg_sz-8)-1:0] data;
    bit [7:0]            id_ident;
    bit 		         push [bits-1:0][drvrs-1:0];
    int                  retardo;
    tipo_trans           tipo; //envio, broadcast, reset

    // Class constructor
    function new (tipo_trans tpo = envio_aleatorio);
        this.id_ident = 0;
	    this.push     = '{default:0}; // Inicializar todo con ceros
        this.retardo  = 0;
        this.tipo     = tpo;
    endfunction

    // Debug print
    function void print;
        $display("payload = %h , id = %d, tipo = %s, retardo = %2d, push = %d", this.data, this.id_ident, this.tipo, this.retardo, this.push[0][this.data[7:0]]);
    endfunction

endclass

// Paquete de transacciones entre generador hacia el agente
class pkg_gen_agt #(parameter drvrs  = 4,
                    parameter pkg_sz = 16,
                    parameter broadcast = {8{1'b1}});

    rand bit   [(pkg_sz-8)-1:0] data;
    rand bit   [7:0]            id_ident;
    rand int                    retardo;
    int                         max_retardo;
    tipo_trans                  tipo;

    // Class constructor
    function new;
        this.data        = 0;
        this.id_ident    = 0;
        this.retardo     = 0;
        this.max_retardo = 10;
        this.tipo        = envio_aleatorio;
    endfunction

    // Print function to debug
    function void print;
        $display("Dato = %h, ID = %h, Retardo = %2d, Tipo = %s", this.data, this.id_ident, this.retardo, this.tipo);
    endfunction

    // Some constraints
    constraint ctr_retardo {retardo < max_retardo;
                            retardo > 0;} // For limiting the delay

    constraint ctr_id {id_ident < drvrs;} // For limiting ID value to the amount of drvrs available

    constraint ctr_id_source {data[7:0] < drvrs;} // For setting the metadata

    constraint ctr_diff_id {id_ident != data[7:0];} // Does not allow id_source and id_deliver to be the same

endclass

// Paquete de transacciones entre test y generador
class pkg_tst_gen #(parameter pkg_sz = 16);
    tipo_trans  tipo;
    bit   [(pkg_sz-8)-1:0] data;
    bit   [7:0]            id_ident;
    int                    retardo;

    // Class constructor
    function new();
        this.data       = 0;
        this.id_ident   = 0;
        this.retardo    = 0;
        this.tipo       = envio_aleatorio;
    endfunction

    // Print function to debug
    function void print;
        $display("Tipo = %s", this.tipo);
    endfunction

endclass

// Paquete de transacciones entre agente y scoreboard
class pkg_agt_scb #(parameter pkg_sz = 16);

    bit [(pkg_sz-8)-1:0] data;
    bit [7:0]            id_ident;
    tipo_trans           tipo; //envio, broadcast, reset

    // Class constructor
    function new (tipo_trans tpo = envio_aleatorio);
        this.id_ident = 0;
        this.data     = 0;
        this.tipo     = tpo;
    endfunction

    // Debug print
    function void print (string tag);
        $display("[%g] %s payload = %h , id = %2d, tipo = %s", $time, tag, this.data, this.id_ident, this.tipo);
    endfunction

endclass


// Paquete de transacciones entre scoreboard y cheaker
class pkg_scb_chk # (parameter pkg_sz = 16);

    bit [(pkg_sz-8)-1:0] data;
    bit [7:0]            id_ident;
    tipo_trans           tipo; //envio, broadcast, reset

    // Class constructor
    function new (tipo_trans tpo = envio_aleatorio);
        this.id_ident = 0;
        this.data     = 0;
        this.tipo     = tpo;
    endfunction

    // Debug print
    function void print (string tag);
        $display("[%g] %s payload = %h , id = %2d, tipo = %s", $time, tag, this.data, this.id_ident, this.tipo);
    endfunction

endclass


// Paquete de transacciones entre checker scoreboard
class pkg_chk_scb #(parameter pkg_sz = 16);

    bit  [(pkg_sz-8)-1:8] data;
    bit  [7:0]            id_source;
    bit  [7:0]            id_dest;
    bit  completado;
    int  latencia;
    int  cantidad_transacciones;
    int  t_envio;
    int  t_recibo;
    real bw;

    // Class constructor
    function new (tipo_trans tpo = envio_aleatorio);
        this.completado = 0;
        this.latencia   = 0;
        this.bw         = 0;
    endfunction

    // Debug print
    function void print (string tag);
        $display("[%g] %s completado = %b , latencia = %d, ancho de banda = %f", $time, tag, this.completado, this.latencia, this.bw);
    endfunction

    // Debug print for report
    function void print_rpt();
        $display("[%g] Escribiendo en el archivo: Dato = %h, Fuente = %d, Destino = %d, Latencia = %3d s, Ancho de banda = %f Gbps", 
                 $time, this.data, this.id_source, this.id_dest, this.latencia, this.bw);
    endfunction

endclass

// Paquete de transacciones para aleatorizar cantidad de instrucciones
class numero_transacciones;
    rand int num_transacciones;

    // Class constructor
    function new();
        this.num_transacciones = 2;
    endfunction

    constraint ctr_transacciones {num_transacciones < 20;
                                  num_transacciones > 0;} // For limiting the number of transactions
endclass

// Definicion de los mailboxes

// Mailbox para comunicacion entre test y scoreboard
typedef mailbox #(tipo_report) trans_mbx_tst_scb;

// Mailbox para comunicacion entre agente y driver
typedef mailbox #(pkg_agt_drv) trans_mbx_agt_drv;

// Mailbox para comunicacion entre monitor y checker
typedef mailbox #(pkg_mnt_chk) trans_mbx_mnt_chk;

// Mailbox para comunicacion entre driver y monitor
typedef mailbox #(pkg_drv_mnt) trans_mbx_drv_mnt;

// Mailbox para comunicacion entre generador y agente
typedef mailbox #(pkg_gen_agt) trans_mbx_gen_agt; 

// Mailbox para comunicacion entre test y generador
typedef mailbox #(pkg_tst_gen) trans_mbx_tst_gen;

//Mailbox para comunicacion entre agente y checker
typedef mailbox #(pkg_agt_chk) trans_mbx_agt_chk;

// Mailbox para comunicacion entre agente y scoreboard
typedef mailbox #(pkg_agt_scb) trans_mbx_agt_scb;

// Mailbox para comunicacion entre scoreboard y checker
typedef mailbox #(pkg_scb_chk) trans_mbx_scb_chk;

// Mailbox para comunicacion entre checker y scoreboard
typedef mailbox #(pkg_chk_scb) trans_mbx_chk_scb;
