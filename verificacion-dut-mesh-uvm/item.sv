class item #(parameter pckg_sz = `PCKG_SZ) extends uvm_object;
    `uvm_object_utils(item)
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

    function new(string name = "item");
        super.new(name); 
    endfunction

endclass
