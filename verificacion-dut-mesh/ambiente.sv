// This class connects all the componentes that are part of the layered
// testbench
class ambiente #(parameter pckg_sz   = 25,
                 parameter fifo_dpth = 8);

    // Creates components handlers
    driver #(.pckg_sz(pckg_sz), .fifo_dpth(fifo_dpth)) drv_array[16];
    agente #(.pckg_sz(pckg_sz), .fifo_dpth(fifo_dpth)) agt;
    scoreboard #(.pckg_sz(pckg_sz), .fifo_dpth(fifo_dpth)) scb;
    generator #(.pckg_sz(pckg_sz), .fifo_dpth(fifo_dpth)) gen;
    monitor #(.pckg_sz(pckg_sz)) mnt_array[16];
    checker #(.pckg_sz(pckg_sz), .fifo_dpth(fifo_dpth)) chk;
    
    // Virtual interface, this is used for connecting with DUT
    virtual if_dut #(.pckg_sz(pckg_sz)) vif;
      
    // Mailboxes declaration
    trans_mbx #(.pckg_sz(pckg_sz)) mbx_gen_agt;     	  // Generator -> Agent
    trans_mbx #(.pckg_sz(pckg_sz)) mbx_agt_drv[16]; 	  // Agent -> Driver
    trans_mbx #(.pckg_sz(pckg_sz)) mbx_agt_scb;     	  // Agent -> Scoreboard
    trans_2_mbx #(.pckg_sz(pckg_sz)) mbx_mnt_chk;   	  // Monitor -> Checker
    trans_mbx #(.pckg_sz(pckg_sz)) mbx_tst_gen;     	  // Test -> Generator
    trans_mbx #(.pckg_sz(pckg_sz)) mbx_scb_chk;     	  // Scoreboard -> Checker
    trans_mbx_chk_scb #(.pckg_sz(pckg_sz)) mbx_chk_scb;   // Checker -> Scoreboard
    trans_mbx_tst_scb mbx_tst_scb;     					  // Test -> Scoreboard
    
    function new();
        // Initialize mailboxes
        for(int i = 0; i < 16; i++) begin
            mbx_agt_drv[i] = new();
        end
        mbx_gen_agt = new();
        mbx_agt_scb = new();
        mbx_mnt_chk = new();
        mbx_tst_gen = new();
        mbx_scb_chk = new();
        mbx_chk_scb = new();
        mbx_tst_scb = new();

        // Initialize modules
	    agt = new();
        gen = new();
        scb = new();
        chk = new();

        // Creates drivers objects, each with a different value for terminal,
        // and each one is connected to the respective interface
        for(int i = 0; i < 16; i++) begin
            automatic int k = i;
            drv_array[k]          = new();
            drv_array[k].terminal = k;
            drv_array[k].vif      = vif;
	        agt.mbx_agt_drv[k]    = mbx_agt_drv[k];
        end
        
        // Creates monitor objects, each with a different terminal value, and
        // each of them is connected to the respective interface
        for(int i = 0; i < 16; i++) begin
            automatic int k = i;
            mnt_array[k]             = new();
            mnt_array[k].terminal    = k;
            mnt_array[k].vif         = vif;
            mnt_array[k].mbx_mnt_chk = mbx_mnt_chk;
        end
        // Connecting mailboxes
        agt.mbx_gen_agt  = mbx_gen_agt;
        agt.mbx_agt_scb  = mbx_agt_scb;
        gen.mbx_tst_gen  = mbx_tst_gen;
        gen.mbx_gen_agt  = mbx_gen_agt;
        scb.mbx_agt_scb  = mbx_agt_scb;
        scb.mbx_tst_scb  = mbx_tst_scb;
        scb.mbx_scb_chk  = mbx_scb_chk;
        scb.mbx_chk_scb  = mbx_chk_scb;
        chk.mbx_chk_scb  = mbx_chk_scb;
        chk.mbx_scb_chk  = mbx_scb_chk;
      	chk.mbx_mnt_chk  = mbx_mnt_chk;
    endfunction

    virtual task run();
        `ifdef DEBUG_BUILD
            $display("[%g] El ambiente se inicia", $time);
        `endif
        // Creates al the child threads that the environment requires
        fork

            // Creates child threads for drivers
            for(int i = 0; i < 16; i++) begin
                automatic int k = i;
                fork
                    drv_array[k].run();
                join_none
            end

            // Creates child threads for monitors
            for (int i = 0; i < 16; i++) begin
                automatic int k = i;
                fork
                    mnt_array[k].run();
                join_none
            end

            gen.run();
	        agt.run();
            scb.run();
            scb.run_rep();
            chk.run();
          	chk.dut_signals();
        join_none
    endtask
endclass
