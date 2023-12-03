class test extends uvm_test;
    `uvm_component_utils(test)

    // Explicit constructor
    function new(string name = "test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    ambiente env;
    gen_item_seq seq;
    virtual if_dut vif;

    // This function allows the user to change the simulation time, in case
    // more than default is required
    function void start_of_simulation_phase(uvm_phase phase);
        super.start_of_simulation_phase(phase);
        // uvm_top is a constant handle of uvm_root declared in uvm_root.svh file
        uvm_top.set_timeout(250000s, 1);  // Override default timeout to 1oo second
        // or you can use below syntax as well
        // uvm_root::get().set_timeout(100s, 1);
    endfunction : start_of_simulation_phase

    // Variables required for randomizing the srcs
    int trans_cant_prev;
    int trans_cant;
    bit is_trans_random;
    bit [3:0] src_list[$];
    bit [3:0] src_tmp;

    // Build phase
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // Create the environment
        env = ambiente::type_id::create("env", this);

        // Look for the interface
        if (!uvm_config_db #(virtual if_dut)::get(this, "", "if_dut", vif))
            `uvm_fatal("TST", "Did not get interface")
        uvm_config_db #(virtual if_dut)::set(this, "env.agt.*", "if_dut", vif);
    endfunction

    // Run phase
    virtual task run_phase(uvm_phase phase);
    `uvm_info(get_full_name(), "start of run phase",UVM_NONE)

    // Make random srcs depending on the amount of instructions and type
    trans_cant_prev = 50;
    is_trans_random = 0;

    if (!is_trans_random) begin
        trans_cant = trans_cant_prev;
    end else begin
        trans_cant = $urandom_range(0, 50);
    end

    for (int i = 0; i < trans_cant; i++) begin
        src_list.push_back( $urandom_range(0, 15));
    end

    phase.raise_objection(this);
    `ifdef TEST_RDM
        for (int i = 0; i < trans_cant; i++) begin
            src_tmp = src_list.pop_front();
            seq = gen_item_seq::type_id::create("seq");
            seq.src_aux = src_tmp;
            seq.tipo = envio_rdm;
            seq.start(env.agt.seq[src_tmp]);
        end
    `endif

    `ifdef TEST_SPC_VARIAS
        // Start the 1 sequence
        for (int i = 0; i < trans_cant; i++) begin
            seq = gen_item_seq::type_id::create("seq");
            seq.tipo = envio_spc;
            seq.row_aux =  4'b0101; //5
            seq.col_aux = 4'b0001; //1
            seq.modo_aux = 1'b0;
            seq.src_aux = 4'b0101; //5
            seq.payload_aux = $urandom_range(0, 500000); 
            seq.start(env.agt.seq[seq.src_aux]);
            #1;
        end
    `endif

    `ifdef TEST_SPC
        // Reconfigure seq for the 2 sequence
        for (int i = 0; i < trans_cant; i++) begin
            seq = gen_item_seq::type_id::create("seq");
            seq.tipo = envio_spc;
            seq.row_aux =  4'b0010; //2
            seq.col_aux = 4'b000; //0
            seq.modo_aux = 1'b1;
            seq.src_aux = 4'b0001; //1
            seq.payload_aux = 4'b0100; //4
            seq.start(env.agt.seq[seq.src_aux]);
            #1;
        end

        // Reconfigure seq for the 3 sequence
        for (int i = 0; i < trans_cant; i++) begin
            seq = gen_item_seq::type_id::create("seq");
            seq.row_aux =  4'b000; //0
            seq.col_aux = 4'b0001; //1
            seq.modo_aux = 1'b1;
            seq.src_aux = 4'b0111; //7
            seq.payload_aux = 4'b1010; //10
            seq.start(env.agt.seq[seq.src_aux]);
            #1;
        end
        #100;
    `endif



    `ifdef TEST_RESET
        // Start the 1 sequence  
        for (int i = 0; i < trans_cant; i++) begin
            seq = gen_item_seq::type_id::create("seq");
            seq.tipo = envio_spc;
            seq.row_aux =  4'b0101; //5
            seq.col_aux = 4'b0001; //1
            seq.modo_aux = 1'b0;
            seq.src_aux = 4'b0101; //0
            seq.payload_aux = 4'b0111; //7
            seq.start(env.agt.seq[seq.src_aux]);
            #1;
        end

        // Start the 2 sequence
        for (int i = 0; i < trans_cant; i++) begin
            seq = gen_item_seq::type_id::create("seq");
            seq.tipo = reset_type; //Reset
            seq.start(env.agt.seq[seq.src_aux]);
            #1;
        end

        // Start the 3 sequence
        for (int i = 0; i < trans_cant; i++) begin
            seq = gen_item_seq::type_id::create("seq");
            seq.tipo = envio_spc;
            seq.row_aux =  4'b0010; //2
            seq.col_aux = 4'b000; //0
            seq.modo_aux = 1'b1;
            seq.src_aux = 4'b0001; //1
            seq.payload_aux = 4'b0100; //4
            seq.start(env.agt.seq[seq.src_aux]);
            #1;
        end
    
        // Start the 4 sequence
        for (int i = 0; i < trans_cant; i++) begin
            seq = gen_item_seq::type_id::create("seq");
            seq.tipo = reset_type; //Reset
            seq.start(env.agt.seq[seq.src_aux]);
            #1;
        end

        // Start the 5 sequence
        for (int i = 0; i < trans_cant; i++) begin
            seq = gen_item_seq::type_id::create("seq");
            seq.tipo = envio_spc;
            seq.row_aux =  4'b0101; //5
            seq.col_aux = 4'b0001; //1
            seq.modo_aux = 1'b0;
            seq.src_aux = 4'b0000; //0
            seq.payload_aux = 4'b0101; //6
            seq.start(env.agt.seq[seq.src_aux]);
        end
            #100;

    `endif

    `ifdef TEST_MODO
    // Configure 1 sequence
        for (int i = 0; i < trans_cant; i++) begin
            seq = gen_item_seq::type_id::create("seq");
            seq.tipo = envio_spc;
            seq.row_aux =  4'b0100; //4
            seq.col_aux = 4'b0101; //5
            seq.modo_aux = 1'b1; //1
            seq.src_aux = 4'b0100; //4
            seq.payload_aux = 4'b1010; //a
            seq.start(env.agt.seq[seq.src_aux]);
            #1;
        end

    // Reconfigure seq for the 2 sequence with diferent mode
        for (int i = 0; i < trans_cant; i++) begin
            seq = gen_item_seq::type_id::create("seq");
            seq.row_aux =  4'b0100; //4
            seq.col_aux = 4'b0101; //5
            seq.modo_aux = 1'b0; //0
            seq.src_aux = 4'b0100; //4
            seq.payload_aux = 4'b1010; //a
            seq.start(env.agt.seq[seq.src_aux]);
        end
            #100;
    `endif

    `ifdef TEST_MSRC_DTAR
        // Start the 1 sequence
        for (int i = 0; i < trans_cant; i++) begin
            seq = gen_item_seq::type_id::create("seq");
            seq.tipo = envio_spc;
            seq.row_aux =  4'b0000; //0
            seq.col_aux = 4'b0001; //1
            seq.modo_aux = 1'b0;
            seq.src_aux = 4'b0100; //4
            seq.payload_aux = 4'b0000; //0
            seq.start(env.agt.seq[seq.src_aux]);
            #1;
        end

        // Reconfigure seq for the 2 sequence
        for (int i = 0; i < trans_cant; i++) begin
            seq = gen_item_seq::type_id::create("seq");
            seq.row_aux =  4'b0000; //0
            seq.col_aux = 4'b00010; //2
            seq.modo_aux = 1'b0;
            seq.src_aux = 4'b0100; //4
            seq.payload_aux = 4'b0001; //1
            seq.start(env.agt.seq[seq.src_aux]);
            #1;
        end

        // Reconfigure seq for the 3 sequence
        for (int i = 0; i < trans_cant; i++) begin
            seq = gen_item_seq::type_id::create("seq");
            seq.row_aux =  4'b0000; //0
            seq.col_aux = 4'b0011; //3
            seq.modo_aux = 1'b0;
            seq.src_aux = 4'b0100; //4
            seq.payload_aux = 4'b0010; //2
            seq.start(env.agt.seq[seq.src_aux]);
            #1;
        end

        // Reconfigure seq for the 4 sequence
        for (int i = 0; i < trans_cant; i++) begin
            seq = gen_item_seq::type_id::create("seq");
            seq.row_aux =  4'b0001; //1
            seq.col_aux = 4'b0000; //0
            seq.modo_aux = 1'b0;
            seq.src_aux = 4'b0100; //4
            seq.payload_aux = 4'b0011; //3
            seq.start(env.agt.seq[seq.src_aux]);
            #1;
        end

        // Reconfigure seq for the 5 sequence
        for (int i = 0; i < trans_cant; i++) begin
            seq = gen_item_seq::type_id::create("seq");
            seq.row_aux =  4'b0010; //2
            seq.col_aux = 4'b0000; //0
            seq.modo_aux = 1'b0;
            seq.src_aux = 4'b0100; //4
            seq.payload_aux = 4'b0100; //4
            seq.start(env.agt.seq[seq.src_aux]);
            #1;
        end

        // Reconfigure seq for the 6 sequence
        for (int i = 0; i < trans_cant; i++) begin
            seq = gen_item_seq::type_id::create("seq");
            seq.row_aux =  4'b0011; //3
            seq.col_aux = 4'b0000; //0
            seq.modo_aux = 1'b0;
            seq.src_aux = 4'b0100; //4
            seq.payload_aux = 4'b0101; //5
            seq.start(env.agt.seq[seq.src_aux]);
            #1;
        end

        // Reconfigure seq for the 7 sequence
        for (int i = 0; i < trans_cant; i++) begin
            seq = gen_item_seq::type_id::create("seq");
            seq.row_aux =  4'b0100; //4
            seq.col_aux = 4'b0000; //0
            seq.modo_aux = 1'b0;
            seq.src_aux = 4'b0100; //4
            seq.payload_aux = 4'b0110; //6
            seq.start(env.agt.seq[seq.src_aux]);
            #1;
        end

        // Reconfigure seq for the 8 sequence
        for (int i = 0; i < trans_cant; i++) begin
            seq = gen_item_seq::type_id::create("seq");
            seq.row_aux =  4'b0101; //5
            seq.col_aux = 4'b0001; //1
            seq.modo_aux = 1'b0;
            seq.src_aux = 4'b0100; //4
            seq.payload_aux = 4'b0111; //7
            seq.start(env.agt.seq[seq.src_aux]);
            #1;
        end

        // Reconfigure seq for the 9 sequence
        for (int i = 0; i < trans_cant; i++) begin
            seq = gen_item_seq::type_id::create("seq");
            seq.row_aux =  4'b0101; //5
            seq.col_aux = 4'b0010; //2
            seq.modo_aux = 1'b0;
            seq.src_aux = 4'b0100; //4
            seq.payload_aux = 4'b1000; //8
            seq.start(env.agt.seq[seq.src_aux]);
            #1;
        end

        // Reconfigure seq for the 10 sequence
        for (int i = 0; i < trans_cant; i++) begin
            seq = gen_item_seq::type_id::create("seq");
            seq.row_aux =  4'b0101; //5
            seq.col_aux = 4'b0011; //3
            seq.modo_aux = 1'b0;
            seq.src_aux = 4'b0100; //4
            seq.payload_aux = 4'b1001; //9
            seq.start(env.agt.seq[seq.src_aux]);
            #1;
        end

        // Reconfigure seq for the 11 sequence
        for (int i = 0; i < trans_cant; i++) begin
            seq = gen_item_seq::type_id::create("seq");
            seq.row_aux =  4'b0101; //5
            seq.col_aux = 4'b0100; //4
            seq.modo_aux = 1'b0;
            seq.src_aux = 4'b0100; //4
            seq.payload_aux = 4'b1010; //11
            seq.start(env.agt.seq[seq.src_aux]);
            #1;
        end
    
        // Reconfigure seq for the 12 sequence
        for (int i = 0; i < trans_cant; i++) begin
            seq = gen_item_seq::type_id::create("seq");
            seq.row_aux =  4'b0001; //1
            seq.col_aux = 4'b0101; //5
            seq.modo_aux = 1'b0;
            seq.src_aux = 4'b0100; //4
            seq.payload_aux = 4'b1100; //12
            seq.start(env.agt.seq[seq.src_aux]);
            #1;
        end

        // Reconfigure seq for the 13 sequence
        for (int i = 0; i < trans_cant; i++) begin
            seq = gen_item_seq::type_id::create("seq");
            seq.row_aux =  4'b0010; //2
            seq.col_aux = 4'b0101; //5
            seq.modo_aux = 1'b0;
            seq.src_aux = 4'b0100; //4
            seq.payload_aux = 4'b1101; //13
            seq.start(env.agt.seq[seq.src_aux]);
            #1;
        end

        // Reconfigure seq for the 14 sequence
        for (int i = 0; i < trans_cant; i++) begin
            seq = gen_item_seq::type_id::create("seq");
            seq.row_aux =  4'b0011; //3
            seq.col_aux = 4'b0101; //5
            seq.modo_aux = 1'b0;
            seq.src_aux = 4'b0100; //4
            seq.payload_aux = 4'b1110; //14
            seq.start(env.agt.seq[seq.src_aux]);
            #1;
        end

        // Reconfigure seq for the 15 sequence
        for (int i = 0; i < trans_cant; i++) begin
            seq = gen_item_seq::type_id::create("seq");
            seq.row_aux =  4'b0100; //4
            seq.col_aux = 4'b0101; //5
            seq.modo_aux = 1'b0;
            seq.src_aux = 4'b0100; //4
            seq.payload_aux = 4'b1111; //15
            seq.start(env.agt.seq[seq.src_aux]);
        end
            #100;

    `endif

    `ifdef TEST_SAME_DEST
        // Start the 1 sequence
        for (int i = 0; i < trans_cant; i++) begin
            seq = gen_item_seq::type_id::create("seq");
            seq.tipo = envio_spc;
            seq.row_aux =  4'b0100; //4
            seq.col_aux = 4'b0101; //5
            seq.modo_aux = 1'b0;
            seq.src_aux = 4'b0000; //0
            seq.payload_aux = 4'b0000; //0
            seq.start(env.agt.seq[seq.src_aux]);
            #1;
        end

        // Reconfigure seq for the 2 sequence
        for (int i = 0; i < trans_cant; i++) begin
            seq = gen_item_seq::type_id::create("seq");
            seq.row_aux =  4'b0100; //4
            seq.col_aux = 4'b0101; //5
            seq.modo_aux = 1'b0;
            seq.src_aux = 4'b0001; //1
            seq.payload_aux = 4'b0001; //1
            seq.start(env.agt.seq[seq.src_aux]);
            #1; 
        end

        // Reconfigure seq for the 3 sequence
        for (int i = 0; i < trans_cant; i++) begin
            seq.row_aux =  4'b0100; //4
            seq.col_aux = 4'b0101; //5
            seq.modo_aux = 1'b0;
            seq.src_aux = 4'b0010; //2
            seq.payload_aux = 4'b0010; //2
            seq.start(env.agt.seq[seq.src_aux]);
            #1; 
        end

        // Reconfigure seq for the 4 sequence
        for (int i = 0; i < trans_cant; i++) begin
            seq.row_aux =  4'b0100; //4
            seq.col_aux = 4'b0101; //5
            seq.modo_aux = 1'b0;
            seq.src_aux = 4'b0011; //3
            seq.payload_aux = 4'b0011; //3
            seq.start(env.agt.seq[seq.src_aux]);
            #1;
        end
        

        // Reconfigure seq for the 5 sequence
        for (int i = 0; i < trans_cant; i++) begin
            seq.row_aux =  4'b0100; //4
            seq.col_aux = 4'b0101; //5
            seq.modo_aux = 1'b0;
            seq.src_aux = 4'b0100; //4
            seq.payload_aux = 4'b0100; //4
            seq.start(env.agt.seq[seq.src_aux]);
            #1;
        end
        

        // Reconfigure seq for the 6 sequence
        for (int i = 0; i < trans_cant; i++) begin
            seq.row_aux =  4'b0100; //4
            seq.col_aux = 4'b0101; //5
            seq.modo_aux = 1'b0;
            seq.src_aux = 4'b0101; //5
            seq.payload_aux = 4'b0101; //5
            seq.start(env.agt.seq[seq.src_aux]);
            #1;
        end

        // Reconfigure seq for the 7 sequence
        for (int i = 0; i < trans_cant; i++) begin
            seq.row_aux =  4'b0100; //4
            seq.col_aux = 4'b0101; //5
            seq.modo_aux = 1'b0;
            seq.src_aux = 4'b0110; //6
            seq.payload_aux = 4'b0110; //6
            seq.start(env.agt.seq[seq.src_aux]);
            #1;
        end
        

        // Reconfigure seq for the 8 sequence
        for (int i = 0; i < trans_cant; i++) begin
            seq.row_aux =  4'b0100; //4
            seq.col_aux = 4'b0101; //5
            seq.modo_aux = 1'b0;
            seq.src_aux = 4'b0111; //7
            seq.payload_aux = 4'b0111; //7
            seq.start(env.agt.seq[seq.src_aux]);
            #1;
        end
        

        // Reconfigure seq for the 9 sequence
        for (int i = 0; i < trans_cant; i++) begin
            seq.row_aux =  4'b0100; //4
            seq.col_aux = 4'b0101; //5
            seq.modo_aux = 1'b0;
            seq.src_aux = 4'b1000; //8
            seq.payload_aux = 4'b1000; //8
            seq.start(env.agt.seq[seq.src_aux]);
            #1;
        end
        

        // Reconfigure seq for the 10 sequence
        for (int i = 0; i < trans_cant; i++) begin
            seq.row_aux =  4'b0100; //4
            seq.col_aux = 4'b0101; //5
            seq.modo_aux = 1'b0;
            seq.src_aux = 4'b1001; //9
            seq.payload_aux = 4'b1001; //9
            seq.start(env.agt.seq[seq.src_aux]);
            #1;
        end
        

        // Reconfigure seq for the 11 sequence
        for (int i = 0; i < trans_cant; i++) begin
            seq.row_aux =  4'b0100; //4
            seq.col_aux = 4'b0101; //5
            seq.modo_aux = 1'b0;
            seq.src_aux = 4'b1010; //10
            seq.payload_aux = 4'b1010; //10
            seq.start(env.agt.seq[seq.src_aux]);
            #1;
        end
        

        // Reconfigure seq for the 12 sequence
        for (int i = 0; i < trans_cant; i++) begin
            seq.row_aux =  4'b0100; //4
            seq.col_aux = 4'b0101; //5
            seq.modo_aux = 1'b0;
            seq.src_aux = 4'b1011; //11
            seq.payload_aux = 4'b1011; //11
            seq.start(env.agt.seq[seq.src_aux]);
            #1;
        end
        

        // Reconfigure seq for the 13 sequence
        for (int i = 0; i < trans_cant; i++) begin
            seq.row_aux =  4'b0100; //4
            seq.col_aux = 4'b0101; //5
            seq.modo_aux = 1'b0;
            seq.src_aux = 4'b1100; //12
            seq.payload_aux = 4'b1100; //12
            seq.start(env.agt.seq[seq.src_aux]);
            #1;
        end
        

        // Reconfigure seq for the 14 sequence
        for (int i = 0; i < trans_cant; i++) begin
            seq.row_aux =  4'b0100; //4
            seq.col_aux = 4'b0101; //5
            seq.modo_aux = 1'b0;
            seq.src_aux = 4'b1101; //13
            seq.payload_aux = 4'b1101; //13
            seq.start(env.agt.seq[seq.src_aux]);
            #1;
        end
        

        // Reconfigure seq for the 15 sequence
        for (int i = 0; i < trans_cant; i++) begin
            seq.row_aux =  4'b0100; //4
            seq.col_aux = 4'b0101; //5
            seq.modo_aux = 1'b0;
            seq.src_aux = 4'b1110; //14
            seq.payload_aux = 4'b1110; //14
            seq.start(env.agt.seq[seq.src_aux]);
        end
        #100; 

    `endif

    #10000;
    phase.drop_objection(this);
endtask

endclass
