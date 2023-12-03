// This class generates the stimulus for the DUT based of the test
// instructions
class generator #(parameter bits      = 1,
                  parameter drvrs     = 4,
                  parameter pkg_sz    = 16,
                  parameter broadcast = {8{1'b1}});

    // DUT instance
    virtual if_dut #(.drvrs(drvrs), .pkg_sz(pkg_sz), .broadcast(broadcast)) bus_if;
    
    // Numero de transacciones
    bit transaccion_aleatoria;
    int cantidad_transacciones;
    int num_transactions;

    // Mailboxes declaration
    trans_mbx_tst_gen #(.pkg_sz(pkg_sz)) mbx_tst_gen;
    trans_mbx_gen_agt #(.pkg_sz(pkg_sz)) mbx_gen_agt;

    // Packages definition
    pkg_tst_gen #(.pkg_sz(pkg_sz)) transaction_tst_gen;
    pkg_gen_agt #(.pkg_sz(pkg_sz)) transaction_gen_agt;
    numero_transacciones cantidad;

    // Some variables required for reference
    bit [(pkg_sz-8)-1:0]    dat_spc;
    bit [7:0]               id_source_spc;
    bit [7:0]               id_spc;
    int                     ret_spc;
    
    // Print function
    function void print_tst;
        $write("[%g] El generador recibe del test este tipo de prueba: ", $time);
        transaction_tst_gen.print();
    endfunction

    // Print function
    function void print_gen;
        $write("[%g] El generador genera esta prueba: ", $time);
        transaction_gen_agt.print();
    endfunction

    // Class constructor for some variables
    function new;
        transaccion_aleatoria  = 0;
        cantidad_transacciones = 1;
    endfunction

    // Generates data depending on the instruction received by test
    task run();
        $display("[%g] El generador se inicializa", $time);
        @(posedge bus_if.clk);
        forever begin
            // Creates some packages
            transaction_tst_gen = new();
            transaction_gen_agt = new();
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
            mbx_tst_gen.get(transaction_tst_gen);
            this.print_tst();

            if(transaction_tst_gen.id_ident < drvrs) begin
            
            // Case statement for the type of transaction required
            case(transaction_tst_gen.tipo)
                envio_aleatorio: begin // Randomizes everything
                    for (int i = 0; i < num_transactions; i++) begin
                        transaction_gen_agt = new;
                        transaction_gen_agt.randomize(); 
                        transaction_gen_agt.tipo = envio_aleatorio;
                        this.print_gen();
                        mbx_gen_agt.put(transaction_gen_agt);
                    end
                end

                envio_especifico: begin // Sets specific data according to test
                    for (int i = 0; i < num_transactions; i++) begin
                        transaction_gen_agt = new;
                        transaction_gen_agt.data[pkg_sz-9:8] = transaction_tst_gen.data[pkg_sz-9:8];
                        transaction_gen_agt.data[7:0]        = transaction_tst_gen.data[7:0];
                        transaction_gen_agt.id_ident         = transaction_tst_gen.id_ident;
                        transaction_gen_agt.retardo          = transaction_tst_gen.retardo;
                        transaction_gen_agt.tipo             = envio_especifico;
                        this.print_gen();
                        mbx_gen_agt.put(transaction_gen_agt);
                    end
                end

                reset: begin // Setups reset
                    for (int i = 0; i < num_transactions; i++) begin
                        transaction_gen_agt = new;
                        transaction_gen_agt.randomize();
                        transaction_gen_agt.tipo = reset;
                        this.print_gen();
                        mbx_gen_agt.put(transaction_gen_agt);
                    end
                end

                broadcast_type: begin // Setups broadcast
                    for (int i = 0; i < num_transactions; i++) begin
                        transaction_gen_agt = new;
                        transaction_gen_agt.randomize();
                        transaction_gen_agt.tipo = broadcast_type;
                        transaction_gen_agt.id_ident = broadcast;
                        this.print_gen();
                        mbx_gen_agt.put(transaction_gen_agt);
                    end
                end

                envio_spcf_rand: begin // Setups a test where only the data is randomized, not the source or destination
                    for (int i = 0; i < num_transactions; i++) begin
                        transaction_gen_agt = new;
                        transaction_gen_agt.randomize();
                        transaction_gen_agt.data[7:0] = transaction_tst_gen.data[7:0];
                        transaction_gen_agt.id_ident  = transaction_tst_gen.id_ident;
                        transaction_gen_agt.tipo = envio_spcf_rand;
                        this.print_gen();
                        mbx_gen_agt.put(transaction_gen_agt);
                    end
                end

                default: $display("No se recibe un tipo de transaccion valida");
            endcase
            end

            // In case the id is not inside the amount of drvrs then it
            // prompts an error
            else begin
                $display("ERROR: Indique un destino o fuente por debajo de la cantidad de terminales\n");
                #15000;
            end
        end
    endtask
endclass
