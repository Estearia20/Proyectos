// This class makes it possible to generate stimulus for the DUT, basically it
// will tell the generator what test should do
class test #(parameter pckg_sz = 25, parameter fifo_dpth = 8);

    // Parameters for transactions
    parameter transaccion_aleatoria  = 0;
    parameter cantidad_transacciones = 10;

    // Mailboxes declaration
  	trans_mbx #(.pckg_sz(pckg_sz)) mbx_gen_agt;     	  // Generator -> Agent
  	trans_mbx #(.pckg_sz(pckg_sz)) mbx_agt_drv[16]; 	  // Agent -> Driver
  	trans_mbx #(.pckg_sz(pckg_sz)) mbx_agt_scb;     	  // Agent -> Scoreboard
  	trans_2_mbx #(.pckg_sz(pckg_sz)) mbx_mnt_chk;   	  // Monitor -> Checker
  	trans_mbx #(.pckg_sz(pckg_sz)) mbx_tst_gen;     	  // Test -> Generator
  	trans_mbx #(.pckg_sz(pckg_sz)) mbx_scb_chk;     	  // Scoreboard -> Checker
    trans_mbx_chk_scb #(.pckg_sz(pckg_sz)) mbx_chk_scb;   // Checker -> Scoreboard
    trans_mbx_tst_scb  mbx_tst_scb;     				  // Test -> Scoreboard


    // Packages for sending information
    pkg_trans #(.pckg_sz(pckg_sz)) transaction;
    report instr_scb;  

    // Environment instance
    ambiente #(.pckg_sz(pckg_sz), .fifo_dpth(fifo_dpth)) amb;

    // Virtual interface, this is used for connecting with DUT
    virtual if_dut #(.pckg_sz(pckg_sz)) vif;
  
    // Connects all mailboxes and interfaces
    function new();

        // Starts each mbx
        mbx_gen_agt = new();
        mbx_agt_scb = new();
        mbx_mnt_chk = new();
        mbx_tst_gen = new();
        mbx_scb_chk = new();
        mbx_chk_scb = new();
        mbx_tst_scb = new();
      
        // ENVIRONMENT
        amb     = new();
        amb.vif = vif;

        // This for generates all the mbx_agt_drv
        for(int i = 0; i < 16; i++) begin
            mbx_agt_drv[i] = new();
            amb.agt.mbx_agt_drv[i] = mbx_agt_drv[i];
        end

        // AGENT - DRIVER
        for(int i = 0; i < 16; i++) begin
            amb.mbx_agt_drv[i]           = mbx_agt_drv[i];
            amb.drv_array[i].mbx_agt_drv = mbx_agt_drv[i];
        end
      

        // TEST - GENERATOR
        amb.mbx_tst_gen     = mbx_tst_gen;
        amb.gen.mbx_tst_gen = mbx_tst_gen;

        // GENERATOR - AGENT
        amb.mbx_gen_agt     = mbx_gen_agt;
        amb.gen.mbx_gen_agt = mbx_gen_agt;
        amb.agt.mbx_gen_agt = mbx_gen_agt;

        // GENERATOR - SCOREBOARD
        amb.agt.mbx_gen_agt = mbx_gen_agt;

        // AGENT - SCOREBOARD
        amb.agt.mbx_agt_scb = mbx_agt_scb;
		amb.scb.mbx_agt_scb = mbx_agt_scb;

        // MONITOR - CHECKER
        amb.mbx_mnt_chk = mbx_mnt_chk;
      	amb.chk.mbx_mnt_chk = mbx_mnt_chk;
        for(int i = 0; i < 16; i++) begin
            automatic int k = i;
            amb.mnt_array[k].mbx_mnt_chk = mbx_mnt_chk;
        end

         // TEST - SCOREBOARD
        amb.mbx_tst_scb            = mbx_tst_scb;
        amb.scb.mbx_tst_scb   = mbx_tst_scb;

        // SCOREBOARD - CHECKER
        amb.mbx_scb_chk            = mbx_scb_chk;      
        amb.scb.mbx_scb_chk   	   = mbx_scb_chk;
        amb.chk.mbx_scb_chk        = mbx_scb_chk;    
        
        // checker scoreboard
        amb.mbx_chk_scb            = mbx_chk_scb;
        amb.chk.mbx_chk_scb        = mbx_chk_scb;
        amb.scb.mbx_chk_scb   = mbx_chk_scb;

        // Randomization transactions generator
        amb.gen.transaccion_aleatoria  = transaccion_aleatoria;
        amb.gen.cantidad_transacciones = cantidad_transacciones;

    endfunction

    // Sets the test and starts the environment run task
    virtual task run();
        `ifdef DEBUG_BUILD
            $display("[%g] El test se inicia", $time);
        `endif
        fork
            amb.run();
        join_none

        // This test pretends to send from the same interface to the rest of the interfaces
        `ifdef TEST_MSRC_DTAR
            #10;
            transaction = new();
            transaction.tipo = envio_spc;
            amb.gen.modo_aux = 1'b0;
            amb.gen.row_aux = 4'b0000;  //0 
            amb.gen.col_aux = 4'b0001;  //1
            amb.gen.src_aux = 4'b0100;  //4
            amb.gen.payload_aux = 4'b0000;
            mbx_tst_gen.put(transaction);
            #1;
    
            transaction = new();
            transaction.tipo = envio_spc;
            amb.gen.modo_aux = 1'b0;
            amb.gen.row_aux = 4'b0000;  //0 
            amb.gen.col_aux = 4'b0010;  //2
            amb.gen.src_aux = 4'b0100;  //4
            amb.gen.payload_aux = 4'b0001;
            mbx_tst_gen.put(transaction);
            #1;
    
            transaction = new();
            transaction.tipo = envio_spc;
            amb.gen.modo_aux = 1'b0;
            amb.gen.row_aux = 4'b0000;  //0 
            amb.gen.col_aux = 4'b0011;  //3
            amb.gen.src_aux = 4'b0100;  //4
            amb.gen.payload_aux = 4'b0010;
            mbx_tst_gen.put(transaction);
            #1;
         
            transaction = new();
            transaction.tipo = envio_spc;
            amb.gen.modo_aux = 1'b0;
            amb.gen.row_aux = 4'b0000;  //1 
            amb.gen.col_aux = 4'b0100;  //0
            amb.gen.src_aux = 4'b0100;  //4
            amb.gen.payload_aux = 4'b0011;
            mbx_tst_gen.put(transaction);
            #1;
    
            transaction = new();
            transaction.tipo = envio_spc;
            amb.gen.modo_aux = 1'b0;
            amb.gen.row_aux = 4'b0010;  //2 
            amb.gen.col_aux = 4'b0000;  //0
            amb.gen.src_aux = 4'b0100;  //4
            amb.gen.payload_aux = 4'b0100;
            mbx_tst_gen.put(transaction);
            #1;
    
            transaction = new();
            transaction.tipo = envio_spc;
            amb.gen.modo_aux = 1'b0;
            amb.gen.row_aux = 4'b0011;  //3 
            amb.gen.col_aux = 4'b0000;  //0
            amb.gen.src_aux = 4'b0100;  //4
            amb.gen.payload_aux = 4'b0101;
            mbx_tst_gen.put(transaction);
            #1;
            
            transaction = new();
            transaction.tipo = envio_spc;
            amb.gen.modo_aux = 1'b0;
            amb.gen.row_aux = 4'b0100;  //4 
            amb.gen.col_aux = 4'b0000;  //0
            amb.gen.src_aux = 4'b0100;  //4
            amb.gen.payload_aux = 4'b0110;
            mbx_tst_gen.put(transaction);
            #1;
            
            transaction = new();
            transaction.tipo = envio_spc;
            amb.gen.modo_aux = 1'b0;
            amb.gen.row_aux = 4'b0101;  //5 
            amb.gen.col_aux = 4'b0001;  //1
            amb.gen.src_aux = 4'b0100;  //4
            amb.gen.payload_aux = 4'b0111;
            mbx_tst_gen.put(transaction);
            #1;
            
            transaction = new();
            transaction.tipo = envio_spc;
            amb.gen.modo_aux = 1'b0;
            amb.gen.row_aux = 4'b0101;  //5 
            amb.gen.col_aux = 4'b0010;  //2
            amb.gen.src_aux = 4'b0100;  //4
            amb.gen.payload_aux = 4'b1000;
            mbx_tst_gen.put(transaction);
            #1;
            
            transaction = new();
            transaction.tipo = envio_spc;
            amb.gen.modo_aux = 1'b0;
            amb.gen.row_aux = 4'b0101;  //5 
            amb.gen.col_aux = 4'b0011;  //3
            amb.gen.src_aux = 4'b0100;  //4
            amb.gen.payload_aux = 4'b1001;
            mbx_tst_gen.put(transaction);
            #1;
            
            transaction = new();
            transaction.tipo = envio_spc;
            amb.gen.modo_aux = 1'b0;
            amb.gen.row_aux = 4'b0101;  //5 
            amb.gen.col_aux = 4'b0100;  //4
            amb.gen.src_aux = 4'b0100;  //4
            amb.gen.payload_aux = 4'b1010;
            mbx_tst_gen.put(transaction);
            #1;
            
            transaction = new();
            transaction.tipo = envio_spc;
            amb.gen.modo_aux = 1'b0;
            amb.gen.row_aux = 4'b0001;  //1 
            amb.gen.col_aux = 4'b0101;  //5
            amb.gen.src_aux = 4'b0100;  //4
            amb.gen.payload_aux = 4'b1100;
            mbx_tst_gen.put(transaction);
            #1;
            
            transaction = new();
            transaction.tipo = envio_spc;
            amb.gen.modo_aux = 1'b0;
            amb.gen.row_aux = 4'b0010;  //2 
            amb.gen.col_aux = 4'b0101;  //5
            amb.gen.src_aux = 4'b0100;  //4
            amb.gen.payload_aux = 4'b1101;
            mbx_tst_gen.put(transaction);
            #1;
            
            transaction = new();
            transaction.tipo = envio_spc;
            amb.gen.modo_aux = 1'b0;
            amb.gen.row_aux = 4'b0011;  //3 
            amb.gen.col_aux = 4'b0101;  //5
            amb.gen.src_aux = 4'b0100;  //4
            amb.gen.payload_aux = 4'b1110;
            mbx_tst_gen.put(transaction);
            #1;
            
            transaction = new();
            transaction.tipo = envio_spc;
            amb.gen.modo_aux = 1'b0;
            amb.gen.row_aux = 4'b0100;  //4 
            amb.gen.col_aux = 4'b0101;  //5
            amb.gen.src_aux = 4'b0100;  //4
            amb.gen.payload_aux = 4'b1111;
            mbx_tst_gen.put(transaction);
            #1;
        `endif

        // This test pretends to send the same content (source and target) but with a different mode
        `ifdef TEST_MODO
            #10;
            transaction = new();
            transaction.tipo = envio_spc;
            amb.gen.modo_aux = 1'b1;
            amb.gen.row_aux = 4'b0100;  //4 
            amb.gen.col_aux = 4'b0101;  //5
            amb.gen.src_aux = 4'b0100;  //4
            amb.gen.payload_aux = 4'b1010;
            mbx_tst_gen.put(transaction);
            #1;
            
            transaction = new();
            transaction.tipo = envio_spc;
            amb.gen.modo_aux = 1'b0;
            amb.gen.row_aux = 4'b0100;  //4 
            amb.gen.col_aux = 4'b0101;  //5
            amb.gen.src_aux = 4'b0100;  //4
            amb.gen.payload_aux = 4'b0101;
            mbx_tst_gen.put(transaction);
        `endif

        // This test pretends to send a random amount of random instructions
        // for this one it is required to change the amount of instructions at
        // top
        `ifdef TEST_INSTR_RDM
            transaction = new();
            transaction.tipo = envio_rdm;
            mbx_tst_gen.put(transaction);
        `endif

        // This test pretends to sent some random instructions while making resets
        `ifdef TEST_RST
            transaction = new();
            transaction.tipo = envio_rdm;
            mbx_tst_gen.put(transaction);
            
            transaction = new();
            transaction.tipo = envio_rdm;
            mbx_tst_gen.put(transaction);

            transaction = new();
            transaction.tipo = reset_type;
            mbx_tst_gen.put(transaction);
            
            transaction = new();
            transaction.tipo = envio_rdm;
            mbx_tst_gen.put(transaction);
            
            transaction = new();
            transaction.tipo = envio_rdm;
            mbx_tst_gen.put(transaction);

            transaction = new();
            transaction.tipo = reset_type;
            mbx_tst_gen.put(transaction);
            
            transaction = new();
            transaction.tipo = envio_rdm;
            mbx_tst_gen.put(transaction);

            transaction = new();
            transaction.tipo = reset_type;
            mbx_tst_gen.put(transaction);

            transaction = new();
            transaction.tipo = envio_rdm;
            mbx_tst_gen.put(transaction);
            
            transaction = new();
            transaction.tipo = envio_rdm;
            mbx_tst_gen.put(transaction);
        `endif

        // This test pretends to send to a terminal that does not exists
        `ifdef TEST_NO_EXISTE
            transaction = new();
            transaction.tipo = envio_spc;
            amb.gen.modo_aux = 1'b0;
            amb.gen.row_aux = 4'b0110;  //6 
            amb.gen.col_aux = 4'b0000;  //0
            amb.gen.src_aux = 4'b0100;  //4
            amb.gen.payload_aux = 4'b1111;
            mbx_tst_gen.put(transaction);
        `endif

        // This test pretends to send multiple instructions to the same terminal, from every other device
        `ifdef TEST_SAME_DEST
            #10;
            transaction = new();
            transaction.tipo = envio_spc;
            amb.gen.modo_aux = 1'b0;
            amb.gen.row_aux = 4'b0100;  //4 
            amb.gen.col_aux = 4'b0101;  //5
            amb.gen.src_aux = 4'b0000;  //0
            amb.gen.payload_aux = 4'b0000;
            mbx_tst_gen.put(transaction);
            #1;
            
            transaction = new();
            transaction.tipo = envio_spc;
            amb.gen.modo_aux = 1'b0;
            amb.gen.row_aux = 4'b0100;  //4 
            amb.gen.col_aux = 4'b0101;  //5
            amb.gen.src_aux = 4'b0001;  //1
            amb.gen.payload_aux = 4'b0001;
            mbx_tst_gen.put(transaction);
            #1;

            transaction = new();
            transaction.tipo = envio_spc;
            amb.gen.modo_aux = 1'b0;
            amb.gen.row_aux = 4'b0100;  //4 
            amb.gen.col_aux = 4'b0101;  //5
            amb.gen.src_aux = 4'b0010;  //2
            amb.gen.payload_aux = 4'b0010;
            mbx_tst_gen.put(transaction);
            #1;

            transaction = new();
            transaction.tipo = envio_spc;
            amb.gen.modo_aux = 1'b0;
            amb.gen.row_aux = 4'b0100;  //4 
            amb.gen.col_aux = 4'b0101;  //5
            amb.gen.src_aux = 4'b0011;  //3
            amb.gen.payload_aux = 4'b0011;
            mbx_tst_gen.put(transaction);
            #1;

            transaction = new();
            transaction.tipo = envio_spc;
            amb.gen.modo_aux = 1'b0;
            amb.gen.row_aux = 4'b0100;  //4 
            amb.gen.col_aux = 4'b0101;  //5
            amb.gen.src_aux = 4'b0100;  //4
            amb.gen.payload_aux = 4'b0100;
            mbx_tst_gen.put(transaction);
            #1;

            transaction = new();
            transaction.tipo = envio_spc;
            amb.gen.modo_aux = 1'b0;
            amb.gen.row_aux = 4'b0100;  //4 
            amb.gen.col_aux = 4'b0101;  //5
            amb.gen.src_aux = 4'b0101;  //5
            amb.gen.payload_aux = 4'b00101;
            mbx_tst_gen.put(transaction);
            #1;

            transaction = new();
            transaction.tipo = envio_spc;
            amb.gen.modo_aux = 1'b0;
            amb.gen.row_aux = 4'b0100;  //4 
            amb.gen.col_aux = 4'b0101;  //5
            amb.gen.src_aux = 4'b0110;  //6
            amb.gen.payload_aux = 4'b0110;
            mbx_tst_gen.put(transaction);
            #1;

            transaction = new();
            transaction.tipo = envio_spc;
            amb.gen.modo_aux = 1'b0;
            amb.gen.row_aux = 4'b0100;  //4 
            amb.gen.col_aux = 4'b0101;  //5
            amb.gen.src_aux = 4'b0111;  //7
            amb.gen.payload_aux = 4'b0111;
            mbx_tst_gen.put(transaction);
            #1;

            transaction = new();
            transaction.tipo = envio_spc;
            amb.gen.modo_aux = 1'b0;
            amb.gen.row_aux = 4'b0100;  //4 
            amb.gen.col_aux = 4'b0101;  //5
            amb.gen.src_aux = 4'b1000;  //8
            amb.gen.payload_aux = 4'b1000;
            mbx_tst_gen.put(transaction);
            #1;

            transaction = new();
            transaction.tipo = envio_spc;
            amb.gen.modo_aux = 1'b0;
            amb.gen.row_aux = 4'b0100;  //4 
            amb.gen.col_aux = 4'b0101;  //5
            amb.gen.src_aux = 4'b1001;  //9
            amb.gen.payload_aux = 4'b1001;
            mbx_tst_gen.put(transaction);
            #1;

            transaction = new();
            transaction.tipo = envio_spc;
            amb.gen.modo_aux = 1'b0;
            amb.gen.row_aux = 4'b0100;  //4 
            amb.gen.col_aux = 4'b0101;  //5
            amb.gen.src_aux = 4'b1010;  //10
            amb.gen.payload_aux = 4'b1010;
            mbx_tst_gen.put(transaction);
            #1;

            transaction = new();
            transaction.tipo = envio_spc;
            amb.gen.modo_aux = 1'b0;
            amb.gen.row_aux = 4'b0100;  //4 
            amb.gen.col_aux = 4'b0101;  //5
            amb.gen.src_aux = 4'b1011;  //11
            amb.gen.payload_aux = 4'b1011;
            mbx_tst_gen.put(transaction);
            #1;

            transaction = new();
            transaction.tipo = envio_spc;
            amb.gen.modo_aux = 1'b0;
            amb.gen.row_aux = 4'b0100;  //4 
            amb.gen.col_aux = 4'b0101;  //5
            amb.gen.src_aux = 4'b1100;  //12
            amb.gen.payload_aux = 4'b1100;
            mbx_tst_gen.put(transaction);
            #1;

            transaction = new();
            transaction.tipo = envio_spc;
            amb.gen.modo_aux = 1'b0;
            amb.gen.row_aux = 4'b0100;  //4 
            amb.gen.col_aux = 4'b0101;  //5
            amb.gen.src_aux = 4'b1101;  //13
            amb.gen.payload_aux = 4'b1101;
            mbx_tst_gen.put(transaction);
            #1;

            transaction = new();
            transaction.tipo = envio_spc;
            amb.gen.modo_aux = 1'b0;
            amb.gen.row_aux = 4'b0100;  //4 
            amb.gen.col_aux = 4'b0101;  //5
            amb.gen.src_aux = 4'b1110;  //14
            amb.gen.payload_aux = 4'b1110;
            mbx_tst_gen.put(transaction);
            #1;
        `endif

        instr_scb = reporte;
        // instr_scb = retraso;
        mbx_tst_scb.put(instr_scb);
 
    endtask
endclass
