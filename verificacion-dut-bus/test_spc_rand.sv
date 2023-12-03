// Here it is possiblle to set the test for the DUT
class test #(parameter bits      = 1,
             parameter drvrs     = 4,
             parameter pkg_sz    = 16,
             parameter fifo_dpth = 8,
             parameter broadcast = {8'b1});

    // pkg definition
    tipo_report instr_scb;  

    // parameters
    parameter transaccion_aleatoria  = 0;
    parameter cantidad_transacciones = 10;
    
    // Mailbox definition
    trans_mbx_tst_gen #(.pkg_sz(pkg_sz)) mbx_tst_gen; // Test - Generator
    trans_mbx_gen_agt #(.pkg_sz(pkg_sz)) mbx_gen_agt; // Generador - Agente
    trans_mbx_agt_drv #(.bits(bits), .drvrs(drvrs), .pkg_sz(pkg_sz)) mbx_agt_drv_array[drvrs]; // Agent - Driver
    trans_mbx_agt_scb #(.pkg_sz(pkg_sz)) mbx_agt_scb;                 // Agent - Scoreboard
    trans_mbx_tst_scb mbx_tst_scb;                                    // Test - Scoreboard
    trans_mbx_drv_mnt mbx_drv_mnt_array[drvrs];                       // Driver - Monitor 
    trans_mbx_mnt_chk #(.drvrs(drvrs), .pkg_sz(pkg_sz)) mbx_mnt_chk;  // Monitor - Checker
    trans_mbx_agt_chk mbx_agt_chk;                    // Agente -> Checker
    trans_mbx_chk_scb #(.pkg_sz(pkg_sz)) mbx_chk_scb; // Checker -> Scoreboard
    trans_mbx_scb_chk #(.pkg_sz(pkg_sz)) mbx_scb_chk; // Scoreboard -> Checker

    // Packages for communication
    pkg_tst_gen #(.pkg_sz(pkg_sz)) tst_gen_transaction;
    pkg_gen_agt #(.pkg_sz(pkg_sz)) gen_agt_transaction;
    
    // Environment call
    ambiente #(.bits(bits), 
               .drvrs(drvrs),
               .pkg_sz(pkg_sz),
               .broadcast(broadcast),
               .fifo_dpth(fifo_dpth)) amb;

    // Virtual interface que se conectará al DUT
    virtual if_dut #(.drvrs(drvrs),
                     .pkg_sz(pkg_sz),
                     .broadcast(broadcast)) bus_if;
    
    //Definición de las condiciones iniciales del test
    function new();
        // Mailboxes instances
        mbx_tst_gen = new();
        mbx_tst_scb = new();
        mbx_gen_agt = new();
        mbx_agt_chk = new();
        mbx_mnt_chk = new();
        mbx_chk_scb = new();
        mbx_scb_chk = new();

        for (int i = 0; i < drvrs; i++) begin
            automatic int k = i;
            mbx_drv_mnt_array[k] = new();
            mbx_agt_drv_array[k] = new();
        end  

        // Connection with environment
        amb        = new();
        amb.bus_if = bus_if; 
        // test generador
        amb.mbx_tst_gen     = mbx_tst_gen;
        amb.gen.mbx_tst_gen = mbx_tst_gen;
        // generador agente
        amb.mbx_gen_agt            = mbx_gen_agt;
        amb.gen.mbx_gen_agt        = mbx_gen_agt;
        amb.agent_inst.mbx_gen_agt = mbx_gen_agt;
        // agente checker
        amb.mbx_agt_chk            = mbx_agt_chk;
        amb.agent_inst.mbx_agt_chk = mbx_agt_chk;
        amb.chk.mbx_agt_chk        = mbx_agt_chk;
        // test scoreboard
        amb.mbx_tst_scb            = mbx_tst_scb;
        amb.scb_inst.mbx_tst_scb   = mbx_tst_scb;
        // scoreboard checker
        amb.mbx_scb_chk            = mbx_scb_chk;      
        amb.scb_inst.mbx_scb_chk   = mbx_scb_chk;
        amb.chk.mbx_scb_chk        = mbx_scb_chk;    
        // checker scoreboard
        amb.mbx_chk_scb            = mbx_chk_scb;
        amb.chk.mbx_chk_scb        = mbx_chk_scb;
        amb.scb_inst.mbx_chk_scb   = mbx_chk_scb;
        // generador aleatorizacion_transacciones 
        amb.gen.transaccion_aleatoria  = transaccion_aleatoria;
        amb.gen.cantidad_transacciones = cantidad_transacciones;

        for (int i = 0; i < drvrs; i++) begin
            automatic int k = i;
            // agente driver
            amb.mbx_agt_drv_array[k]            = mbx_agt_drv_array[k];
            amb.agent_inst.mbx_agt_drv_array[k] = mbx_agt_drv_array[k];
            amb.drv_array[k].mbx_agt_drv        = mbx_agt_drv_array[k];
            // driver monitor
	        amb.mbx_drv_mnt_array[k]     = mbx_drv_mnt_array[k];

            for (int j = 0; j < drvrs; j++)begin
                automatic int l = j; 
	            amb.drv_array[k].mbx_drv_mnt_array[l] = mbx_drv_mnt_array[l];
                amb.mnt_array[k].mbx_drv_mnt_array[l] = mbx_drv_mnt_array[l];
            end
            // monitor checker
            amb.mbx_mnt_chk              = mbx_mnt_chk;
            amb.chk.mbx_mnt_chk          = mbx_mnt_chk;
            amb.mnt_array[k].mbx_mnt_chk = mbx_mnt_chk;
        end
    endfunction

    // Debug print
    function void print;
        $write("[%g] El test envia una prueba: ", $time);
        tst_gen_transaction.print();
    endfunction

    // This tasks implements all what the test can do
    task run();
        $display("[%g] El test se inicializa", $time);
        fork
            amb.run(); // Executes run() task
        join_none

        tst_gen_transaction = new();
        gen_agt_transaction = new();
        tst_gen_transaction.data = 'h3401;
        tst_gen_transaction.id_ident = 'h02;
        tst_gen_transaction.tipo = envio_spcf_rand;
        mbx_tst_gen.put(tst_gen_transaction);
        this.print();

        instr_scb = reporte;
        // instr_scb = retraso_promedio;
        mbx_tst_scb.put(instr_scb);

        #15000;
        $finish;
    endtask

endclass
