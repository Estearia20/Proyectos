// Kind of transactions possible
typedef enum {dato_rdm, dato_spc, 
              target_rdm, target_spc,
              modo_rdm, modo_spc,
              reset_type, envio_spc, 
              envio_rdm} trans;
 
typedef enum {reporte, retraso} report;       

// This package goes from generator to driver and contains all the info that
// they required, such as, instruction type, delay, etc...
// This package goes from generator to driver
class pkg_trans #(parameter pckg_sz = 25);
    // Attributes of the package, this package goes all the way down to
    // driver, from generator
    trans       tipo;
    bit         push [15:0];
    rand int    retardo;
    int         max_retardo; 
    int         t_envio;

    // auxiliary variables to randomize the struct variables
    rand bit [7:0] target_r;
    rand bit mode_r;
    rand bit [3:0] src_r;
    rand bit [pckg_sz-22:0] payload_r;

    // struct that constaints the info of the package that has to be sent
    // throught the DUT
    typedef struct packed {
        bit [7:0]  nxt_jump;
        struct packed {
            bit [3:0]  row;
            bit [3:0]  col;
        } target;
        bit                mode;
        bit [3:0]          src;
        bit [pckg_sz-22:0] payload;
    } dato;

    dato        dato_pkg;
  
  	// For storing the path
  	bit [7:0] path[$];
  
    // Class constructor
    function new(bit [3:0] row_c = 0, bit [3:0] col_c = 0, bit mode_c = 0, bit [3:0] src_c = 0, bit [pckg_sz-22:0] payload_c = 0);
        this.tipo                = dato_rdm;
        this.push                = '{default:0}; 
        this.retardo             = 0;
        this.max_retardo         = 10;
        this.t_envio             = 0;
        this.dato_pkg.nxt_jump   = 0;
        this.dato_pkg.target.row = row_c;
        this.dato_pkg.target.col = col_c;
        this.dato_pkg.mode       = mode_c;
        this.dato_pkg.src        = src_c;
        this.dato_pkg.payload    = payload_c;
    endfunction


    // Debug print, for showing package info
    function void print;
        $display("Contenido del paquete: Tipo: %s, Retardo: %2d, MaxRetardo: %2d, Push: %b, Tenvio: %3d, Target_row: %h, Target_col: %h, Modo: %b, Source:%h, Payload: %h", this.tipo, this.retardo, this.max_retardo, this.push[this.dato_pkg.src], this.t_envio, this.dato_pkg.target.row, this.dato_pkg.target.col, this.dato_pkg.mode, this.dato_pkg.src, this.dato_pkg.payload);
      
      $write("Path: ");
  	  foreach (this.path[i]) begin
        $write("%h, ", this.path[i]);
  	  end
      $display("");
    endfunction

    // Some constraints
    constraint ctr_retardo {retardo < max_retardo;
                            retardo > 0;} // For limiting the delay
    // Constraints to limit the value of rows and columns
    constraint ctr_target {target_r inside {8'h10,8'h15,8'h25,8'h30,8'h35,8'h40,8'h45,8'h51,8'h52,8'h53,8'h54,8'h01,8'h02,8'h03,8'h04,8'h20};}

    // Constraint to limit the src to be diff than the target
    constraint ctr_src {
        if(src_r == 0) target_r != 8'h01;
        if(src_r == 1) target_r != 8'h02;
        if(src_r == 2) target_r != 8'h03;
        if(src_r == 3) target_r != 8'h04;
        if(src_r == 4) target_r != 8'h10;
        if(src_r == 5) target_r != 8'h20;
        if(src_r == 6) target_r != 8'h30;
        if(src_r == 7) target_r != 8'h40;
        if(src_r == 8) target_r != 8'h51;
        if(src_r == 9) target_r != 8'h52;
        if(src_r == 10) target_r != 8'h53;
        if(src_r == 11) target_r != 8'h54;
        if(src_r == 12) target_r != 8'h15;
        if(src_r == 13) target_r != 8'h25;
        if(src_r == 14) target_r != 8'h35;
        if(src_r == 15) target_r != 8'h45;
    }

