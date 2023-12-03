// Kind of transactions possible
typedef enum {envio_spc, 
              envio_rdm,reset_type} trans;
 
typedef enum {reporte, retraso} report; 


//This is the base transaction object that
//will be used in the enviroment to initiate
// new transactions and capture transactions
// at DUT interface

class sequence_trans #(parameter pckg_sz = `PCKG_SZ) extends uvm_sequence_item;
    `uvm_object_utils(sequence_trans)
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
    randc bit [pckg_sz-22:0] payload_r;

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

    function new(string name = "sequence_trans",bit [3:0] row_c = 0, bit [3:0] col_c = 0, bit mode_c = 0, bit [3:0] src_c = 0, bit [pckg_sz-22:0] payload_c = 0);
        super.new(name);
        tipo                = envio_rdm;
        push                = '{default:0}; 
        retardo             = 0;
        max_retardo         = 10;
        t_envio             = 0;
        dato_pkg.nxt_jump   = 0;
        dato_pkg.target.row = row_c;
        dato_pkg.target.col = col_c;
        dato_pkg.mode       = mode_c;
        dato_pkg.src        = src_c;
        dato_pkg.payload    = payload_c; 
    endfunction

   // Debug print, for showing package info
    function void print;
	$display("--------------------");
        $display("Contenido de la secuencia: Tipo: %s, Retardo: %2d, MaxRetardo: %2d, Push: %b, Tenvio: %3d, Target_row: %h, Target_col: %h, Modo: %b, Source:%h, Payload: %h", this.tipo, this.retardo, this.max_retardo, this.push[this.dato_pkg.src], this.t_envio, this.dato_pkg.target.row, this.dato_pkg.target.col, this.dato_pkg.mode, this.dato_pkg.src, this.dato_pkg.payload);
	$display("--------------------");    
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

class sequence_trans_2 #(parameter pckg_sz = `PCKG_SZ) extends uvm_sequence_item;
    `uvm_object_utils(sequence_trans_2)
    int         t_recibo;
  	int 		t_envio;
    int  		cantidad_transacciones;
  	int         latencia;
    real        bw;
  
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

    // Utility and Field macros,
    /*
    `uvm_object_utils_begin(mem_seq_item)
        `uvm_field_int(addr,UVM_ALL_ON)
        `uvm_field_int(wr_en,UVM_ALL_ON)
        `uvm_field_int(rd_en,UVM_ALL_ON)
        `uvm_field_int(wdata,UVM_ALL_ON)
    `uvm_object_utils_end
    */

    // Class constructor
    function new(string name = "sequence_trans_2");
        super.new(name); 
    endfunction

    // Proper print function for this class, this is used at the report phase
    virtual function void do_print(uvm_printer printer);
        super.do_print(printer);
        printer.print_field_int("t_recibo", t_recibo, $bits(t_recibo), UVM_DEC);
        printer.print_field_int("t_envio", t_envio, $bits(t_envio), UVM_DEC);
        printer.print_field_int("latencia", latencia, $bits(latencia), UVM_DEC);
        printer.print_real("bw", bw);

        // For the dato_pkg struct, you'll need to print each field individually
        printer.print_field_int("dato_pkg.target.row", dato_pkg.target.row, $bits(dato_pkg.target.row));
        printer.print_field_int("dato_pkg.target.col", dato_pkg.target.col, $bits(dato_pkg.target.col));
        printer.print_field_int("dato_pkg.mode", dato_pkg.mode, $bits(dato_pkg.mode));
        printer.print_field_int("dato_pkg.src", dato_pkg.src, $bits(dato_pkg.src));
        printer.print_field_int("dato_pkg.payload", dato_pkg.payload, $bits(dato_pkg.payload));
    endfunction

endclass
