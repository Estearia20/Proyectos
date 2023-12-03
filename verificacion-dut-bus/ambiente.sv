// This class takes the task of connecting mbx from all around the
// environment, basically it sets the environment
class ambiente #(parameter bits      = 1,
                 parameter drvrs     = 4,
                 parameter pkg_sz    = 16,
                 parameter fifo_dpth = 8,
                 parameter broadcast = {8{1'b1}});
                     
    // Create objects instances
    driver     #(.drvrs(drvrs), .pkg_sz(pkg_sz), .broadcast(broadcast), .fifo_dpth(fifo_dpth)) drv_array[drvrs];
    monitor    #(.drvrs(drvrs), .pkg_sz(pkg_sz), .broadcast(broadcast), .fifo_dpth(fifo_dpth)) mnt_array[drvrs];
    agente     #(.drvrs(drvrs), .pkg_sz(pkg_sz), .broadcast(broadcast)) agent_inst;
    scoreboard #(.drvrs(drvrs), .pkg_sz(pkg_sz), .broadcast(broadcast)) scb_inst;
    generator  #(.drvrs(drvrs), .pkg_sz(pkg_sz), .broadcast(broadcast)) gen;
    checker    #(.drvrs(drvrs), .pkg_sz(pkg_sz), .broadcast(broadcast)) chk; 

    // DUT instance
    virtual if_dut #(.drvrs(drvrs),
                     .pkg_sz(pkg_sz),
                     .broadcast(broadcast)) bus_if;

    // Mailboxes declaration
    trans_mbx_drv_mnt mbx_drv_mnt_array[drvrs]; // Driver -> Monitor
    trans_mbx_agt_drv #(.bits(bits), .drvrs(drvrs), .pkg_sz(pkg_sz)) mbx_agt_drv_array[drvrs]; // Agente -> Driver
    trans_mbx_mnt_chk #(.drvrs(drvrs), .pkg_sz(pkg_sz)) mbx_mnt_chk; // Monitor -> Checker
    trans_mbx_tst_gen #(.pkg_sz(pkg_sz)) mbx_tst_gen; // Test -> Generador
    trans_mbx_tst_scb mbx_tst_scb; // Test -> Scoreboard
    trans_mbx_gen_agt #(.pkg_sz(pkg_sz)) mbx_gen_agt; // Generador -> Agente
    trans_mbx_agt_chk mbx_agt_chk; // Agente -> Checker
    trans_mbx_agt_scb #(.pkg_sz(pkg_sz)) mbx_agt_scb; // Agente -> Scoreboard
    trans_mbx_chk_scb #(.pkg_sz(pkg_sz)) mbx_chk_scb; // Checker -> Scoreboard
    trans_mbx_scb_chk #(.pkg_sz(pkg_sz)) mbx_scb_chk; // Scoreboard -> Checker
    
    
    function new();
        // Initialize mailboxes
        for (int i = 0; i < drvrs; i++) begin
            automatic int k = i;
            mbx_drv_mnt_array[k] = new();
            mbx_agt_drv_array[k] = new();
        end
        mbx_tst_gen = new();
        mbx_gen_agt = new();
        mbx_chk_scb = new(); 
        mbx_agt_chk = new();
        mbx_mnt_chk = new();
        mbx_tst_scb = new();
        mbx_agt_scb = new();
        mbx_scb_chk = new();

        // Initialize modules
        agent_inst  = new();
        gen         = new();
        chk         = new();
        scb_inst    = new();

        // Connecting virtual interfaces
        // Connects multiples driver interfaces and mbx, depending on drvrs
        for (int i = 0; i < drvrs; i++) begin
            automatic int k = i;
            // DRIVER
            drv_array[k] = new();
            drv_array[k].terminal = k;
            drv_array[k].vif = bus_if;
            for(int j = 0 ; j < drvrs; j++)begin
                automatic int l = j;
                drv_array[k].mbx_drv_mnt_array[l] = mbx_drv_mnt_array[l];
            end
            drv_array[k].mbx_agt_drv = mbx_agt_drv_array[k];
            // MONITOR
            mnt_array[k] = new();
            mnt_array[k].terminal = k;
            mnt_array[k].bus_if = bus_if;
            for(int u = 0 ; u < drvrs; u++)begin
                automatic int h = u;
                mnt_array[k].mbx_drv_mnt_array[h] = mbx_drv_mnt_array[h];
            end
            mnt_array[k].mbx_mnt_chk = mbx_mnt_chk;
            // AGENTE
            agent_inst.mbx_agt_drv_array[k] = mbx_agt_drv_array[k];
            // CHECKER
            chk.mbx_mnt_chk = mbx_mnt_chk;
        end

        agent_inst.bus_if   = bus_if; 
        gen.bus_if          = bus_if;
              
        // Connecting mailboxes
        agent_inst.mbx_gen_agt  = mbx_gen_agt;
        agent_inst.mbx_agt_scb  = mbx_agt_scb;
        scb_inst.mbx_agt_scb    = mbx_agt_scb;
        scb_inst.mbx_tst_scb    = mbx_tst_scb;
        gen.mbx_tst_gen         = mbx_tst_gen;
        gen.mbx_gen_agt         = mbx_gen_agt;
        agent_inst.mbx_agt_chk  = mbx_agt_chk;
        chk.mbx_agt_chk         = mbx_agt_chk;
        chk.mbx_chk_scb         = mbx_chk_scb;
        scb_inst.mbx_chk_scb    = mbx_chk_scb;
        chk.mbx_scb_chk         = mbx_scb_chk;
        scb_inst.mbx_scb_chk    = mbx_scb_chk;
    endfunction

    virtual task run();
        $display("[%g] El ambiente se inicializa", $time);
        // Creates child threads for every mnt and drv instance
        fork
            gen.run();
            agent_inst.run();
            scb_inst.run();
            scb_inst.run_rep();
            for (int i = 0; i < drvrs; i++) begin
                automatic int k = i;
                fork
                    drv_array[k].run();
                join_none
            end
            for (int i = 0; i < drvrs; i++) begin
                automatic int k = i;
                fork
                    mnt_array[k].run();
                join_none
            end
            chk.run();
        join_none
    endtask
endclass