endclass

// This class contains what goes from monitor to checker
class pkg_trans_2 #(parameter pckg_sz = 25);

  	int         t_recibo;
  	int 		t_envio;
  	real        latencia;
  
    // struct that constaints the info of the package that has to be sent
    // throught the DUT
    typedef struct packed {
        logic [7:0]  nxt_jump;
        struct packed {
            bit [3:0]  row;
            bit [3:0]  col;
        } target;
        bit                mode;
        bit [3:0]          src;
        bit [pckg_sz-22:0] payload;
    } dato;

    dato dato_pkg;

    // Class constructor
    function new();
        this.dato_pkg.nxt_jump   = 0;
        this.dato_pkg.target.row = 0;
        this.dato_pkg.target.col = 0;
        this.dato_pkg.mode       = 0;
        this.dato_pkg.src        = 0;
        this.dato_pkg.payload    = 0;
     	this.t_recibo 			 = 0;
      	this.t_envio			 = 0;
      	this.latencia			 = 0;
    endfunction

    // Debug print, for showing package info
    function void print;
        $display("Contenido del paquete: Target_col: %h, Target_row: %h, Modo: %b, Source: %h, Payload: %h, Trecibo: %3d", this.dato_pkg.target.col, this.dato_pkg.target.row, this.dato_pkg.mode, this.dato_pkg.src, this.dato_pkg.payload, this.t_recibo);
    endfunction
    
endclass


// Paquete de transacciones entre checker scoreboard
class pkg_chk_scb #(parameter pckg_sz = 25);
  
  	bit [3:0]           src;
    bit  [pckg_sz-22:0] data;
    bit [3:0]         	row_id;
    bit [3:0]          	col_id;
    bit 		completado;
    int  		latencia;
    int  		cantidad_transacciones;
    int 		t_envio;
    int  		t_recibo;
    real 		bw;

    // Class constructor
    function new ();
        this.completado = 0;
        this.latencia   = 0;
        this.bw         = 0;
    endfunction

    // Debug print
    function void print (string tag);
      $display("[%g] %s completado = %b , latencia = %3d, ancho de banda = %0.3f", $time, tag, this.completado, this.latencia, this.bw);
    endfunction

    // Debug print for report
    function void print_rpt();
      $display("[%g] Escribiendo en el archivo: Dato = %h, Fuente = %d, Fila = %d, Columna = %d, Latencia = %3d s, Ancho de banda = %0.3f Gbps", 
                 $time, this.data, this.src, this.row_id, this.col_id, this.latencia, this.bw);
    endfunction
  
    // For calculating the delay for a transaction
    function void calc_latencia();
        this.latencia = this.t_recibo - this.t_envio;
    endfunction
  
    // For calculating the bandwidth of a transaction
  function void calc_bw(real pkg);
      this.bw = pkg / this.latencia; 
    endfunction
endclass


// Transaction package to randomize number of instructions
class numero_transacciones;
    rand int num_transacciones;

    // Class constructor
    function new();
        this.num_transacciones = 2;
    endfunction

    constraint ctr_transacciones {num_transacciones < 20;
                                  num_transacciones > 0;} // For limiting the number of transactions
endclass


// Transaction package to send t_envio to monitor
class drv_mnt;
    int         t_envio;

    // Class constructor
    function new();
        this.t_envio = 0;
    endfunction

endclass


// Parametric mailboxes definition

// This mailbox is for sending information from generator to driver
typedef mailbox #(pkg_trans) trans_mbx;

// This mailbox is for sending information from monitor to checker
typedef mailbox #(pkg_trans_2) trans_2_mbx;

// This mailbox is for sending information from test to scoreboard
typedef mailbox #(report) trans_mbx_tst_scb;

// This mailbox is for sending information from checker to scoreboard
typedef mailbox #(pkg_chk_scb) trans_mbx_chk_scb;

// This mailbox is for sending information from driver to monitor
typedef mailbox #(drv_mnt) trans_mbx_drv_mnt;
