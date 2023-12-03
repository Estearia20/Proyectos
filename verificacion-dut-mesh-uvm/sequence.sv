class gen_item_seq #(parameter pckg_sz = `PCKG_SZ) extends uvm_sequence;
    `uvm_object_utils(gen_item_seq)
   
     // Transaction type
    trans  tipo;

    // Variables for holding specific values
    bit [3:0]          row_aux;
    bit [3:0]          col_aux;
    bit                modo_aux;
    bit [3:0]          src_aux;
    bit [pckg_sz-22:0] payload_aux;
    
    function new (string name = "gen_item_seq");
        super.new(name);
    endfunction

    //Declare virtual interface
    virtual if_dut vif;

    virtual task body();
	
        sequence_trans transaction;
        transaction = sequence_trans::type_id::create("transaction");
        `uvm_info(get_type_name(), $sformatf("Starting sequence: %s", get_sequence_path()), UVM_HIGH)
        
        case(tipo)

            envio_rdm: begin
                transaction = sequence_trans::type_id::create("transaction");
                transaction = new("sequence_trans",0, 0, 0, 0, 0);
                transaction.randomize(); 
                start_item(transaction);
                transaction.tipo = envio_rdm;
                transaction.dato_pkg.payload = transaction.payload_r;
                transaction.dato_pkg.mode = transaction.mode_r;
                transaction.dato_pkg.src = src_aux;
                transaction.dato_pkg.target.row = transaction.target_r[7:4];
                transaction.dato_pkg.target.col = transaction.target_r[3:0];
                transaction.push[transaction.dato_pkg.src] = 1;
                transaction.print();
                finish_item(transaction);
            end

            envio_spc: begin
                transaction = sequence_trans::type_id::create("transaction");
                transaction = new("sequence_trans",this.row_aux, this.col_aux, this.modo_aux, this.src_aux, this.payload_aux);
                start_item(transaction);
                transaction.randomize();
                transaction.tipo = envio_spc;
                transaction.push[transaction.dato_pkg.src] = 1;
                transaction.print();
                finish_item(transaction);
            end

            reset_type: begin
                transaction = sequence_trans::type_id::create("transaction");
                start_item(transaction);
                transaction.tipo = reset_type;
                transaction.push[transaction.dato_pkg.src] = 0;
                transaction.print(); 
                finish_item(transaction);
            end

            default: uvm_report_info("INFO", "No se recibe un tipo de transacción válida", UVM_LOW);

        endcase

    endtask

endclass
