// This class is for doing the driver work. This class generates the stimulus 
//for the DUT based of the test instructions

class generator #(parameter pckg_sz   = 25,
                  parameter fifo_dpth = 8);

    // Virtual interface, this is used for connecting with DUT
    virtual if_dut #(.pckg_sz(pckg_sz)) vif;
    
    // Number of transactions
    bit transaccion_aleatoria;
    int cantidad_transacciones;
    int num_transactions;

    // Variables for holding specific values
    bit [3:0]          row_aux;
    bit [3:0]          col_aux;
    bit                modo_aux;
    bit [3:0]          src_aux;
    bit [pckg_sz-22:0] payload_aux;

    // Mailboxes declaration
    trans_mbx #(.pckg_sz(pckg_sz)) mbx_tst_gen;  // Test -> Generator
    trans_mbx #(.pckg_sz(pckg_sz)) mbx_gen_agt;  // Generator -> Agent

    // Packages instances
    // this pkg contains all the transaction info
    pkg_trans #(.pckg_sz(pckg_sz)) transaction;
    numero_transacciones cantidad;

    // Print function
    function void print_tst;
        $display("[%g] El generador recibe del test este tipo de prueba: Tipo: %s", $time, transaction.tipo);
    endfunction

    // Print function
    function void print_gen;
        $write("[%g] El generador genera esta prueba: ", $time);
        transaction.print();
    endfunction

    // Class constructor for some variables
    function new();
        transaccion_aleatoria  = 0;
        cantidad_transacciones = 1;
        modo_aux               = this.modo_aux;
        row_aux                = this.row_aux;
        col_aux                = this.col_aux;
        src_aux                = this.src_aux;
        payload_aux            = this.payload_aux;
    endfunction

    // Generates data depending on the instruction received by test
    task run();
        `ifdef DEBUG_BUILD
            $display("[%g] El generador se inicia", $time);
        `endif
        @(posedge vif.clk);
        forever begin
            // Creates some packages
            transaction = new();
	        cantidad = new();
	        cantidad.randomize();

            // Checks if it needs to randomize instruction amount
            if (!transaccion_aleatoria) begin
                num_transactions = cantidad_transacciones;
            end

            else begin 
                num_transactions = cantidad.num_transacciones;
            end

            // Reads mbx from tst
            mbx_tst_gen.get(transaction);
            `ifdef DEBUG_GEN
                $display("--------------------");
                $display("Prueba enviada");
                this.print_tst();
                $display("--------------------");
            `endif

            // Case statement for the type of transaction required
            $display("--------------------");
            $display("Pruebas generadas");
            $display("Cantidad de instrucciones: %2d", num_transactions);
            $display("--------------------");
            case(transaction.tipo)

                envio_rdm: begin // Randomizes all
                    for (int i = 0; i < num_transactions; i++) begin
                        transaction = new(0, 0, 0, 0, 0);
                        transaction.randomize(); 
                        transaction.tipo = envio_rdm;
                        transaction.dato_pkg.payload = transaction.payload_r;
                        transaction.dato_pkg.mode = transaction.mode_r;
                        transaction.dato_pkg.src = transaction.src_r;
                        transaction.dato_pkg.target.row = transaction.target_r[7:4];
                        transaction.dato_pkg.target.col = transaction.target_r[3:0];
                        `ifdef DEBUG_GEN
                            this.print_gen();
                        `endif
                        mbx_gen_agt.put(transaction);
                    end
                end

                envio_spc: begin // Sets specific all according to test
                    for (int i = 0; i < num_transactions; i++) begin
                        transaction = new(this.row_aux, this.col_aux, this.modo_aux, this.src_aux, this.payload_aux);
                        transaction.randomize(); 
                        transaction.tipo = envio_spc;
                        `ifdef DEBUG_GEN
                            this.print_gen();
                        `endif
                        mbx_gen_agt.put(transaction);
                    end
                end

                dato_rdm: begin // Randomizes payload
                    for (int i = 0; i < num_transactions; i++) begin
                        transaction = new(this.row_aux, this.col_aux, this.modo_aux, this.src_aux, 0);
                        transaction.randomize(); 
                        transaction.dato_pkg.payload = transaction.payload_r;
                        transaction.tipo = dato_rdm;
                        `ifdef DEBUG_GEN
                            this.print_gen();
                        `endif
                        mbx_gen_agt.put(transaction);
                    end
                end

                dato_spc: begin // Sets specific data according to test
                    for (int i = 0; i < num_transactions; i++) begin
                        transaction = new(0, 0, 0, 0, this.payload_aux);
                        transaction.randomize(); 
                        transaction.dato_pkg.mode = transaction.mode_r;
                        transaction.dato_pkg.src = transaction.src_r;
                        transaction.dato_pkg.target.row = transaction.target_r[7:4];
                        transaction.dato_pkg.target.col = transaction.target_r[3:0];
                        transaction.tipo = dato_spc;
                        `ifdef DEBUG_GEN
                            this.print_gen();
                        `endif
                        mbx_gen_agt.put(transaction);
                    end
                end

                target_rdm: begin // Randomizes target
                    for (int i = 0; i < num_transactions; i++) begin
                        transaction = new(0, 0, this.modo_aux, this.src_aux, this.payload_aux);
                        transaction.randomize(); 
                        transaction.dato_pkg.target.row = transaction.target_r[7:4];
                        transaction.dato_pkg.target.col = transaction.target_r[3:0];
                        transaction.tipo = target_rdm;
                        `ifdef DEBUG_GEN
                            this.print_gen();
                        `endif
                        mbx_gen_agt.put(transaction);
                    end
                end

                target_spc: begin // Sets specific target according to test
                    for (int i = 0; i < num_transactions; i++) begin
                        transaction = new(this.row_aux, this.col_aux, 0, 0, 0);
                        transaction.randomize(); 
                        transaction.dato_pkg.mode = transaction.mode_r;
                        transaction.dato_pkg.src = transaction.src_r;
                        transaction.dato_pkg.payload = transaction.payload_r;
                        transaction.tipo = target_spc;
                        `ifdef DEBUG_GEN
                            this.print_gen();
                        `endif
                        mbx_gen_agt.put(transaction);
                    end
                end

                modo_rdm: begin // Randomizes modo
                    for (int i = 0; i < num_transactions; i++) begin
                        transaction = new(this.row_aux, this.col_aux, 0, this.src_aux, this.payload_aux);
                        transaction.randomize(); 
                        transaction.dato_pkg.mode = transaction.mode_r;
                        transaction.tipo = modo_rdm;
                        `ifdef DEBUG_GEN
                            this.print_gen();
                        `endif
                        mbx_gen_agt.put(transaction);
                    end
                end

                modo_spc: begin // Sets specific modo according to test
                    for (int i = 0; i < num_transactions; i++) begin
                        transaction = new(0, 0, this.modo_aux, 0, 0);
                        transaction.randomize(); 
                        transaction.dato_pkg.src = transaction.src_r;
                        transaction.dato_pkg.payload = transaction.payload_r;
                        transaction.dato_pkg.target.row = transaction.target_r[7:4];
                        transaction.dato_pkg.target.col = transaction.target_r[3:0];
                        transaction.tipo = modo_spc;
                        `ifdef DEBUG_GEN
                            this.print_gen();
                        `endif
                        mbx_gen_agt.put(transaction);
                    end
                end

                reset_type: begin // Setups reset
                    for (int i = 0; i < num_transactions; i++) begin
                        transaction.tipo = reset_type;
                        `ifdef DEBUG_GEN
                            this.print_gen();
                        `endif
                        mbx_gen_agt.put(transaction);
                    end
                end

                default: $display("No se recibe un tipo de transaccion valida");
            endcase
	end
    endtask
endclass
